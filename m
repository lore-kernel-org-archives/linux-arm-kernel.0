From: matthias.bgg@kernel.org (matthias.bgg at kernel.org)
Date: Fri, 16 Nov 2018 19:30:40 +0100
Subject: [PATCH] arm64: dts: Add uart for mt6797 EVB
Message-ID: <20181116183040.18696-1-matthias.bgg@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <mbrugger@suse.com>

This patch adds the pinctrl configuration for the mt6797 EVB.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 arch/arm64/boot/dts/mediatek/mt6797-evb.dts | 2 ++
 arch/arm64/boot/dts/mediatek/mt6797.dtsi    | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797-evb.dts b/arch/arm64/boot/dts/mediatek/mt6797-evb.dts
index c79109c65409..237e869a5fa1 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6797-evb.dts
@@ -33,4 +33,6 @@
 
 &uart0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index a64bb84bdec3..2b2a69c7567f 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -142,6 +142,13 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		uart0_pins_a: uart0 {
+			pins0 {
+				pinmux = <MT6797_GPIO234__FUNC_UTXD0>,
+					 <MT6797_GPIO235__FUNC_URXD0>;
+			};
+		};
+
 		uart1_pins_a: uart1 {
 			pins1 {
 				pinmux = <MT6797_GPIO232__FUNC_URXD1>,
-- 
2.19.1
