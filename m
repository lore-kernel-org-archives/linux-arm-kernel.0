From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:19:45 +0200
Subject: [PATCH 33/38] ARM: dts: genmai: Add ethernet pin group
In-Reply-To: <cover.1501514100.git.horms+renesas@verge.net.au>
References: <cover.1501514100.git.horms+renesas@verge.net.au>
Message-ID: <6f9a9720b0e6cf4760e0965bea74270d0b467ad2.1501514100.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Add pin configuration subnode for ETHER ethernet controller.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100-genmai.dts | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-genmai.dts b/arch/arm/boot/dts/r7s72100-genmai.dts
index e7824f0857c6..cd4d5ff7749e 100644
--- a/arch/arm/boot/dts/r7s72100-genmai.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai.dts
@@ -62,6 +62,28 @@
 		/* RIIC2: P1_4 as SCL, P1_5 as SDA */
 		pinmux = <RZA1_PINMUX(1, 4, 1)>, <RZA1_PINMUX(1, 5, 1)>;
 	};
+
+	ether_pins: ether {
+		/* Ethernet on Ports 1,2,3,5 */
+		pinmux = <RZA1_PINMUX(1, 14, 4)>,/* P1_14 = ET_COL  */
+			 <RZA1_PINMUX(5, 9, 2)>, /* P5_9 = ET_MDC   */
+			 <RZA1_PINMUX(3, 3, 2)>, /* P3_3 = ET_MDIO */
+			 <RZA1_PINMUX(3, 4, 2)>, /* P3_4 = ET_RXCLK */
+			 <RZA1_PINMUX(3, 5, 2)>, /* P3_5 = ET_RXER  */
+			 <RZA1_PINMUX(3, 6, 2)>, /* P3_6 = ET_RXDV  */
+			 <RZA1_PINMUX(2, 0, 2)>, /* P2_0 = ET_TXCLK */
+			 <RZA1_PINMUX(2, 1, 2)>, /* P2_1 = ET_TXER  */
+			 <RZA1_PINMUX(2, 2, 2)>, /* P2_2 = ET_TXEN  */
+			 <RZA1_PINMUX(2, 3, 2)>, /* P2_3 = ET_CRS   */
+			 <RZA1_PINMUX(2, 4, 2)>, /* P2_4 = ET_TXD0  */
+			 <RZA1_PINMUX(2, 5, 2)>, /* P2_5 = ET_TXD1  */
+			 <RZA1_PINMUX(2, 6, 2)>, /* P2_6 = ET_TXD2  */
+			 <RZA1_PINMUX(2, 7, 2)>, /* P2_7 = ET_TXD3  */
+			 <RZA1_PINMUX(2, 8, 2)>, /* P2_8 = ET_RXD0  */
+			 <RZA1_PINMUX(2, 9, 2)>, /* P2_9 = ET_RXD1  */
+			 <RZA1_PINMUX(2, 10, 2)>,/* P2_10 = ET_RXD2 */
+			 <RZA1_PINMUX(2, 11, 2)>;/* P2_11 = ET_RXD3 */
+	};
 };
 
 &extal_clk {
@@ -80,6 +102,19 @@
 	status = "okay";
 };
 
+&ether {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ether_pins>;
+
+	status = "okay";
+
+	renesas,no-ether-link;
+	phy-handle = <&phy0>;
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+};
+
 &i2c2 {
 	status = "okay";
 	clock-frequency = <400000>;
-- 
2.1.4
