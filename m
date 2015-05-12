From: tyler.baker@linaro.org (tyler.baker at linaro.org)
Date: Tue, 12 May 2015 14:59:05 -0700
Subject: [PATCH 0/2] selftests: installation fixes
Message-ID: <1431467947-29847-1-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tyler Baker <tyler.baker@linaro.org>

This is a follow up series to address a simple lib.mk installation issue[1]. 
Essentially, install is being called without checking that there exists test 
artifacts to install, which in turn causes 'make install' to fail. By creating 
a simple loop we can avoid if/elif/else blocks to determine if install actually 
needs to be called.

I've tested this series by building and deploying tests on x86[2], arm64[3], and arm[4] 
platforms.

This series is based on next-20150512.

[1] https://lkml.org/lkml/2015/4/20/746
[2] http://lava.kernelci.org/scheduler/job/83448/log_file#L_40
[3] http://lava.kernelci.org/scheduler/job/83665/log_file#L_44  
[4] http://lava.kernelci.org/scheduler/job/83442/log_file#L_65

Tyler Baker (2):
  selftests/lib.mk: fix INSTALL_RULE
  selftests/breakpoints: only set TEST_PROGS when built

 tools/testing/selftests/breakpoints/Makefile | 3 +--
 tools/testing/selftests/lib.mk               | 6 ++++--
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.1.4
