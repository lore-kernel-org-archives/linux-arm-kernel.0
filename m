From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  4 Sep 2013 10:31:33 +0100
Subject: [PATCH 01/11] ARM: ux500: Remove PrimeCell IDs from Nomadik I2C DT
 nodes
In-Reply-To: <1378287103-21765-1-git-send-email-lee.jones@linaro.org>
References: <1378287103-21765-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1378287103-21765-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Turns out that they're actually not required and the driver probes just
fine without them. The ID is incorrect at the moment anyway. They actually
currently specify the stn8815.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index a152945..9c01d66 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -531,7 +531,6 @@
 			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
 			reg = <0x80004000 0x1000>;
 			interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
-			arm,primecell-periphid = <0x180024>;
 
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -544,7 +543,6 @@
 			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
 			reg = <0x80122000 0x1000>;
 			interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
-			arm,primecell-periphid = <0x180024>;
 
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -557,7 +555,6 @@
 			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
 			reg = <0x80128000 0x1000>;
 			interrupts = <0 55 IRQ_TYPE_LEVEL_HIGH>;
-			arm,primecell-periphid = <0x180024>;
 
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -570,7 +567,6 @@
 			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
 			reg = <0x80110000 0x1000>;
 			interrupts = <0 12 IRQ_TYPE_LEVEL_HIGH>;
-			arm,primecell-periphid = <0x180024>;
 
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -583,7 +579,6 @@
 			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
 			reg = <0x8012a000 0x1000>;
 			interrupts = <0 51 IRQ_TYPE_LEVEL_HIGH>;
-			arm,primecell-periphid = <0x180024>;
 
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.8.1.2
