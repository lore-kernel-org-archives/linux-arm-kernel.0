From: robh@kernel.org (Rob Herring)
Date: Thu, 30 Apr 2015 15:37:09 -0500
Subject: [PATCH v2 0/4] SA1100 RTC clean-up for ARM64
Message-ID: <1430426233-7461-1-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables building the SA1100 RTC driver for ARM64 in
preparation for enabling CONFIG_ARCH_MMP on ARM64. This is needed for
supporting the PXA1928 SOC.

The previous version can be found here[1]. This is mostly an update to
summarize the discussion about SA1100 and PXA RTC support.

Rob

[1] http://comments.gmane.org/gmane.linux.ports.arm.kernel/391410

Rob Herring (4):
  ARM: pxa: add memory resource to RTC device
  rtc: sa1100: convert to run-time register mapping
  ARM: sa1100: remove unused RTC register definitions
  ARM: mmp: remove unused RTC register definitions

 arch/arm/mach-mmp/include/mach/regs-rtc.h   | 23 --------
 arch/arm/mach-pxa/devices.c                 | 18 +-----
 arch/arm/mach-sa1100/include/mach/SA-1100.h | 34 ------------
 drivers/rtc/rtc-sa1100.c                    | 86 ++++++++++++++++++++---------
 4 files changed, 61 insertions(+), 100 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/regs-rtc.h

--
2.1.0
