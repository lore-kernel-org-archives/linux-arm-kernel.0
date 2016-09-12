From: jorik@kippendief.biz (jorik at kippendief.biz)
Date: Mon, 12 Sep 2016 20:12:45 +0200
Subject: [PATCH v5 3/5] dts: sun8i-h3: associate exposed UARTs on Orange Pi
 Boards
In-Reply-To: <1473703967-21356-1-git-send-email-jorik@kippendief.biz>
References: <1473703967-21356-1-git-send-email-jorik@kippendief.biz>
Message-ID: <1473703967-21356-4-git-send-email-jorik@kippendief.biz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorik Jonker <jorik@kippendief.biz>

These H3 boards all expose UART1-3 on their expansion header. Since
other functions can be muxed to these pins, they are explicitly
disabled. To enable them, one could use DT overlays or U-boot commands:

 => fdt set /soc/serial at 01c28c00 status okay

Signed-off-by: Jorik Jonker <jorik@kippendief.biz>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts   | 18 ++++++++++++++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts | 18 ++++++++++++++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts  | 18 ++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index f93f5d1..9aa2bb7 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -176,6 +176,24 @@
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "disabled";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "disabled";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+	status = "disabled";
+};
+
 &usb1_vbus_pin_a {
 	allwinner,pins = "PG13";
 };
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
index 0adf932..5c9b5bf 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
@@ -139,6 +139,24 @@
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "disabled";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "disabled";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+	status = "disabled";
+};
+
 &usbphy {
 	/* USB VBUS is always on */
 	status = "okay";
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index daf50b9..3ec9712 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -161,6 +161,24 @@
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "disabled";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "disabled";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+	status = "disabled";
+};
+
 &usbphy {
 	/* USB VBUS is always on */
 	status = "okay";
-- 
2.7.4
