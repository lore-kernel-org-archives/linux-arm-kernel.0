From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat,  6 Feb 2016 02:36:48 +0900
Subject: [PATCH] ARM: drop unused Makefile.boot of Multiplatform SoCs
Message-ID: <1454693808-13081-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The variable "MACHINE" is empty if CONFIG_ARCH_MULTIPLATFORM=y,
so these Makefile.boot files are never included.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-cns3xxx/Makefile.boot    | 3 ---
 arch/arm/mach-exynos/Makefile.boot     | 2 --
 arch/arm/mach-integrator/Makefile.boot | 4 ----
 arch/arm/mach-keystone/Makefile.boot   | 1 -
 arch/arm/mach-mmp/Makefile.boot        | 1 -
 arch/arm/mach-mv78xx0/Makefile.boot    | 3 ---
 arch/arm/mach-nspire/Makefile.boot     | 0
 arch/arm/mach-omap2/Makefile.boot      | 3 ---
 arch/arm/mach-orion5x/Makefile.boot    | 3 ---
 arch/arm/mach-prima2/Makefile.boot     | 3 ---
 arch/arm/mach-realview/Makefile.boot   | 9 ---------
 arch/arm/mach-s3c64xx/Makefile.boot    | 2 --
 arch/arm/mach-spear/Makefile.boot      | 3 ---
 arch/arm/mach-u300/Makefile.boot       | 4 ----
 arch/arm/mach-ux500/Makefile.boot      | 3 ---
 arch/arm/mach-zynq/Makefile.boot       | 3 ---
 16 files changed, 47 deletions(-)
 delete mode 100644 arch/arm/mach-cns3xxx/Makefile.boot
 delete mode 100644 arch/arm/mach-exynos/Makefile.boot
 delete mode 100644 arch/arm/mach-integrator/Makefile.boot
 delete mode 100644 arch/arm/mach-keystone/Makefile.boot
 delete mode 100644 arch/arm/mach-mmp/Makefile.boot
 delete mode 100644 arch/arm/mach-mv78xx0/Makefile.boot
 delete mode 100644 arch/arm/mach-nspire/Makefile.boot
 delete mode 100644 arch/arm/mach-omap2/Makefile.boot
 delete mode 100644 arch/arm/mach-orion5x/Makefile.boot
 delete mode 100644 arch/arm/mach-prima2/Makefile.boot
 delete mode 100644 arch/arm/mach-realview/Makefile.boot
 delete mode 100644 arch/arm/mach-s3c64xx/Makefile.boot
 delete mode 100644 arch/arm/mach-spear/Makefile.boot
 delete mode 100644 arch/arm/mach-u300/Makefile.boot
 delete mode 100644 arch/arm/mach-ux500/Makefile.boot
 delete mode 100644 arch/arm/mach-zynq/Makefile.boot

diff --git a/arch/arm/mach-cns3xxx/Makefile.boot b/arch/arm/mach-cns3xxx/Makefile.boot
deleted file mode 100644
index d079de0..0000000
--- a/arch/arm/mach-cns3xxx/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00C00000
diff --git a/arch/arm/mach-exynos/Makefile.boot b/arch/arm/mach-exynos/Makefile.boot
deleted file mode 100644
index b9862e2..0000000
--- a/arch/arm/mach-exynos/Makefile.boot
+++ /dev/null
@@ -1,2 +0,0 @@
-   zreladdr-y	+= 0x40008000
-params_phys-y	:= 0x40000100
diff --git a/arch/arm/mach-integrator/Makefile.boot b/arch/arm/mach-integrator/Makefile.boot
deleted file mode 100644
index ff0a4b5..0000000
--- a/arch/arm/mach-integrator/Makefile.boot
+++ /dev/null
@@ -1,4 +0,0 @@
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
-
diff --git a/arch/arm/mach-keystone/Makefile.boot b/arch/arm/mach-keystone/Makefile.boot
deleted file mode 100644
index f3835c4..0000000
--- a/arch/arm/mach-keystone/Makefile.boot
+++ /dev/null
@@ -1 +0,0 @@
-zreladdr-y	:= 0x80008000
diff --git a/arch/arm/mach-mmp/Makefile.boot b/arch/arm/mach-mmp/Makefile.boot
deleted file mode 100644
index 5edf03e..0000000
--- a/arch/arm/mach-mmp/Makefile.boot
+++ /dev/null
@@ -1 +0,0 @@
-   zreladdr-y	+= 0x00008000
diff --git a/arch/arm/mach-mv78xx0/Makefile.boot b/arch/arm/mach-mv78xx0/Makefile.boot
deleted file mode 100644
index 760a0ef..0000000
--- a/arch/arm/mach-mv78xx0/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-nspire/Makefile.boot b/arch/arm/mach-nspire/Makefile.boot
deleted file mode 100644
index e69de29..0000000
diff --git a/arch/arm/mach-omap2/Makefile.boot b/arch/arm/mach-omap2/Makefile.boot
deleted file mode 100644
index b03e562..0000000
--- a/arch/arm/mach-omap2/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-  zreladdr-y		+= 0x80008000
-params_phys-y		:= 0x80000100
-initrd_phys-y		:= 0x80800000
diff --git a/arch/arm/mach-orion5x/Makefile.boot b/arch/arm/mach-orion5x/Makefile.boot
deleted file mode 100644
index 760a0ef..0000000
--- a/arch/arm/mach-orion5x/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-prima2/Makefile.boot b/arch/arm/mach-prima2/Makefile.boot
deleted file mode 100644
index c77a488..0000000
--- a/arch/arm/mach-prima2/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-zreladdr-y		+= 0x00008000
-params_phys-y		:= 0x00000100
-initrd_phys-y		:= 0x00800000
diff --git a/arch/arm/mach-realview/Makefile.boot b/arch/arm/mach-realview/Makefile.boot
deleted file mode 100644
index d2c3d78..0000000
--- a/arch/arm/mach-realview/Makefile.boot
+++ /dev/null
@@ -1,9 +0,0 @@
-ifeq ($(CONFIG_REALVIEW_HIGH_PHYS_OFFSET),y)
-   zreladdr-y	+= 0x70008000
-params_phys-y	:= 0x70000100
-initrd_phys-y	:= 0x70800000
-else
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
-endif
diff --git a/arch/arm/mach-s3c64xx/Makefile.boot b/arch/arm/mach-s3c64xx/Makefile.boot
deleted file mode 100644
index c642333..0000000
--- a/arch/arm/mach-s3c64xx/Makefile.boot
+++ /dev/null
@@ -1,2 +0,0 @@
-   zreladdr-y	+= 0x50008000
-params_phys-y	:= 0x50000100
diff --git a/arch/arm/mach-spear/Makefile.boot b/arch/arm/mach-spear/Makefile.boot
deleted file mode 100644
index 4674a4c..0000000
--- a/arch/arm/mach-spear/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-u300/Makefile.boot b/arch/arm/mach-u300/Makefile.boot
deleted file mode 100644
index 87811de..0000000
--- a/arch/arm/mach-u300/Makefile.boot
+++ /dev/null
@@ -1,4 +0,0 @@
-   zreladdr-y	+= 0x48008000
-params_phys-y	:= 0x48000100
-# This isn't used.
-#initrd_phys-y	:= 0x48800000
diff --git a/arch/arm/mach-ux500/Makefile.boot b/arch/arm/mach-ux500/Makefile.boot
deleted file mode 100644
index 760a0ef..0000000
--- a/arch/arm/mach-ux500/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-zynq/Makefile.boot b/arch/arm/mach-zynq/Makefile.boot
deleted file mode 100644
index 760a0ef..0000000
--- a/arch/arm/mach-zynq/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
-- 
1.9.1
