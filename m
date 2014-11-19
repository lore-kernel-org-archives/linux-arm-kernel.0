From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 19 Nov 2014 16:56:24 +0100
Subject: [PATCH 4/4] ARM: dts: Add trackpad to exynos5250-spring
In-Reply-To: <1416412585-10809-1-git-send-email-afaerber@suse.de>
References: <1416412585-10809-1-git-send-email-afaerber@suse.de>
Message-ID: <1416412585-10809-5-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HP Chromebook 11 uses an Atmel maXTouch as trackpad.
The keymap was found by trial-and-error.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/exynos5250-spring.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index cc3361afba49..2fa207c9e5e2 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -330,6 +330,22 @@
 	status = "okay";
 	samsung,i2c-sda-delay = <100>;
 	samsung,i2c-max-bus-freq = <378000>;
+
+	trackpad at 4b {
+		compatible = "atmel,maxtouch";
+		reg = <0x4b>;
+		interrupt-parent = <&gpx1>;
+		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_irq>;
+		linux,gpio-keymap = <KEY_RESERVED
+		                     KEY_RESERVED
+		                     KEY_RESERVED
+		                     KEY_RESERVED
+		                     KEY_RESERVED
+		                     BTN_LEFT>;
+		wakeup-source;
+	};
 };
 
 /*
@@ -465,6 +481,13 @@
 		samsung,pin-drv = <0>;
 	};
 
+	trackpad_irq: trackpad-irq {
+		samsung,pins = "gpx1-2";
+		samsung,pin-function = <0xf>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
 	power_key_irq: power-key-irq {
 		samsung,pins = "gpx1-3";
 		samsung,pin-function = <0>;
-- 
2.1.2
