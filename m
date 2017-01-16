From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 17 Jan 2017 03:14:45 +0800
Subject: [PATCH 0/4] Enable USB OTG on Allwinner H3 and two boards
Message-ID: <20170116191449.50397-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset depends on the following patch (only the patch, as it adds the
MUSB controller used in H3, the patchset itself is for V3s):
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/476387.html

This patchset enables USB OTG ports on Orange Pi Zero and One board, using the
SoC's MUSB controller.

The mode of PHY0 is currently set to MUSB mode, as supporting EHCI/OHCI will
cost more time and code; but MUSB can supply both host and peripheral mode.

OTG function is only enabled for these two boards, as they're the only H3/H2+
boards that I have.

I think other boards' owners can easily enable their boards' OTG function with
these patches.

Icenowy Zheng (4):
  phy: sun4i-usb: support PHY0 on H3 in MUSB mode
  ARM: dts: sun8i: add MUSB node to H3 SoC
  ARM: dts: sun8i: enable USB OTG for Orange Pi Zero board
  ARM: dts: sun8i: enable USB OTG on Orange Pi One board

 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts |  6 ++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts       | 12 +++++++++++
 arch/arm/boot/dts/sun8i-h3.dtsi                   | 13 ++++++++++++
 drivers/phy/phy-sun4i-usb.c                       | 25 ++++++++---------------
 4 files changed, 40 insertions(+), 16 deletions(-)

-- 
2.11.0
