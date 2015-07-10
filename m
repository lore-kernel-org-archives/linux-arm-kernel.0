From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Jul 2015 15:37:13 +0900
Subject: [PATCH 05/11] ARM: shmobile: armadillo800eva dts: Add pinctrl and
 gpio-hog for lcdc0
In-Reply-To: <cover.1436509954.git.horms+renesas@verge.net.au>
References: <cover.1436509954.git.horms+renesas@verge.net.au>
Message-ID: <ffd2f9a5afb730b9f6c1d1938934213c3cfcf249.1436509954.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Configure pinctrl and a GPIO-controller board mux for LCD use.
This allows the armadillo800eva board staging code to enable lcdc0.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 2e31d8c01cbf..105d9c95de4a 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -224,6 +224,9 @@
 };
 
 &pfc {
+	pinctrl-0 = <&lcd0_pins>;
+	pinctrl-names = "default";
+
 	ether_pins: ether {
 		renesas,groups = "gether_mii", "gether_int";
 		renesas,function = "gether";
@@ -259,6 +262,16 @@
 				 "fsia_data_in_1", "fsia_data_out_0";
 		renesas,function = "fsia";
 	};
+
+	lcd0_pins: lcd0 {
+		renesas,groups = "lcd0_data24_0", "lcd0_lclk_1", "lcd0_sync";
+		renesas,function = "lcd0";
+
+		/* DBGMD/LCDC0/FSIA MUX */
+		gpio-hog;
+		gpios = <176 0>;
+		output-high;
+	};
 };
 
 &tpu {
-- 
2.1.4
