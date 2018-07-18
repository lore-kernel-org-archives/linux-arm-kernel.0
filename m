From: clabbe@baylibre.com (Corentin Labbe)
Date: Wed, 18 Jul 2018 11:40:41 +0000
Subject: [PATCH v2 5/5] ARM64: dts: sun50i: a64: Remove unused
 address-cells/size-cells of dwmac-sun8i
In-Reply-To: <1531914041-14751-1-git-send-email-clabbe@baylibre.com>
References: <1531914041-14751-1-git-send-email-clabbe@baylibre.com>
Message-ID: <1531914041-14751-6-git-send-email-clabbe@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

address-cells/size-cells is unnecessary for dwmac-sun8i node.
It was in early days, but since a mdio node is used, it could be
removed.

This patch fix the following DT warning:
Warning (avoid_unnecessary_addr_size): /soc/ethernet at 1c50000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 91dd5dd9e205..357f6cba00cd 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -668,8 +668,6 @@
 			clocks = <&ccu CLK_BUS_EMAC>;
 			clock-names = "stmmaceth";
 			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
 
 			mdio: mdio {
 				compatible = "snps,dwmac-mdio";
-- 
2.16.4
