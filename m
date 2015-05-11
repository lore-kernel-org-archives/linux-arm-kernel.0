From: robh@kernel.org (Rob Herring)
Date: Mon, 11 May 2015 17:41:25 -0500
Subject: [PATCH v3 0/4] SA1100 RTC clean-up for ARM64
Message-ID: <1431384089-28367-1-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables building the SA1100 RTC driver for ARM64 in
preparation for enabling CONFIG_ARCH_MMP on ARM64. This is needed for
supporting the PXA1928 SOC.

The previous versions can be found here[1][2]. Changes in this version are
some whitespace fixes and using BIT() macro. I've added Robert's ack as
well.

Russell and Eric/Haojian, Can I get an ack for the SA1100 and MMP bits so
Alexandre can apply.

Rob

[1] http://comments.gmane.org/gmane.linux.ports.arm.kernel/391410
[2] http://comments.gmane.org/gmane.linux.ports.arm.kernel/409740

Rob Herring (4):
  ARM: pxa: add memory resource to RTC device
  rtc: sa1100: convert to run-time register mapping
  ARM: sa1100: remove unused RTC register definitions
  ARM: mmp: remove unused RTC register definitions

 arch/arm/mach-mmp/include/mach/regs-rtc.h   | 23 --------
 arch/arm/mach-pxa/devices.c                 | 18 +-----
 arch/arm/mach-sa1100/include/mach/SA-1100.h | 34 -----------
 drivers/rtc/rtc-sa1100.c                    | 87 ++++++++++++++++++++---------
 4 files changed, 62 insertions(+), 100 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/regs-rtc.h

--
2.1.0
