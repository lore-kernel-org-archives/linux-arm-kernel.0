From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 29 Jan 2016 11:17:23 +0100
Subject: [PATCH v4 6/9] ARM: dts: marzen: Enable SCIF_CLK frequency and pins
In-Reply-To: <1454062646-4826-1-git-send-email-geert+renesas@glider.be>
References: <1454062646-4826-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1454062646-4826-7-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add and enable the external crystal for the SCIF_CLK and its pinctrl, to
be used by the Baud Rate Generator for External Clock (BRG) on (H)SCIF.

This increases the range and accuracy of supported baud rates.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Based on schematics, tested with remote access.

v4:
  - Change one-line summary prefix to match current arm-soc practices,

v3:
  - New.
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index fe396c8d58db7986..e111d35d02aebe19 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -165,6 +165,9 @@
 };
 
 &pfc {
+	pinctrl-0 = <&scif_clk_pins>;
+	pinctrl-names = "default";
+
 	du_pins: du {
 		du0 {
 			renesas,groups = "du0_rgb888", "du0_sync_1", "du0_clk_out_0";
@@ -176,6 +179,11 @@
 		};
 	};
 
+	scif_clk_pins: scif_clk {
+		renesas,groups = "scif_clk_b";
+		renesas,function = "scif_clk";
+	};
+
 	ethernet_pins: ethernet {
 		intc {
 			renesas,groups = "intc_irq1_b";
@@ -222,6 +230,11 @@
 	status = "okay";
 };
 
+&scif_clk {
+	clock-frequency = <14745600>;
+	status = "okay";
+};
+
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-names = "default";
-- 
1.9.1
