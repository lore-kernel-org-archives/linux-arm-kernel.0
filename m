From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  2 May 2013 12:45:52 +0200
Subject: [PATCH 0/5] Add I2C support for Allwinner SoCs
Message-ID: <1367491557-6027-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds support for the I2C controller found on most of the
Allwinner SoCs, especially the already supported A10 and A13, and the
yet to come A31.

It has been tested on a A13-Olinuxino.

Thanks,
Maxime

Maxime Ripard (5):
  i2c: sunxi: Add Allwinner A1X i2c driver
  ARM: sunxi: dt: Add i2c controller nodes to the DTSI
  ARM: sun4i: dt: Add i2c muxing options
  ARM: sun5i: dt: Add i2c muxing options
  ARM: sun5i: olinuxino: Enable the i2c controllers

 .../devicetree/bindings/i2c/i2c-sunxi.txt          |  19 +
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  48 +++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |  18 +
 arch/arm/boot/dts/sun5i-a13.dtsi                   |  48 +++
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-sunxi.c                     | 441 +++++++++++++++++++++
 7 files changed, 585 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sunxi.txt
 create mode 100644 drivers/i2c/busses/i2c-sunxi.c

-- 
1.8.1.2
