From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  4 May 2014 22:07:58 -0500
Subject: [PATCH 0/6] ARM: sunxi: Machine code cleanup
Message-ID: <1399259284-6282-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This serie moves the restart code out of the mach-sunxi directory to
either the watchdog driver or to a new driver in drivers/power/reset.

Since the reset code was pretty much all the code left in the
mach-sunxi directory for all the SoCs but the A31, the only thing left
into mach-sunxi are empty machine definition.

Thanks, Maxime

Maxime Ripard (6):
  wdt: sunxi: Move restart code to the watchdog driver
  power: reset: Add Allwinner A31 reset code
  ARM: sunxi: Remove reset code from the platform
  ARM: sunxi: Remove init_machine callback
  ARM: sunxi: Add A31 reset driver to sunxi_defconfig
  ARM: multi_v7: Add Allwinner reset drivers to multi_v7_defconfig

 arch/arm/configs/multi_v7_defconfig |   2 +
 arch/arm/configs/sunxi_defconfig    |   3 +
 arch/arm/mach-sunxi/sunxi.c         | 107 ------------------------------------
 drivers/power/reset/Kconfig         |   7 +++
 drivers/power/reset/Makefile        |   1 +
 drivers/power/reset/sun6i-reboot.c  |  85 ++++++++++++++++++++++++++++
 drivers/watchdog/sunxi_wdt.c        |  29 ++++++++++
 7 files changed, 127 insertions(+), 107 deletions(-)
 create mode 100644 drivers/power/reset/sun6i-reboot.c

-- 
1.9.1
