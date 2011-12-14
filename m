From: rob.lee@linaro.org (Robert Lee)
Date: Wed, 14 Dec 2011 01:02:04 -0600
Subject: [RFC PATCH v2 0/2] Add common cpuidle code for consolidation.
Message-ID: <1323846126-7516-1-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on 3.2-rc4

Tested on i.MX51 Babbage Board

v1 can be found here: 
http://comments.gmane.org/gmane.linux.ports.arm.kernel/142791

Changes since v1:
* Common interface moved to drivers/cpuidle and made non arch-specific.
* Made various fixes and suggested additions to the common cpuidle
code from v1 review.
* Added callback for filling in driver_data field as needed.
* Modified the various platforms with these changes.

Robert Lee (2):
  cpuidle: Add common init interface and idle functionality
  ARM: imx: Add mx5 cpuidle implmentation

 arch/arm/mach-at91/cpuidle.c        |   98 +++++++++---------------
 arch/arm/mach-davinci/cpuidle.c     |  143 ++++++++++-------------------------
 arch/arm/mach-exynos/cpuidle.c      |   73 +++---------------
 arch/arm/mach-kirkwood/cpuidle.c    |   94 ++++++++---------------
 arch/arm/mach-mx5/Makefile          |    3 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c |    3 +
 arch/arm/mach-mx5/cpuidle.c         |   65 ++++++++++++++++
 arch/arm/mach-shmobile/cpuidle.c    |   40 ++--------
 drivers/cpuidle/Makefile            |    2 +-
 drivers/cpuidle/common.c            |  124 ++++++++++++++++++++++++++++++
 include/linux/cpuidle.h             |   26 ++++++
 11 files changed, 347 insertions(+), 324 deletions(-)
 create mode 100644 arch/arm/mach-mx5/cpuidle.c
 create mode 100644 drivers/cpuidle/common.c
