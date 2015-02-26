From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:22:12 +0900
Subject: [PATCH 11/12] ARM: shmobile: sh7372 dtsi: Remove Legacy DTSI file
In-Reply-To: <cover.1424931560.git.horms+renesas@verge.net.au>
References: <cover.1424931560.git.horms+renesas@verge.net.au>
Message-ID: <edf41009060442258ed3090fc782835c4f9f831f.1424931560.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove the sh7372 DTSI file for the now unsupported sh7372 SoC.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh7372.dtsi | 35 -----------------------------------
 1 file changed, 35 deletions(-)
 delete mode 100644 arch/arm/boot/dts/sh7372.dtsi

diff --git a/arch/arm/boot/dts/sh7372.dtsi b/arch/arm/boot/dts/sh7372.dtsi
deleted file mode 100644
index f863a10..0000000
--- a/arch/arm/boot/dts/sh7372.dtsi
+++ /dev/null
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
-- 
2.1.4
