From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun,  8 Oct 2017 12:29:00 +0800
Subject: [PATCH 0/6] Allwinner R40 USB host support
Message-ID: <20171008042906.46779-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the USB host ports on Allwiner R40, and
enable them on Banana Pi M2 Ultra and Berry boards.

The first patch adds R40 support to the USB PHY driver.

The second patch adds USB PHY and EHCI/OHCI nodes to the R40 DTSI.

The thrid and fourth patch adds 5V regulator for the two boards, and
the fifth and sixth patch finally adds USB host ports support.

Icenowy Zheng (6):
  phy: sun4i-usb: add support for R40 USB PHY
  ARM: sun8i: r40: add USB host port nodes for R40
  ARM: sun8i: r40: add 5V regulator for Banana Pi M2 Ultra
  ARM: sun8i: v40: add 5V regulator for Banana Pi M2 Berry
  ARM: sun8i: r40: enable USB host for Banana Pi M2 Ultra
  ARM: sun8i: v40: enable USB host ports for Banana Pi M2 Berry

 .../devicetree/bindings/phy/sun4i-usb-phy.txt      |  1 +
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 31 +++++++++
 arch/arm/boot/dts/sun8i-r40.dtsi                   | 78 ++++++++++++++++++++++
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts  | 22 ++++++
 drivers/phy/allwinner/phy-sun4i-usb.c              | 12 ++++
 5 files changed, 144 insertions(+)

-- 
2.13.6
