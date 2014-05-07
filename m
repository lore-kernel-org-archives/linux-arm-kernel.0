From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  6 May 2014 22:50:16 -0500
Subject: [PATCH 0/7] Add Allwinner A31 USB support
Message-ID: <1399434623-20383-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patchset adds support for the USB controllers found in the
Allwinner A31.

While the design is similar to the earlier Allwinner SoCs that are
already supported, a few details here and there change, like the fact
that the PHYs now have one clock per phy, while it used to be only one
for all the PHYs.

Thanks,
Maxime

Boris BREZILLON (2):
  usb: ehci-platform: add optional reset controller retrieval
  ARM: sunxi: dt: add APP4-EVB1 board support

Maxime Ripard (5):
  clk: sunxi: Implement A31 USB clock
  ARM: sun6i: Add the USB clocks to the DTSI.
  phy: usb: sunxi: Introduce Allwinner A31 USB PHY support
  usb: ohci-platform: Enable optional use of reset controller
  ARM: sun6i: dt: Add support for the USB controllers

 Documentation/devicetree/bindings/usb/usb-ehci.txt |  1 +
 Documentation/devicetree/bindings/usb/usb-ohci.txt |  1 +
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts          | 63 ++++++++++++++++
 arch/arm/boot/dts/sun6i-a31.dtsi                   | 88 ++++++++++++++++++++++
 drivers/clk/sunxi/clk-sunxi.c                      |  6 ++
 drivers/phy/phy-sun4i-usb.c                        | 35 ++++++---
 drivers/usb/host/ehci-platform.c                   | 25 +++++-
 drivers/usb/host/ohci-platform.c                   | 25 +++++-
 9 files changed, 234 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts

-- 
1.9.1
