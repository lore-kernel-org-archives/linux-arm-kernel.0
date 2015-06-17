From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 17 Jun 2015 10:38:56 +0200
Subject: [PATCH v2 7/7] ARM: shmobile: armadillo800eva dts: Add pinctrl and
 gpio-hog for lcdc0
In-Reply-To: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
References: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1434530336-15073-8-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure pinctrl and a GPIO-controller board mux for LCD use.
This allows the armadillo800eva board staging code to enable lcdc0.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 2e31d8c01cbf6a74..105d9c95de4af611 100644
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
1.9.1
