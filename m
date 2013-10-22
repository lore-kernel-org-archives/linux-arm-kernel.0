From: sre@debian.org (Sebastian Reichel)
Date: Tue, 22 Oct 2013 15:01:34 +0200
Subject: [PATCH 0/2] Add lp5523 DT support
Message-ID: <1382446896-28436-1-git-send-email-sre@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds device tree support for the enable-pin
of the lp55xx. The second part adds support for the LP5523
to the Nokia N900's DTS file.

I have tested the patchset only using DT boot, since
non-DT boot is currently broken for me.

-- Sebastian

Sebastian Reichel (2):
  leds: lp55xx: handle enable pin in driver
  DTS: ARM: OMAP3-N900: Add LP5523 support

 .../devicetree/bindings/leds/leds-lp55xx.txt       |  1 +
 arch/arm/boot/dts/omap3-n900.dts                   | 61 ++++++++++++++++++++++
 arch/arm/mach-omap2/board-rx51-peripherals.c       | 20 +------
 arch/arm/mach-ux500/board-mop500.c                 |  2 +
 drivers/leds/leds-lp55xx-common.c                  | 25 ++++-----
 include/linux/platform_data/leds-lp55xx.h          |  6 +--
 6 files changed, 80 insertions(+), 35 deletions(-)

-- 
1.8.4.rc3
