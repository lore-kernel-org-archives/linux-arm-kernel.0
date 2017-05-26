From: uwe@kleine-koenig.org (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 26 May 2017 20:06:06 +0200
Subject: [PATCH RFC 2/5] ARM: dts: am335x-baltos: use IRQ_TYPE_* to specify
 irq flags
In-Reply-To: <20170526180609.2699-1-uwe@kleine-koenig.org>
References: <20170526180609.2699-1-uwe@kleine-koenig.org>
Message-ID: <20170526180609.2699-2-uwe@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the binding documentation and the source code the omap-gpio
controller takes IRQ_TYPE_* as its flags values, not GPIO_ACTIVE_*.

This patch uses the right variable type which yields the same result
when compiled. Note that this might be wrong and actually
IRQ_TYPE_LEVEL_LOW is intended by the dt author.

Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
---
Hello,

can somebody with the hardware or it's documentation please check which
flag is the right one?

Best regards
Uwe

 arch/arm/boot/dts/am335x-baltos-ir3220.dts | 2 +-
 arch/arm/boot/dts/am335x-baltos-ir5221.dts | 2 +-
 arch/arm/boot/dts/am335x-baltos.dtsi       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos-ir3220.dts b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
index 19f53b8569e1..7eb975ba044d 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir3220.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
@@ -84,7 +84,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&gpio0>;
-		interrupts = <20 GPIO_ACTIVE_LOW>;
+		interrupts = <20 IRQ_TYPE_EDGE_RISING>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&tca6416_pins>;
 	};
diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
index 2b9d7f4db23f..f24ae2836e1f 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
@@ -93,7 +93,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&gpio0>;
-		interrupts = <20 GPIO_ACTIVE_LOW>;
+		interrupts = <20 IRQ_TYPE_EDGE_RISING>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&tca6416_pins>;
 	};
diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi b/arch/arm/boot/dts/am335x-baltos.dtsi
index d42b98f15e8b..e3234d462741 100644
--- a/arch/arm/boot/dts/am335x-baltos.dtsi
+++ b/arch/arm/boot/dts/am335x-baltos.dtsi
@@ -249,7 +249,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <28 GPIO_ACTIVE_LOW>;
+		interrupts = <28 IRQ_TYPE_EDGE_RISING>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&tps65910_pins>;
 	};
-- 
2.11.0
