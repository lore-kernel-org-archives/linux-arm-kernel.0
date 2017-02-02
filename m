From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 Feb 2017 12:38:33 +0100
Subject: [PATCH] ARM: orion5x: fix Makefile for linkstation-lschl.dtb
Message-ID: <20170202113856.728043-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rename of orion5x-lschl.dts needs to be reflected in the Makefile:

make[3]: *** No rule to make target 'arch/arm/boot/dts/orion5x-lschl.dtb', needed by '__build'.

Fixes: 6cfd3cd8d836 ("ARM: dts: orion5x-lschl: More consistent naming on linkstation series")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 10eec600cf6b..47208fc5a750 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -633,7 +633,7 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
 	orion5x-lacie-ethernet-disk-mini-v2.dtb \
 	orion5x-linkstation-lsgl.dtb \
 	orion5x-linkstation-lswtgl.dtb \
-	orion5x-lschl.dtb \
+	orion5x-linkstation-lschl.dtb \
 	orion5x-lswsgl.dtb \
 	orion5x-maxtor-shared-storage-2.dtb \
 	orion5x-netgear-wnr854t.dtb \
-- 
2.9.0
