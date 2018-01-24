From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 24 Jan 2018 22:33:14 +0100
Subject: [PATCH] ARM: dts: consistently use 'atmel' as at24 manufacturer in
 cyclone5
Message-ID: <20180124213314.4546-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using 'at' or 'at24' as the <manufacturer> part of the compatible
string is now deprecated. Use a correct value: 'atmel,<model>'.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
index 2459d133f1be..f50b19447de6 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
@@ -161,7 +161,7 @@
 	};
 
 	at24 at 50 {
-		compatible = "at24,24c01";
+		compatible = "atmel,24c01";
 		pagesize = <8>;
 		reg = <0x50>;
 	};
@@ -213,7 +213,7 @@
 			#size-cells = <0>;
 			reg = <6>;
 			eeprom at 51 {
-				compatible = "at,24c01";
+				compatible = "atmel,24c01";
 				pagesize = <8>;
 				reg = <0x51>;
 			};
@@ -224,7 +224,7 @@
 			#size-cells = <0>;
 			reg = <7>;
 			eeprom at 51 {
-				compatible = "at,24c01";
+				compatible = "atmel,24c01";
 				pagesize = <8>;
 				reg = <0x51>;
 			};
-- 
2.16.1
