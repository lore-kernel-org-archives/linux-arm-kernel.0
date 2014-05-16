From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 16 May 2014 14:10:16 +0200
Subject: [PATCH 5/5] ARM: shmobile: Remove Genmai reference DTS
In-Reply-To: <1400242216-20848-1-git-send-email-wsa@the-dreams.de>
References: <1400242216-20848-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1400242216-20848-6-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Now that the DTS file r7s72100-genmai.dts can be used with
board-genmai.c and board-genmai-reference.c, proceed with removing
r7s72100-genmai-reference.dts.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r7s72100-genmai-reference.dts | 59 -------------------------
 1 file changed, 59 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r7s72100-genmai-reference.dts

diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
deleted file mode 100644
index ca88458e0706..000000000000
--- a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * Device Tree Source for the Genmai board
- *
- * Copyright (C) 2013-14 Renesas Solutions Corp.
- * Copyright (C) 2014 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-/dts-v1/;
-#include "r7s72100.dtsi"
-
-/ {
-	model = "Genmai";
-	compatible = "renesas,genmai-reference", "renesas,r7s72100";
-
-	aliases {
-		serial2 = &scif2;
-	};
-
-	chosen {
-		bootargs = "console=ttySC2,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x08000000 0x08000000>;
-	};
-
-	lbsc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-	};
-};
-
-&extal_clk {
-	clock-frequency = <13330000>;
-};
-
-&usb_x1_clk {
-	clock-frequency = <48000000>;
-};
-
-&i2c2 {
-	status = "okay";
-	clock-frequency = <400000>;
-
-	eeprom at 50 {
-		compatible = "renesas,24c128";
-		reg = <0x50>;
-		pagesize = <64>;
-	};
-};
-
-&scif2 {
-	status = "okay";
-};
-- 
1.9.2
