From: mamlinav@gmail.com (Aleksei Mamlin)
Date: Fri, 18 Dec 2015 11:51:50 +0300
Subject: [PATCH 1/4] ARM: dts: sun7i: Enable touchscreen on Wexler TAB7200
 tablet
In-Reply-To: <1450428591-5597-1-git-send-email-mamlinav@gmail.com>
References: <1450428591-5597-1-git-send-email-mamlinav@gmail.com>
Message-ID: <1450428710-5653-1-git-send-email-mamlinav@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node for the Goodix GT911 touchscreen found on the Wexler TAB7200 tablet

Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
index 239b5d2..ec3b837 100644
--- a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
@@ -102,6 +102,18 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_pins_a>;
 	status = "okay";
+
+	gt911: touchscreen at 5d {
+		compatible = "goodix,gt911";
+		reg = <0x5d>;
+		interrupt-parent = <&pio>;
+		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>; /* EINT21 (PH21) */
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_reset_pin>;
+		irq-gpios = <&pio 7 21 GPIO_ACTIVE_HIGH>; /* INT (PH21) */
+		reset-gpios = <&pio 1 13 GPIO_ACTIVE_HIGH>; /* RST (PB13) */
+		touchscreen-swapped-x-y;
+	};
 };
 
 &lradc {
@@ -146,6 +158,13 @@
 };
 
 &pio {
+	ts_reset_pin: ts_reset_pin at 0 {
+		allwinner,pins = "PB13";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		allwinner,pins = "PH4";
 		allwinner,function = "gpio_in";
-- 
2.4.10
