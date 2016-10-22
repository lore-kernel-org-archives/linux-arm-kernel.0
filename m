From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 22 Oct 2016 13:06:16 +0200
Subject: [PATCH v5 7/7] ARM: dts: sun8i-h3: Add HDMI audio and video to the
 Orange PI 2
In-Reply-To: <cover.1477142934.git.moinejf@free.fr>
References: <cover.1477142934.git.moinejf@free.fr>
Message-ID: <eea6f6326b384ded6e99181b561fcb57ea8bbd68.1477142934.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
The same patch may be applied to other H3 based boards (Orange PI xx).
---
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index e5bcaba..799ceb9 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -56,6 +56,7 @@
 		serial0 = &uart0;
 		/* ethernet0 is the H3 emac, defined in sun8i-h3.dtsi */
 		ethernet1 = &rtl8189;
+		lcd0 = &lcd0;
 	};
 
 	chosen {
@@ -105,16 +106,32 @@
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
+&i2s2 {
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
2.10.1
