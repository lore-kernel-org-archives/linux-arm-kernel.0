From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Jan 2013 09:54:04 +0100
Subject: [PATCHv2 0/3] Add framebuffer support to the CFA-10049
Message-ID: <1359104048-26823-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The CFA-10049 embeds a LCD screen that is using a Himax HX-8357B
that needs to be initialized through SPI before being able to use
its RGB interface.

This patchset adds a driver for this controller, and the needed
pieces in the 10049 device tree to enable it.

Maxime

Changes from v1:
  - Fixed typos and minor changes
  - Removed the __devinit/__devexit

Maxime Ripard (3):
  fb: backlight: Add the Himax HX-8357B LCD controller
  ARM: dts: mxs: Add muxing options for the third PWM
  ARM: dts: mxs: Add the LCD to the 10049 board

 arch/arm/boot/dts/imx28-cfa10049.dts |   99 +++++++
 arch/arm/boot/dts/imx28.dtsi         |   10 +
 arch/arm/mach-mxs/mach-mxs.c         |   22 ++
 drivers/video/backlight/Kconfig      |    7 +
 drivers/video/backlight/Makefile     |    1 +
 drivers/video/backlight/hx8357.c     |  482 ++++++++++++++++++++++++++++++++++
 6 files changed, 621 insertions(+)
 create mode 100644 drivers/video/backlight/hx8357.c

-- 
1.7.10.4
