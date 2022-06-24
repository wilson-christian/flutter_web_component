import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'exception.dart';

class Api {
  late Dio dio;

  Api() {
    dio = Dio(
      BaseOptions(
        //baseUrl: "https://us-central1-clever-fm-dev.cloudfunctions.net",
        baseUrl: 'https://wilsondemo.free.beeceptor.com/',
        // baseUrl: 'https://dog.ceo/api/breeds/image/'
        //followRedirects: true, // true so `maxRedirects` works
        //maxRedirects: 10, // default : 5
      ),
    );

    // log http calls only in debug mode
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, requestHandler) async {
      // final idToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImY5MGZiMWFlMDQ4YTU0OGZiNjgxYWQ2MDkyYjBiODY5ZWE0NjdhYzYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vY2xldmVyLWZtLWRldiIsImF1ZCI6ImNsZXZlci1mbS1kZXYiLCJhdXRoX3RpbWUiOjE2NTM0ODQ1NjQsInVzZXJfaWQiOiJiVXFmQTI2a1U2UVV0Y0Fhbk41RU1MSno5bjIzIiwic3ViIjoiYlVxZkEyNmtVNlFVdGNBYW5ONUVNTEp6OW4yMyIsImlhdCI6MTY1NTkxOTExMywiZXhwIjoxNjU1OTIyNzEzLCJlbWFpbCI6ImFqY2lxQHRlc3QuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbImFqY2lxQHRlc3QuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.kIGQkFob4yxW1-fvit30XR9B7ujOYjyDrgIitIed_0daHvA0lkSMCj9-SVOyKyjjIsoS79ZkG8_3inC9ja2-zWgPYw8l7fLILWkuSmHgNohgXHTf_Wm3hhuc53dkQbtqygJpHBQovcptfx56DvXQdHUNL0YawVaGnKwnylcVtwpiewdschwiNlMLI8wwo5UOO_2qy_V4g-n_WM_axQnyXZAgR0_Or_Jm5IkGZrT6g8Rg8gofhmVjzx8v0HsO7e2GmqKmQXRlo9dkOLDw53B_PoAsOnwl7RoiavUagVbIMv7pgFIGYT8OaFkiLvvM1zzO0hBt_x3B7HfCm4oEmL42aw";
      // // options.headers['Authorization'] = 'Bearer $idToken';
      // requestHandler.next(options);
    }));

    // Not catching global errors as it prevents to identify
    // respective errors for each api calls
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(receiveTimeout: 60000),
      );

      _logRequestError(response.data, url);

      return response;
    } on DioError catch (error, stackTrace) {
      interceptApiErrors(
        error.message,
        stackTrace,
        queryParameters: queryParameters,
        url: url,
        statusCode: error.response?.statusCode ?? -1,
      );
      throw ServerException(error.response!.statusCode, error.error.toString());
    } catch (error, stackTrace) {
      interceptApiErrors(
        error.toString(),
        stackTrace,
        queryParameters: queryParameters,
        url: url,
        statusCode: -2,
      );
      throw ServerException(500, error.toString());
    }
  }

  Future<Response> post(String url,
      {Map<String, dynamic>? queryParameters, dynamic data}) async {
    try {
      final Response response = await dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(receiveTimeout: 60000),
      );

      _logRequestError(response.data, url);

      return response;
    } on DioError catch (error, stackTrace) {
      interceptApiErrors(
        error.message,
        stackTrace,
        queryParameters: queryParameters,
        url: url,
        statusCode: error.response?.statusCode ?? -1,
      );
      throw ServerException(error.response!.statusCode, error.error.toString());
    } catch (error, stackTrace) {
      interceptApiErrors(
        error.toString(),
        stackTrace,
        queryParameters: queryParameters,
        url: url,
        statusCode: -2,
      );
      throw ServerException(500, error.toString());
    }
  }

  Future<Response> put(String url,
      {Map<String, dynamic>? queryParameters, dynamic data}) async {
    try {
      final Response response = await dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(receiveTimeout: 60000),
      );

      _logRequestError(response.data, url);

      return response;
    } on DioError catch (error, stackTrace) {
      interceptApiErrors(
        error.message,
        stackTrace,
        queryParameters: queryParameters,
        url: url,
        statusCode: error.response?.statusCode ?? -1,
      );
      throw ServerException(error.response!.statusCode, error.error.toString());
    } catch (error, stackTrace) {
      interceptApiErrors(
        error.toString(),
        stackTrace,
        queryParameters: queryParameters,
        url: url,
        statusCode: -2,
      );
      throw ServerException(500, error.toString());
    }
  }

  Future<Response> delete(String url,
      {Map<String, dynamic>? queryParameters, dynamic data}) async {
    try {
      final Response response = await dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(receiveTimeout: 60000),
      );

      _logRequestError(response.data, url);

      return response;
    } on DioError catch (error, stackTrace) {
      interceptApiErrors(
        error.message,
        stackTrace,
        queryParameters: queryParameters,
        url: url,
        statusCode: error.response?.statusCode ?? -1,
      );
      throw ServerException(error.response!.statusCode, error.error.toString());
    } catch (error, stackTrace) {
      interceptApiErrors(
        error.toString(),
        stackTrace,
        queryParameters: queryParameters,
        url: url,
        statusCode: -2,
      );
      throw ServerException(500, error.toString());
    }
  }

  void interceptApiErrors(
    String error,
    StackTrace stackTrace, {
    required Map<String, dynamic>? queryParameters,
    required String url,
    required dynamic statusCode,
  }) {
    if (kDebugMode) {
      //showSnackBar(error);
    } else {
      //showSnackBar('unexpected_error'.tr);
    }

    String errorMessage = "URL : $url";

    if (queryParameters?.isNotEmpty ?? false) {
      queryParameters?.forEach((key, value) {
        errorMessage += "\n$key : $value";
      });
    }

    errorMessage += "\nStatus Code : $statusCode";
    errorMessage += "\nError : $error";

    _logServerError(errorMessage, stackTrace);
  }

  void _logRequestError(dynamic data, String url) {
    // What if it is String? shouldn't we want to throw exception?
    if (!(data.runtimeType is String)) {
      if (data.containsKey('metadata')) {
        final Map<String, dynamic> metadata = data['metadata'];

        if (metadata.containsKey('code') && metadata.containsKey('message')) {
          if (metadata['code'] != 0) {
            // SentryUtils.recordException(
            //   'Request error. URL: $url, MESSAGE: ${metadata['message']}, STATUS CODE: ${metadata['code']}',
            // );
          }
        }
      }
    }
  }

  void _logServerError(Object error, StackTrace stackTrace) {
    print(error);
    print(stackTrace);
  }
}
