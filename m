From: jorik@kippendief.biz (jorik at kippendief.biz)
Date: Wed,  7 Sep 2016 09:41:39 +0200
Subject: [PATCH v3 1/8] dts: sun8i-h3: drop _a and address suffix from uart0
 pinmux
In-Reply-To: <1473234106-32330-1-git-send-email-jorik@kippendief.biz>
References: <1473234106-32330-1-git-send-email-jorik@kippendief.biz>
Message-ID: <1473234106-32330-2-git-send-email-jorik@kippendief.biz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorik Jonker <jorik@kippendief.biz>

These are the only possible pins for UART0 on H3

Signed-off-by: Jorik Jonker <jorik@kippendief.biz>
---
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts | 2 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts       | 2 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts     | 2 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts      | 2 +-
 arch/arm/boot/dts/sun8i-h3.dtsi                 | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index f3b1d5f..3779280 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -179,7 +179,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index f93f5d1..6cb29f3 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -172,7 +172,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
index 0adf932..a1423cc 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
@@ -135,7 +135,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index daf50b9..772239e 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -157,7 +157,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index fdf9fdb..ee10004 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -360,7 +360,7 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			uart0_pins_a: uart0 at 0 {
+			uart0_pins: uart0 {
 				allwinner,pins = "PA4", "PA5";
 				allwinner,function = "uart0";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-- 
2.7.4
