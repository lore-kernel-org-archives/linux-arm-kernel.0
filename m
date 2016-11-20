From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 20 Nov 2016 12:26:45 +0100
Subject: [PATCH v6 5/5] ARM: dts: sun8i-h3: Add HDMI video to the Orange PI 2
In-Reply-To: <cover.1479641523.git.moinejf@free.fr>
References: <cover.1479641523.git.moinejf@free.fr>
Message-ID: <6c0482c335be69d3178d3ecbee43f04caa00c57f.1479641523.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index 047e9e1..9ecc6f1 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -56,6 +56,7 @@
 		serial0 = &uart0;
 		/* ethernet0 is the H3 emac, defined in sun8i-h3.dtsi */
 		ethernet1 = &rtl8189;
+		lcd0 = &lcd0;
 	};
 
 	chosen {
@@ -105,16 +106,28 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ir_pins_a>;
 	status = "okay";
 };
 
+&lcd0 {
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
-- 
2.10.2
