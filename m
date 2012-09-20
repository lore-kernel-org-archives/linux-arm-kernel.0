From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Sep 2012 14:12:49 +0200
Subject: [PATCH 31/32] ARM: ux500: Apply tc3589x's GPIO/IRQ properties to
 HREF's DT
In-Reply-To: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
References: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1348143170-2130-32-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch ensures the tc3589x and tc3598x-gpio devices are
rightfully given interrupt controller status. We also describe
the tc3598x-gpio GPIO expander in full and specify it as a GPIO
controller. Finally we reference that the external MMC slot's
Card Detection GPIO on the HREF is located on the tc3598x-gpio
expander.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/hrefv60plus.dts |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
index e853882..2131d77 100644
--- a/arch/arm/boot/dts/hrefv60plus.dts
+++ b/arch/arm/boot/dts/hrefv60plus.dts
@@ -37,6 +37,21 @@
 			tc3589x at 42 {
 				compatible = "tc3589x";
 				reg = <0x42>;
+				interrupt-parent = <&gpio6>;
+				interrupts = <25 0x1>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+
+				tc3589x_gpio: tc3589x_gpio {
+					compatible = "tc3589x-gpio";
+					interrupts = <0 0x1>;
+
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					gpio-controller;
+					#gpio-cells = <2>;
+				};
 			};
 
 			tps61052 at 33 {
-- 
1.7.9.5
