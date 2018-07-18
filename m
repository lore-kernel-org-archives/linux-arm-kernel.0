From: clabbe@baylibre.com (Corentin Labbe)
Date: Wed, 18 Jul 2018 11:40:39 +0000
Subject: [PATCH v2 3/5] ARM: dts: sun8i: a83t: Remove unused
 address-cells/size-cells of dwmac-sun8i
In-Reply-To: <1531914041-14751-1-git-send-email-clabbe@baylibre.com>
References: <1531914041-14751-1-git-send-email-clabbe@baylibre.com>
Message-ID: <1531914041-14751-4-git-send-email-clabbe@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ddress-cells/size-cells is unnecessary for dwmac-sun8i node.
It was in early days, but since a mdio node is used, it could be
removed.

This patch fix the following DT warning:
Warning (avoid_unnecessary_addr_size): /soc/ethernet at 1c50000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index b047f05e690d..276c99fcfcc8 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -913,8 +913,6 @@
 			reset-names = "stmmaceth";
 			clocks = <&ccu 27>;
 			clock-names = "stmmaceth";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			status = "disabled";
 
 			mdio: mdio {
-- 
2.16.4
