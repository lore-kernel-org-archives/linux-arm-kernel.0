From: tyler.baker@linaro.org (Tyler Baker)
Date: Tue, 14 Apr 2015 15:50:56 -0700
Subject: [PATCH 0/7] selftests: fixes for installation and cross compilation
Message-ID: <1429051856-14557-1-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set fixes various issues observed when cross building and 
installing selftests.

As I began investigating improving the test output format, I performed an 
audit of the current tests to ensure all tests were able to execute on various 
target architectures. I found that some tests did not install their binaries 
and others required directories to be installed to execute properly. There 
were also cases in which tests were being installed when they were never built.
With this series applied all tests compile when appropriate and install their 
output properly.

I have tested this series by building, installing and deploying all selftests 
to x86, arm and arm64 targets. 

This series is based on next-20150414

Tyler Baker (7):
  selftests: copy TEST_DIRS to INSTALL_PATH
  selftests/ftrace: install test.d
  selftests/breakpoints: emit skip and omit installation when tests are
    not compiled
  selftests/kdbus: install kdbus-test
  selftests/x86: fix cross build logic
  selftests/x86: install tests
  selftests/exec: do not install subdir as it is already created

 tools/testing/selftests/breakpoints/Makefile |  7 ++++-
 tools/testing/selftests/exec/Makefile        |  2 +-
 tools/testing/selftests/ftrace/Makefile      |  1 +
 tools/testing/selftests/kdbus/Makefile       |  2 ++
 tools/testing/selftests/lib.mk               |  3 ++
 tools/testing/selftests/x86/Makefile         | 41 +++++++++++++++++++++-------
 6 files changed, 44 insertions(+), 12 deletions(-)

-- 
2.1.0
