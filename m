From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Mon, 23 Oct 2017 14:33:10 +0200
Subject: [PATCH] ARM: dts: imx28-tx28: fix interrupt flags
Message-ID: <1508761990-17060-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some interrupts properties are given '0' as the flags argument.
Change them to use the appropriate interrupt flags.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28-tx28.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index 211e67d..52d99b4 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -329,7 +329,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&tx28_pca9554_pins>;
 		interrupt-parent = <&gpio3>;
-		interrupts = <28 0>;
+		interrupts = <28 IRQ_TYPE_NONE>;
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
@@ -353,7 +353,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&tx28_tsc2007_pins>;
 		interrupt-parent = <&gpio3>;
-		interrupts = <20 0>;
+		interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
 		pendown-gpio = <&gpio3 20 GPIO_ACTIVE_LOW>;
 		ti,x-plate-ohms = /bits/ 16 <660>;
 	};
-- 
2.1.4
