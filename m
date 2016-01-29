From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 29 Jan 2016 11:17:22 +0100
Subject: [PATCH v4 5/9] ARM: dts: lager: Enable SCIF_CLK frequency and pins
In-Reply-To: <1454062646-4826-1-git-send-email-geert+renesas@glider.be>
References: <1454062646-4826-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1454062646-4826-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add and enable the external crystal for the SCIF_CLK and its pinctrl, to
be used by the Baud Rate Generator for External Clock (BRG) on (H)SCIF.

This increases the range and accuracy of supported baud rates.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Untested, based on schematics.

v4:
  - Change one-line summary prefix to match current arm-soc practices,

v3:
  - New.
---
 arch/arm/boot/dts/r8a7790-lager.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 052dcee4790dd298..cdc0414f5f0716dd 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -291,6 +291,9 @@
 };
 
 &pfc {
+	pinctrl-0 = <&scif_clk_pins>;
+	pinctrl-names = "default";
+
 	du_pins: du {
 		renesas,groups = "du_rgb666", "du_sync_1", "du_clk_out_0";
 		renesas,function = "du";
@@ -301,6 +304,11 @@
 		renesas,function = "scif0";
 	};
 
+	scif_clk_pins: scif_clk {
+		renesas,groups = "scif_clk";
+		renesas,function = "scif_clk";
+	};
+
 	ether_pins: ether {
 		renesas,groups = "eth_link", "eth_mdio", "eth_rmii";
 		renesas,function = "eth";
@@ -485,6 +493,11 @@
 	status = "okay";
 };
 
+&scif_clk {
+	clock-frequency = <14745600>;
+	status = "okay";
+};
+
 &msiof1 {
 	pinctrl-0 = <&msiof1_pins>;
 	pinctrl-names = "default";
-- 
1.9.1
