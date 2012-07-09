From: anilkumar@ti.com (AnilKumar Ch)
Date: Mon, 9 Jul 2012 11:54:09 +0530
Subject: [PATCH] arm/dts: remove MMC/SD and SPI related entries from
 am33xx.dtsi
Message-ID: <1341815049-3947-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMC/SD and SPI entries in this file are not tested yet. They
inadvertently came into the patch because of some work in progress
stuff I had in my repo.

These entries should not have been sent out in the first place and
I am sorry for the trouble and will be extra careful in future.

Since the offending commit is not sent upstream yet, I hope this can
be merged into the commit 5fc0b42a98556bd9f01cecc6a64fcbd15ec363f0
(arm/dts: Add initial DT support for AM33XX SoC family) on the devel-dt
branch of linux-omap tree.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index f46e353..59509c4 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -154,36 +154,5 @@
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
 		};
-
-		mcspi1: spi at 48030000 {
-			compatible = "ti,omap2-mcspi";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			ti,hwmods = "spi0";
-			ti,spi-num-cs = <4>;
-		};
-
-		mcspi2: spi at 481Aa000 {
-			compatible = "ti,omap2-mcspi";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			ti,hwmods = "spi1";
-			ti,spi-num-cs = <2>;
-		};
-
-		mmc1: mmc at 48060000 {
-			compatible = "ti,omap3-hsmmc";
-			ti,hwmods = "mmc1";
-		};
-
-		mmc2: mmc at 481D8000 {
-			compatible = "ti,omap3-hsmmc";
-			ti,hwmods = "mmc2";
-		};
-
-		mmc3: mmc at 47810000 {
-			compatible = "ti,omap3-hsmmc";
-			ti,hwmods = "mmc3";
-		};
 	};
 };
-- 
1.7.9.5
