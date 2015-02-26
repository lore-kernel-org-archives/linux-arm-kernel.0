From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:22:04 +0900
Subject: [PATCH 03/12] ARM: shmobile: mackerel dts: Remove Legacy DTS file
In-Reply-To: <cover.1424931560.git.horms+renesas@verge.net.au>
References: <cover.1424931560.git.horms+renesas@verge.net.au>
Message-ID: <c1b7506b52f9a112c64a44d449fb9e2a55f2060d.1424931560.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove the DTS file for the no longer supported Mackerel board.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile            |  1 -
 arch/arm/boot/dts/sh7372-mackerel.dts | 26 --------------------------
 2 files changed, 27 deletions(-)
 delete mode 100644 arch/arm/boot/dts/sh7372-mackerel.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a1c776b..0d467b8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -470,7 +470,6 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
 	r8a7778-bockw.dtb \
 	r8a7778-bockw-reference.dtb \
 	r8a7779-marzen.dtb \
-	sh7372-mackerel.dtb \
 	sh73a0-kzm9g.dtb \
 	sh73a0-kzm9g-reference.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
diff --git a/arch/arm/boot/dts/sh7372-mackerel.dts b/arch/arm/boot/dts/sh7372-mackerel.dts
deleted file mode 100644
index a759a27..0000000
--- a/arch/arm/boot/dts/sh7372-mackerel.dts
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * Device Tree Source for the mackerel board
- *
- * Copyright (C) 2012 Renesas Solutions Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-/dts-v1/;
-#include "sh7372.dtsi"
-
-/ {
-	model = "Mackerel (AP4 EVM 2nd)";
-	compatible = "renesas,mackerel";
-
-	chosen {
-		bootargs = "console=tty0, console=ttySC0,115200 earlyprintk=sh-sci.0,115200 root=/dev/nfs nfsroot=,tcp,v3 ip=dhcp mem=240m rw";
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x40000000 0x10000000>;
-	};
-};
-- 
2.1.4
