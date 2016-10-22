From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 22 Oct 2016 12:29:31 +0200
Subject: [PATCH v5 6/7] ARM: dts: sun8i-h3: Add HDMI audio and video to the
 Banana Pi M2+
In-Reply-To: <cover.1477142934.git.moinejf@free.fr>
References: <cover.1477142934.git.moinejf@free.fr>
Message-ID: <f74815b2950325950264d7d0d5cfde89939a1d95.1477142934.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
The patch for the Banana Pi M3 (A83T) is the same as this one.
---
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index 06fddaa..2e81de8 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -55,6 +55,7 @@
 	aliases {
 		serial0 = &uart0;
 		serial1 = &uart1;
+		lcd0 = &lcd0;
 	};
 
 	chosen {
@@ -93,6 +94,10 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
@@ -101,12 +106,24 @@
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
