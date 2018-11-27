From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:45 +0100
Subject: [PATCH 44/77] ARM: dts: sun7i: Split the RTS and CTS pins out of the
 UART nodes
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <998922bf617df5eff6c6f19b97d7778ad9668eb4.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some UART nodes on the A20 DTSI do not share the same pattern that we use
everywhere else, with the RTS and CTS pins split away from the TX and RX
pins. Make those pin groups consistent with the rest of our DT.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts |  4 ++--
 arch/arm/boot/dts/sun7i-a20-mk808c.dts      |  2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi            | 14 ++++++++++++--
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
index 9ce59d49cf49..a1af7d6726e2 100644
--- a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
+++ b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
@@ -215,13 +215,13 @@
 
 &uart2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_pi_pins>;
+	pinctrl-0 = <&uart2_pi_pins>, <&uart2_cts_rts_pi_pins>;
 	status = "okay";
 };
 
 &uart3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pg_pins>;
+	pinctrl-0 = <&uart3_pg_pins>, <&uart3_cts_rts_pg_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-mk808c.dts b/arch/arm/boot/dts/sun7i-a20-mk808c.dts
index a8d15d01ac1a..b4143a91086b 100644
--- a/arch/arm/boot/dts/sun7i-a20-mk808c.dts
+++ b/arch/arm/boot/dts/sun7i-a20-mk808c.dts
@@ -173,7 +173,7 @@
 
 &uart2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_pi_pins>;
+	pinctrl-0 = <&uart2_pi_pins>, <&uart2_cts_rts_pi_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 75669fc51de5..bffd3a21bee3 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -935,12 +935,22 @@
 			};
 
 			uart2_pi_pins: uart2-pi-pins {
-				pins = "PI16", "PI17", "PI18", "PI19";
+				pins = "PI18", "PI19";
+				function = "uart2";
+			};
+
+			uart2_cts_rts_pi_pins: uart2-cts-rts-pi-pins {
+				pins = "PI16", "PI17";
 				function = "uart2";
 			};
 
 			uart3_pg_pins: uart3-pg-pins {
-				pins = "PG6", "PG7", "PG8", "PG9";
+				pins = "PG6", "PG7";
+				function = "uart3";
+			};
+
+			uart3_cts_rts_pg_pins: uart3-cts-rts-pg-pins {
+				pins = "PG8", "PG9";
 				function = "uart3";
 			};
 
-- 
git-series 0.9.1
