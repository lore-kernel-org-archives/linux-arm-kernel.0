From: robh@kernel.org (Rob Herring)
Date: Tue,  3 Feb 2015 17:22:51 -0600
Subject: [PATCH 0/4] SA1100 RTC clean-up for ARM64
Message-ID: <1423005775-26457-1-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables building the SA1100 RTC driver for ARM64 in
preparation for enabling CONFIG_ARCH_MMP on ARM64. This is needed for 
supporting the PXA1928 SOC.

It's a bit late for 3.20, so targeting 3.21 is fine. Probably this 
should go through the arm-soc tree.

Rob

Rob Herring (4):
  ARM: pxa: add memory resource to RTC device
  rtc: sa1100: convert to run-time register mapping
  ARM: sa1100: remove unused RTC register definitions
  ARM: mmp: remove unused RTC register definitions

 arch/arm/mach-mmp/include/mach/regs-rtc.h   | 23 --------
 arch/arm/mach-pxa/devices.c                 | 18 +-----
 arch/arm/mach-sa1100/include/mach/SA-1100.h | 34 ------------
 drivers/rtc/rtc-sa1100.c                    | 85 ++++++++++++++++++++---------
 4 files changed, 60 insertions(+), 100 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/regs-rtc.h

-- 
2.1.0
