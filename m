From: clabbe@baylibre.com (Corentin Labbe)
Date: Wed, 18 Jul 2018 11:40:36 +0000
Subject: [PATCH v2 0/5] ARM: dts: sunxi: Remove unused
 address-cells/size-cells of dwmac-sun8i
Message-ID: <1531914041-14751-1-git-send-email-clabbe@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

address-cells/size-cells is unnecessary for dwmac-sun8i node.
It was in early days, but since a mdio node is used, it could be
removed.

This patch fix the following DT warning:
Warning (avoid_unnecessary_addr_size): /soc/ethernet at 1c50000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Changes since V1:
- splited patch

Corentin Labbe (5):
  dt-bindings: net: dwmac-sun8i: Remove unused address-cells/size-cells
  ARM: dts: sunxi-h3-h5: Remove unused address-cells/size-cells of
    dwmac-sun8i
  ARM: dts: sun8i: a83t: Remove unused address-cells/size-cells of
    dwmac-sun8i
  ARM: dts: sun8i: r40: Remove unused address-cells/size-cells of
    dwmac-sun8i
  ARM64: dts: sun50i: a64: Remove unused address-cells/size-cells of
    dwmac-sun8i

 Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 8 --------
 arch/arm/boot/dts/sun8i-a83t.dtsi                     | 2 --
 arch/arm/boot/dts/sun8i-r40.dtsi                      | 2 --
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                    | 2 --
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi         | 2 --
 5 files changed, 16 deletions(-)

-- 
2.16.4
