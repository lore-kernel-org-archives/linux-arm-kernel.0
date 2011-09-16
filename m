From: rob.lee@linaro.org (Robert Lee)
Date: Fri, 16 Sep 2011 12:27:47 -0500
Subject: [PATCH v2 0/3] ARM: imx: Add cpuidle for imx platforms
Message-ID: <1316194070-21889-1-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds a common imx cpuidle driver, some common 
mach-mx5 level cpuidle functionality, and an i.MX51 instance of
using this driver.

The patch series is based on v3.1-rc2.

Changes since v1:
* To address all the problems found during review of v1, a complete
re-write was needed.

Robert Lee (3):
  ARM: imx: Add imx cpuidle driver
  ARM: imx: Add cpuidle for mach-mx5
  ARM: imx: Add cpuidle for i.MX51

 arch/arm/mach-mx5/Makefile               |    3 +-
 arch/arm/mach-mx5/cpu_op-mx51.c          |   35 +++++++-
 arch/arm/mach-mx5/cpu_op-mx51.h          |    1 +
 arch/arm/mach-mx5/mm.c                   |    4 +
 arch/arm/mach-mx5/system.c               |   35 +++++++
 arch/arm/plat-mxc/Makefile               |    1 +
 arch/arm/plat-mxc/cpuidle.c              |  151 ++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/cpuidle.h |   56 +++++++++++
 arch/arm/plat-mxc/include/mach/system.h  |    3 +
 9 files changed, 286 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/plat-mxc/cpuidle.c
 create mode 100644 arch/arm/plat-mxc/include/mach/cpuidle.h
