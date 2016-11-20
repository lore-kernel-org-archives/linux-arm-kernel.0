From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 20 Nov 2016 12:23:19 +0100
Subject: [PATCH v6 4/5] ARM: dts: sun8i-h3: Add HDMI video to the Banana Pi M2+
In-Reply-To: <cover.1479641523.git.moinejf@free.fr>
References: <cover.1479641523.git.moinejf@free.fr>
Message-ID: <9dc91753796f8413f276ea62479bd767b549d8c2.1479641523.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index c0c49dd..4b5baae 100644
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
@@ -101,12 +106,20 @@
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
