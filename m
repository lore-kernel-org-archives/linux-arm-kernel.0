From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Apr 2014 17:04:31 +0200
Subject: [PATCH 0/5] ARM: sunxi: Machine code cleanup
Message-ID: <1398265476-29373-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This serie moves the restart code out of the mach-sunxi directory to
either the watchdog driver or to a new driver in drivers/power/reset.

Since the reset code was pretty much all the code left in the
mach-sunxi directory for all the SoCs but the A31, we also can remove
the whole machine definitions, and use the generic machine.

Thanks,
Maxime

Maxime Ripard (5):
  wdt: sunxi: Move restart code to the watchdog driver
  power: reset: Add Allwinner A31 reset code
  ARM: sunxi: Select restart drivers
  ARM: sunxi: Remove reset code from the platform
  ARM: sunxi: Remove sun4i and sun7i machine definitions

 arch/arm/mach-sunxi/Kconfig        |   4 ++
 arch/arm/mach-sunxi/sunxi.c        | 127 -------------------------------------
 drivers/power/reset/Kconfig        |   7 ++
 drivers/power/reset/Makefile       |   1 +
 drivers/power/reset/sun6i-reboot.c |  85 +++++++++++++++++++++++++
 drivers/watchdog/sunxi_wdt.c       |  33 ++++++++++
 6 files changed, 130 insertions(+), 127 deletions(-)
 create mode 100644 drivers/power/reset/sun6i-reboot.c

-- 
1.9.1
