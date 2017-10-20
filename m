From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:46 +0200
Subject: [PATCH 19/42] ARM: dts: gr-peach: Add ETHER pin group
In-Reply-To: <cover.1508493785.git.horms+renesas@verge.net.au>
References: <cover.1508493785.git.horms+renesas@verge.net.au>
Message-ID: <349adfbf27269bad4fa6915e77c97a06487266a5.1508493785.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Add pin configuration subnode for ETHER pin group.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100-gr-peach.dts | 39 +++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-gr-peach.dts b/arch/arm/boot/dts/r7s72100-gr-peach.dts
index 9661d43f5236..eca14e3801ec 100644
--- a/arch/arm/boot/dts/r7s72100-gr-peach.dts
+++ b/arch/arm/boot/dts/r7s72100-gr-peach.dts
@@ -68,6 +68,28 @@
 		/* P6_2 as RxD2; P6_3 as TxD2 */
 		pinmux = <RZA1_PINMUX(6, 2, 7)>, <RZA1_PINMUX(6, 3, 7)>;
 	};
+
+	ether_pins: ether {
+		/* Ethernet on Ports 1,3,5,10 */
+		pinmux = <RZA1_PINMUX(1, 14, 4)>, /* P1_14 = ET_COL   */
+			 <RZA1_PINMUX(3, 0, 2)>,  /* P3_0 = ET_TXCLK  */
+			 <RZA1_PINMUX(3, 3, 2)>,  /* P3_3 = ET_MDIO   */
+			 <RZA1_PINMUX(3, 4, 2)>,  /* P3_4 = ET_RXCLK  */
+			 <RZA1_PINMUX(3, 5, 2)>,  /* P3_5 = ET_RXER   */
+			 <RZA1_PINMUX(3, 6, 2)>,  /* P3_6 = ET_RXDV   */
+			 <RZA1_PINMUX(5, 9, 2)>,  /* P5_9 = ET_MDC    */
+			 <RZA1_PINMUX(10, 1, 4)>, /* P10_1 = ET_TXER  */
+			 <RZA1_PINMUX(10, 2, 4)>, /* P10_2 = ET_TXEN  */
+			 <RZA1_PINMUX(10, 3, 4)>, /* P10_3 = ET_CRS   */
+			 <RZA1_PINMUX(10, 4, 4)>, /* P10_4 = ET_TXD0  */
+			 <RZA1_PINMUX(10, 5, 4)>, /* P10_5 = ET_TXD1  */
+			 <RZA1_PINMUX(10, 6, 4)>, /* P10_6 = ET_TXD2  */
+			 <RZA1_PINMUX(10, 7, 4)>, /* P10_7 = ET_TXD3  */
+			 <RZA1_PINMUX(10, 8, 4)>, /* P10_8 = ET_RXD0  */
+			 <RZA1_PINMUX(10, 9, 4)>, /* P10_9 = ET_RXD1  */
+			 <RZA1_PINMUX(10, 10, 4)>,/* P10_10 = ET_RXD2 */
+			 <RZA1_PINMUX(10, 11, 4)>;/* P10_11 = ET_RXD3 */
+	};
 };
 
 &extal_clk {
@@ -88,3 +110,20 @@
 
 	status = "okay";
 };
+
+&ether {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ether_pins>;
+
+	status = "okay";
+
+	renesas,no-ether-link;
+	phy-handle = <&phy0>;
+
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+
+		reset-gpios = <&port4 2 GPIO_ACTIVE_LOW>;
+		reset-delay-us = <5>;
+	};
+};
-- 
2.11.0
