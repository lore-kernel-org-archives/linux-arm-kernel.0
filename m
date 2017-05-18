From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 18 May 2017 10:53:32 +0800
Subject: [PATCH] ARM: sun8i: v3s: fix build of Lichee Pi Zero Dock dtb
Message-ID: <20170518025332.55769-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Lichee Pi Zero Dock dtb file is not added to the Makefile, so that
it won't be built; and the file contains a problem that prevents it
from being correctly built.

Fix these issues.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/Makefile                         | 3 ++-
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9c5e1d944d1c..929a4167fcaa 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -905,7 +905,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h3-orangepi-plus.dtb \
 	sun8i-h3-orangepi-plus2e.dtb \
 	sun8i-r16-parrot.dtb \
-	sun8i-v3s-licheepi-zero.dtb
+	sun8i-v3s-licheepi-zero.dtb \
+	sun8i-v3s-licheepi-zero-dock.dtb
 dtb-$(CONFIG_MACH_SUN9I) += \
 	sun9i-a80-optimus.dtb \
 	sun9i-a80-cubieboard4.dtb
diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
index d2bfccf47149..d1311098ea45 100644
--- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
@@ -42,6 +42,8 @@
 
 #include "sun8i-v3s-licheepi-zero.dts"
 
+#include <dt-bindings/input/input.h>
+
 / {
 	model = "Lichee Pi Zero with Dock";
 	compatible = "licheepi,licheepi-zero-dock", "licheepi,licheepi-zero",
-- 
2.12.2
