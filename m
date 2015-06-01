From: hdegoede@redhat.com (Hans de Goede)
Date: Mon,  1 Jun 2015 17:02:59 +0200
Subject: [PATCH] ARM: dts: sun6i: Add a dts file for the Mele A1000G quad top
 set box
Message-ID: <1433170979-13725-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Mele A1000G-quad and the Mele M9 have the same PCB, sofar we've been using
the same dts for both models. Unfortunately this does not work for the otg
controller, on the M9 this is routed to a micro-usb connector on the outside,
while as on the A1000G-quad it is connected to an usb to sata bridge
(which is not populated on the M9 pcb).

This commit adds a new dts for the Mele-A1000G-quad to allow using
different otg controller settings on the 2 boards.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/Makefile                                        | 1 +
 arch/arm/boot/dts/{sun6i-a31-m9.dts => sun6i-a31-a1000g-quad.dts} | 4 ++--
 arch/arm/boot/dts/sun6i-a31-m9.dts                                | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)
 copy arch/arm/boot/dts/{sun6i-a31-m9.dts => sun6i-a31-a1000g-quad.dts} (97%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b308baf..a413d7b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -546,6 +546,7 @@ dtb-$(CONFIG_MACH_SUN5I) += \
 	sun5i-a13-olinuxino-micro.dtb \
 	sun5i-a13-utoo-p66.dtb
 dtb-$(CONFIG_MACH_SUN6I) += \
+	sun6i-a31-a1000g-quad.dtb \
 	sun6i-a31-app4-evb1.dtb \
 	sun6i-a31-colombus.dtb \
 	sun6i-a31-hummingbird.dtb \
diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-a1000g-quad.dts
similarity index 97%
copy from arch/arm/boot/dts/sun6i-a31-m9.dts
copy to arch/arm/boot/dts/sun6i-a31-a1000g-quad.dts
index a5660d6..4404f37 100644
--- a/arch/arm/boot/dts/sun6i-a31-m9.dts
+++ b/arch/arm/boot/dts/sun6i-a31-a1000g-quad.dts
@@ -48,8 +48,8 @@
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
-	model = "Mele M9 / A1000G Quad top set box";
-	compatible = "mele,m9", "allwinner,sun6i-a31";
+	model = "Mele A1000G Quad top set box";
+	compatible = "mele,a1000g-quad", "allwinner,sun6i-a31";
 
 	aliases {
 		serial0 = &uart0;
diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-m9.dts
index a5660d6..6e0e5687 100644
--- a/arch/arm/boot/dts/sun6i-a31-m9.dts
+++ b/arch/arm/boot/dts/sun6i-a31-m9.dts
@@ -48,7 +48,7 @@
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
-	model = "Mele M9 / A1000G Quad top set box";
+	model = "Mele M9 top set box";
 	compatible = "mele,m9", "allwinner,sun6i-a31";
 
 	aliases {
-- 
2.4.2
