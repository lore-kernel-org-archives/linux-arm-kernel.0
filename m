From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat,  3 Feb 2018 02:04:53 +0800
Subject: [PATCH 0/3] Allwinner V3s EMAC support
Message-ID: <20180202180456.60378-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner V3/V3s SoCs have EMAC similar to the one in H3, but on V3s
the external MII is not exported due to packaging. (V3s is eLQFP128;
the BGA-packaged V3 exported the external MII bus.)

Add support for the EMAC on V3s. The external bus is not added yet, and
will be added when adding support for V3.

Icenowy Zheng (3):
  net: stmmac: dwmac-sun8i: drop V3s compatible and add V3 one
  ARM: sun8i: v3s: add V3s EMAC device tree node
  ARM: sun8i: v3s: enable Ethernet port on the Lichee Pi Zero Dock

 .../devicetree/bindings/net/dwmac-sun8i.txt        | 10 ++--
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts |  8 ++++
 arch/arm/boot/dts/sun8i-v3s.dtsi                   | 55 ++++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  | 10 ++--
 4 files changed, 74 insertions(+), 9 deletions(-)

-- 
2.15.1
