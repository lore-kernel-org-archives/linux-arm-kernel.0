From: mpe@ellerman.id.au (Michael Ellerman)
Date: Thu, 16 Apr 2015 14:08:07 +1000
Subject: [PATCH 0/7] selftests: fixes for installation and cross
 compilation
In-Reply-To: <1429051856-14557-1-git-send-email-tyler.baker@linaro.org>
References: <1429051856-14557-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <1429157287.3464.0.camel@ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-04-14 at 15:50 -0700, Tyler Baker wrote:
> This patch set fixes various issues observed when cross building and 
> installing selftests.
> 
> As I began investigating improving the test output format, I performed an 
> audit of the current tests to ensure all tests were able to execute on various 
> target architectures. I found that some tests did not install their binaries 
> and others required directories to be installed to execute properly. There 
> were also cases in which tests were being installed when they were never built.
> With this series applied all tests compile when appropriate and install their 
> output properly.
> 
> I have tested this series by building, installing and deploying all selftests 
> to x86, arm and arm64 targets. 
> 
> This series is based on next-20150414
> 
> Tyler Baker (7):
>   selftests: copy TEST_DIRS to INSTALL_PATH
>   selftests/ftrace: install test.d
>   selftests/breakpoints: emit skip and omit installation when tests are
>     not compiled
>   selftests/kdbus: install kdbus-test
>   selftests/x86: fix cross build logic
>   selftests/x86: install tests
>   selftests/exec: do not install subdir as it is already created

This series looks good except for 5/7.

As Andy says you should just cause all to have no dependencies for !x86.

Otherwise-acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
