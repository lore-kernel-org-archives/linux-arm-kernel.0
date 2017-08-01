From: mw@semihalf.com (Marcin Wojtas)
Date: Tue,  1 Aug 2017 18:36:21 +0200
Subject: [PATCH 0/2] Add generic Cortex-A9 timer for Armada 38x
Message-ID: <1501605383-24748-1-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This small patchset adds usage of generic Cortex-A9 timer driver
by Armada 38x SoCs. The system clocksource subsystem
will pick one of above two available ones (ARM generic or legacy
axp/a370 timer). Test on v4.13-rc3 showed, that the generic one
is chosen - no regression whatsoever observed on A388-GP and
A388-Clearfog. Backward compatibility with older kernels/DT
is preserved.

I'm looking forward to any comments or remarks.

Best regards,
Marcin

Marcin Wojtas (2):
  ARM: mvebu: enable ARM_GLOBAL_TIMER compilation Armada 38x platforms
  ARM: dts: armada-38x: Add arm_global_timer node

 arch/arm/boot/dts/armada-38x.dtsi | 7 +++++++
 arch/arm/mach-mvebu/Kconfig       | 2 ++
 2 files changed, 9 insertions(+)

-- 
1.8.3.1
