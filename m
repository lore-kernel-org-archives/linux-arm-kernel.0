From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  3 Mar 2015 10:32:25 +0100
Subject: [PATCH 2/5] ARM: dts: update syscons to use simple-mfd
In-Reply-To: <1425375148-4369-1-git-send-email-linus.walleij@linaro.org>
References: <1425375148-4369-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1425375148-4369-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Integrators and the RealView use simple MFD devices with register bit
LEDs as subnodes, update these to use the "simple-mfd" compatible property
so that subdevices get spawned from the MFD nexi.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm-realview-pb1176.dts | 2 +-
 arch/arm/boot/dts/integrator.dtsi         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index ff26c7ed8c41..1bc64cda819e 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -114,7 +114,7 @@
 		ranges;
 
 		syscon: syscon at 10000000 {
-			compatible = "arm,realview-pb1176-syscon", "syscon";
+			compatible = "arm,realview-pb1176-syscon", "syscon", "simple-mfd";
 			reg = <0x10000000 0x1000>;
 
 			led at 08.0 {
diff --git a/arch/arm/boot/dts/integrator.dtsi b/arch/arm/boot/dts/integrator.dtsi
index 28e38f8c6b0f..3807d4f46ef7 100644
--- a/arch/arm/boot/dts/integrator.dtsi
+++ b/arch/arm/boot/dts/integrator.dtsi
@@ -6,7 +6,7 @@
 
 / {
 	core-module at 10000000 {
-		compatible = "arm,core-module-integrator", "syscon";
+		compatible = "arm,core-module-integrator", "syscon", "simple-mfd";
 		reg = <0x10000000 0x200>;
 
 		/* Use core module LED to indicate CPU load */
@@ -95,7 +95,7 @@
 
 		syscon {
 			/* Debug registers mapped as syscon */
-			compatible = "syscon";
+			compatible = "syscon", "simple-mfd";
 			reg = <0x1a000000 0x10>;
 
 			led at 04.0 {
-- 
1.9.3
