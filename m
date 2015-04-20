From: tyler.baker@linaro.org (Tyler Baker)
Date: Mon, 20 Apr 2015 16:13:22 -0700
Subject: [PATCH v3 0/8] selftests: fixes for installation and cross compilation
Message-ID: <1429571602-24945-1-git-send-email-tyler.baker@linaro.org>
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

Changes v2 -> v3:
* 5/8: Removed duplicate all_32. 
* 6/8: Ensure the default rule is all in every case.
* 6/8: Fixed commit message wording for better clarity.
* Applied Michael Ellerman's ACK to patches 1-4, and 8 as they have not changed.
* Rebased onto next-20150420.

Changes v1 -> v2:
* Have no dependency on all when CROSS_COMPILE is set. (Andy Lutomirski)
* Added Andy on CC for all x86 test patches.
* Split up the x86 patches for better clarity.
* Rebased onto next-20150415.

This series is based on next-20150420.

Tyler Baker (8):
  selftests: copy TEST_DIRS to INSTALL_PATH
  selftests/ftrace: install test.d
  selftests/breakpoints: emit skip and omit installation when tests are
    not compiled
  selftests/kdbus: install kdbus-test
  selftest/x86: build both bitnesses
  selftest/x86: have no dependency on all when cross building
  selftest/x86: install tests
  selftests/exec: do not install subdir as it is already created

 tools/testing/selftests/breakpoints/Makefile |  7 ++++++-
 tools/testing/selftests/exec/Makefile        |  2 +-
 tools/testing/selftests/ftrace/Makefile      |  1 +
 tools/testing/selftests/kdbus/Makefile       |  2 ++
 tools/testing/selftests/lib.mk               |  3 +++
 tools/testing/selftests/x86/Makefile         | 21 ++++++++++++++++++---
 6 files changed, 31 insertions(+), 5 deletions(-)

-- 
2.1.4
