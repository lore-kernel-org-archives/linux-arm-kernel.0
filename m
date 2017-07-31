From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:19:48 +0200
Subject: [PATCH 36/38] ARM: dts: rskrza1: Add SDHI1 pin group
In-Reply-To: <cover.1501514100.git.horms+renesas@verge.net.au>
References: <cover.1501514100.git.horms+renesas@verge.net.au>
Message-ID: <35ff4c0edf7779c455cb41e727f59ed10e478416.1501514100.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Add pin configuration for SDHI ch1.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100-rskrza1.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-rskrza1.dts b/arch/arm/boot/dts/r7s72100-rskrza1.dts
index cedf887e809a..f8285b951140 100644
--- a/arch/arm/boot/dts/r7s72100-rskrza1.dts
+++ b/arch/arm/boot/dts/r7s72100-rskrza1.dts
@@ -78,6 +78,18 @@
 			 <RZA1_PINMUX(2, 10, 2)>,	/* ET_RXD2  */
 			 <RZA1_PINMUX(2, 11, 2)>;	/* ET_RXD3  */
 	};
+
+	/* SDHI ch1 on CN1 */
+	sdhi1_pins: sdhi1 {
+		pinmux = <RZA1_PINMUX(3, 8, 7)>,	/* SD_CD_1 */
+			 <RZA1_PINMUX(3, 9, 7)>,	/* SD_WP_1 */
+			 <RZA1_PINMUX(3, 10, 7)>,	/* SD_D1_1 */
+			 <RZA1_PINMUX(3, 11, 7)>,	/* SD_D0_1 */
+			 <RZA1_PINMUX(3, 12, 7)>,	/* SD_CLK_1 */
+			 <RZA1_PINMUX(3, 13, 7)>,	/* SD_CMD_1 */
+			 <RZA1_PINMUX(3, 14, 7)>,	/* SD_D3_1 */
+			 <RZA1_PINMUX(3, 15, 7)>;	/* SD_D2_1 */
+	};
 };
 
 &mtu2 {
@@ -96,6 +108,8 @@
 };
 
 &sdhi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhi1_pins>;
 	bus-width = <4>;
 	status = "okay";
 };
-- 
2.1.4
