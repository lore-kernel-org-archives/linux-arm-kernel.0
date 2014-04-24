From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Apr 2014 17:40:26 -0700
Subject: [PATCH 0/4] mfd: twl4030-power: Enable off-idle configuration when
 booted with device tree
Message-ID: <1398300030-7386-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

One of the major blockers for making omap3 to boot in device tree
mode has been the fact that power management has not been working
as well as when booted in legacy mode.

This series when applied on top of the patches in tread
"[PATCH 00/11] Fixes for omap PM for making omap3 DT only".

This series makes the twl4030 PMIC configurations generic
so that most boards can just use one of the configurations
based on the compatible flag alone. This allows us to drop
all the related platform data once omap3 boots in device
tree only mode.

Lee, if these patches look OK to you, please feel free to
pick them, preferrably to the immutable branch you already
have set up so I can also merge them in to be able to have
things working in my branch properly for PM.

Regards,

Tony

Tony Lindgren (4):
  mfd: twl4030-power: Add recommended idle configuration
  mfd: twl4030-power: Add support for board specific configuration
  mfd: twl4030power: Add a configuration to turn off oscillator during
    off-idle
  ARM: dts: Enable twl4030 off-idle configuration for selected omaps

 .../devicetree/bindings/mfd/twl4030-power.txt      |  10 +
 arch/arm/boot/dts/omap3-evm-common.dtsi            |   7 +
 arch/arm/boot/dts/omap3-n900.dts                   |   5 +
 drivers/mfd/twl4030-power.c                        | 205 +++++++++++++++++++++
 include/linux/i2c/twl.h                            |   1 +
 5 files changed, 228 insertions(+)

-- 
1.8.1.1
