From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 10 Nov 2014 13:31:18 +0100
Subject: Tiny dts change breaks boot on n900
Message-ID: <20141110123118.GA31134@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I'm confused:

This fixes boot on n900. Strange thing is ... adp1653 driver is not
even compiled in -- it is module.

It looks like tiny change in dts noone should care about breaks
boot... I don't even have adp1653 device parsing code written.

Something similar happened before -- change in device tree order broke
boot.

Any ideas? What is going on?
								Pavel

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index f3118bf..557a19e 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -565,11 +565,6 @@
 	adp1653: adp1653 at 30 {
 		compatible = "ad,adp1653";
 		reg = <0x30>;
-
-		max-flash-timeout-usec = <500000>;
-		max-flash-intensity-mA = <0>;
-		max-torch-intensity-mA = <0>;
-		max-indicator-intensity-uA = <0>;
 	};
 };
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
