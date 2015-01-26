From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 26 Jan 2015 15:18:19 +0900
Subject: [PATCH 03/14 v2] ARM: shmobile: mackerel dts: Remove Legacy DTS file
In-Reply-To: <20150126061747.6848.9708.sendpatchset@little-apple>
References: <20150126061747.6848.9708.sendpatchset@little-apple>
Message-ID: <20150126061819.6848.91352.sendpatchset@little-apple>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove the DTS file for the no longer supported Mackerel board.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

 Changes since V1:
 - Rebased and resolved conflicts

 arch/arm/boot/dts/Makefile            |    1 -
 arch/arm/boot/dts/sh7372-mackerel.dts |   26 --------------------------
 2 files changed, 27 deletions(-)

--- 0001/arch/arm/boot/dts/Makefile
+++ work/arch/arm/boot/dts/Makefile	2015-01-26 13:30:37.155992584 +0900
@@ -410,7 +410,6 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
 	r8a7778-bockw.dtb \
 	r8a7778-bockw-reference.dtb \
 	r8a7779-marzen.dtb \
-	sh7372-mackerel.dtb \
 	sh73a0-kzm9g.dtb \
 	sh73a0-kzm9g-reference.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
--- 0001/arch/arm/boot/dts/sh7372-mackerel.dts
+++ /dev/null	2015-01-13 15:44:39.280208949 +0900
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
