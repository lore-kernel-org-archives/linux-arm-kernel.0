From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 19 Jul 2013 15:13:49 +0100
Subject: [PATCH 13/13] ARM: ux500: Remove u9540.dts as it's been replaced
In-Reply-To: <1374243229-8585-1-git-send-email-lee.jones@linaro.org>
References: <1374243229-8585-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1374243229-8585-14-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This must have been a merge error. There was a patch which renamed the
u9540.dts to ccu9540.dts, however the u9540.dts was reincarnate with
the same patches which created it in the first place. Let's kill it
once and for all.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/u9540.dts | 72 ---------------------------------------------
 1 file changed, 72 deletions(-)
 delete mode 100644 arch/arm/boot/dts/u9540.dts

diff --git a/arch/arm/boot/dts/u9540.dts b/arch/arm/boot/dts/u9540.dts
deleted file mode 100644
index 95892ec..0000000
--- a/arch/arm/boot/dts/u9540.dts
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * Copyright 2012 ST-Ericsson AB
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-
-/dts-v1/;
-/include/ "dbx5x0.dtsi"
-
-/ {
-	model = "ST-Ericsson U9540 platform with Device Tree";
-	compatible = "st-ericsson,u9540";
-
-	memory {
-		reg = <0x00000000 0x20000000>;
-	};
-
-	soc-u9500 {
-		uart at 80120000 {
-			status = "okay";
-		};
-
-		uart at 80121000 {
-			status = "okay";
-		};
-
-		uart at 80007000 {
-			status = "okay";
-		};
-
-		// External Micro SD slot
-		sdi0_per1 at 80126000 {
-			arm,primecell-periphid = <0x10480180>;
-			max-frequency = <100000000>;
-			bus-width = <4>;
-			mmc-cap-sd-highspeed;
-			mmc-cap-mmc-highspeed;
-			vmmc-supply = <&ab8500_ldo_aux3_reg>;
-
-			cd-gpios  = <&gpio7 6 0x4>; // 230
-			cd-inverted;
-
-			status = "okay";
-		};
-
-
-		// WLAN SDIO channel
-		sdi1_per2 at 80118000 {
-			arm,primecell-periphid = <0x10480180>;
-			max-frequency = <50000000>;
-			bus-width = <4>;
-
-			status = "okay";
-		};
-
-		// On-board eMMC
-		sdi4_per2 at 80114000 {
-			arm,primecell-periphid = <0x10480180>;
-		        max-frequency = <100000000>;
-			bus-width = <8>;
-			mmc-cap-mmc-highspeed;
-			vmmc-supply = <&ab8500_ldo_aux2_reg>;
-
-			status = "okay";
-		};
-	};
-};
-- 
1.8.1.2
