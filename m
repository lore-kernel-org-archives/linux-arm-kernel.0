From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 21 Jan 2015 13:54:37 +0900
Subject: [PATCH 10/13] ARM: shmobile: sh7372 dtsi: Remove Legacy DTSI file
In-Reply-To: <20150121045256.7648.7451.sendpatchset@little-apple>
References: <20150121045256.7648.7451.sendpatchset@little-apple>
Message-ID: <20150121045437.7648.13202.sendpatchset@little-apple>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove the sh7372 DTSI file for the now unsupported sh7372 SoC.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/boot/dts/sh7372.dtsi |   35 -----------------------------------
 1 file changed, 35 deletions(-)

--- 0001/arch/arm/boot/dts/sh7372.dtsi
+++ /dev/null	2015-01-13 15:44:39.280208949 +0900
@@ -1,35 +0,0 @@
-/*
- * Device Tree Source for the sh7372 SoC
- *
- * Copyright (C) 2012 Renesas Solutions Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-/include/ "skeleton.dtsi"
-
-/ {
-	compatible = "renesas,sh7372";
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu at 0 {
-			compatible = "arm,cortex-a8";
-			device_type = "cpu";
-			reg = <0x0>;
-			clock-frequency = <800000000>;
-		};
-	};
-
-	pfc: pfc at e6050000 {
-		compatible = "renesas,pfc-sh7372";
-		reg = <0xe6050000 0x8000>,
-		      <0xe605801c 0x1c>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-};
