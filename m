From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Fri, 15 Sep 2017 15:54:26 +0800
Subject: [PATCH] arm64: dts: move berlin SoC files from marvell dir to
 synaptics dir
Message-ID: <20170915155426.17fdf674@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Move and update device tree files as part of transition from Marvell
berlin to Synaptics berlin.

The changes are to:
 * rename dts/marvell/berlin4ct.dtsi to synaptics/berlin4ct.dtsi, and
   update SoC to be "syna,berlin"
 * rename dts/marvell/berlin4ct-stb.dts to synaptics/berlin4ct-stb.dts
   and update board name string.
 * rename dts/marvell/berlin4ct-dmp.dts to synaptics/berlin4ct-dmp.dts
   and update board name string.
 * Update dts/marvell/Makefile not to build berlin dtbs

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm64/boot/dts/marvell/Makefile                         | 4 ----
 arch/arm64/boot/dts/synaptics/Makefile                       | 7 +++++++
 arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct-dmp.dts | 7 ++++---
 arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct-stb.dts | 7 ++++---
 arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct.dtsi    | 5 +++--
 5 files changed, 18 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm64/boot/dts/synaptics/Makefile
 rename arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct-dmp.dts (90%)
 rename arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct-stb.dts (90%)
 rename arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct.dtsi (98%)

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 6cff81eeaae2..28f94a95c2fc 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -1,7 +1,3 @@
-# Berlin SoC Family
-dtb-$(CONFIG_ARCH_BERLIN) += berlin4ct-dmp.dtb
-dtb-$(CONFIG_ARCH_BERLIN) += berlin4ct-stb.dtb
-
 # Mvebu SoC Family
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
diff --git a/arch/arm64/boot/dts/synaptics/Makefile b/arch/arm64/boot/dts/synaptics/Makefile
new file mode 100644
index 000000000000..e2e81dd476ad
--- /dev/null
+++ b/arch/arm64/boot/dts/synaptics/Makefile
@@ -0,0 +1,7 @@
+# Berlin SoC Family
+dtb-$(CONFIG_ARCH_BERLIN) += berlin4ct-dmp.dtb
+dtb-$(CONFIG_ARCH_BERLIN) += berlin4ct-stb.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts b/arch/arm64/boot/dts/synaptics/berlin4ct-dmp.dts
similarity index 90%
rename from arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
rename to arch/arm64/boot/dts/synaptics/berlin4ct-dmp.dts
index fae6c6924705..8c6bef792d34 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
+++ b/arch/arm64/boot/dts/synaptics/berlin4ct-dmp.dts
@@ -1,7 +1,8 @@
 /*
+ * Copyright (C) 2017 Synaptics Incorporated
  * Copyright (C) 2015 Marvell Technology Group Ltd.
  *
- * Author: Jisheng Zhang <jszhang@marvell.com>
+ * Author: Jisheng Zhang <jszhang@kernel.org>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPLv2 or the X11 license, at your option. Note that this dual
@@ -47,8 +48,8 @@
 #include "berlin4ct.dtsi"
 
 / {
-	model = "Marvell BG4CT DMP board";
-	compatible = "marvell,berlin4ct-dmp", "marvell,berlin4ct", "marvell,berlin";
+	model = "Synaptics BG4CT DMP board";
+	compatible = "syna,berlin4ct-dmp", "marvell,berlin4ct-dmp", "marvell,berlin4ct", "marvell,berlin";
 
 	chosen {
 		stdout-path = "serial0:115200n8";
diff --git a/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts b/arch/arm64/boot/dts/synaptics/berlin4ct-stb.dts
similarity index 90%
rename from arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
rename to arch/arm64/boot/dts/synaptics/berlin4ct-stb.dts
index d47edad13e68..ef18bf2d3542 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
+++ b/arch/arm64/boot/dts/synaptics/berlin4ct-stb.dts
@@ -1,7 +1,8 @@
 /*
+ * Copyright (C) 2017 Synaptics Incorporated
  * Copyright (C) 2015 Marvell Technology Group Ltd.
  *
- * Author: Jisheng Zhang <jszhang@marvell.com>
+ * Author: Jisheng Zhang <jszhang@kernel.org>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPLv2 or the X11 license, at your option. Note that this dual
@@ -47,8 +48,8 @@
 #include "berlin4ct.dtsi"
 
 / {
-	model = "Marvell BG4CT STB board";
-	compatible = "marvell,berlin4ct-stb", "marvell,berlin4ct", "marvell,berlin";
+	model = "Synaptics BG4CT STB board";
+	compatible = "syna,berlin4ct-stb", "marvell,berlin4ct-stb", "marvell,berlin4ct", "marvell,berlin";
 
 	chosen {
 		stdout-path = "serial0:115200n8";
diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/synaptics/berlin4ct.dtsi
similarity index 98%
rename from arch/arm64/boot/dts/marvell/berlin4ct.dtsi
rename to arch/arm64/boot/dts/synaptics/berlin4ct.dtsi
index d6b800fd26d0..642ea37a25ae 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
+++ b/arch/arm64/boot/dts/synaptics/berlin4ct.dtsi
@@ -1,7 +1,8 @@
 /*
+ * Copyright (C) 2017 Synaptics Incorporated
  * Copyright (C) 2015 Marvell Technology Group Ltd.
  *
- * Author: Jisheng Zhang <jszhang@marvell.com>
+ * Author: Jisheng Zhang <jszhang@kernel.org>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPLv2 or the X11 license, at your option. Note that this dual
@@ -45,7 +46,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
-	compatible = "marvell,berlin4ct", "marvell,berlin";
+	compatible = "syna,berlin", "marvell,berlin4ct", "marvell,berlin";
 	interrupt-parent = <&gic>;
 	#address-cells = <2>;
 	#size-cells = <2>;
-- 
2.14.1
