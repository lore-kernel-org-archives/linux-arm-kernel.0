From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 31 Jul 2015 00:24:24 +0200
Subject: [PATCH 6/9] ARM: dts: lpc4357-ea4357: add mmio-gpio leds
In-Reply-To: <1438295067-24407-1-git-send-email-manabian@gmail.com>
References: <1438295067-24407-1-git-send-email-manabian@gmail.com>
Message-ID: <1438295067-24407-7-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook up LEDs on the outputs from the D-type flip-flop found on
the address/data bus.

Note that the LEDx label in the schematics is reversed in regard
to the bits on the data bus. Hence the reverse ordering used here.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts | 69 +++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
index 7768d724c379..5f7bdad80963 100644
--- a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
+++ b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
@@ -85,6 +85,75 @@
 			gpios = <&gpio LPC_GPIO(4,13) GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	leds_mmio {
+		compatible = "gpio-leds";
+
+		led1 {
+			gpios = <&mmio_leds 15 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led2 {
+			gpios = <&mmio_leds 14 GPIO_ACTIVE_HIGH>;
+		};
+
+		led3 {
+			gpios = <&mmio_leds 13 GPIO_ACTIVE_HIGH>;
+		};
+
+		led4 {
+			gpios = <&mmio_leds 12 GPIO_ACTIVE_HIGH>;
+		};
+
+		led5 {
+			gpios = <&mmio_leds 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		led6 {
+			gpios = <&mmio_leds 10 GPIO_ACTIVE_HIGH>;
+		};
+
+		led7 {
+			gpios = <&mmio_leds 9 GPIO_ACTIVE_HIGH>;
+		};
+
+		led8 {
+			gpios = <&mmio_leds 8 GPIO_ACTIVE_HIGH>;
+		};
+
+		led9 {
+			gpios = <&mmio_leds 7 GPIO_ACTIVE_HIGH>;
+		};
+
+		led10 {
+			gpios = <&mmio_leds 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		led11 {
+			gpios = <&mmio_leds 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		led12 {
+			gpios = <&mmio_leds 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		led13 {
+			gpios = <&mmio_leds 3 GPIO_ACTIVE_HIGH>;
+		};
+
+		led14 {
+			gpios = <&mmio_leds 2 GPIO_ACTIVE_HIGH>;
+		};
+
+		led15 {
+			gpios = <&mmio_leds 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		led16 {
+			gpios = <&mmio_leds 0 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
 
 &pinctrl {
-- 
1.8.0
