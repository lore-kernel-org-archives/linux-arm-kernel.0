From: marex@denx.de (Marek Vasut)
Date: Thu,  4 May 2017 12:29:48 +0200
Subject: [PATCH 2/4] ARM: dts: socfpga: Remove I2C EEPROMs from VINING FPGA
In-Reply-To: <20170504102950.10667-1-marex@denx.de>
References: <20170504102950.10667-1-marex@denx.de>
Message-ID: <20170504102950.10667-2-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the EEPROMs attached to the I2C expander ports which
lead to the backplane slots from the main VIN|ING DTS file.
These EEPROMs are bound using separate DTO files, which lets
us handle both two-slot and six-slot configuration of the
backplane.

Signed-off-by: Marek Vasut <marex@denx.de>
---
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 34 ++--------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
index cb4bdbcf54ee..268785ecb82a 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
@@ -203,69 +203,39 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
-			eeprom at 51 {
-				compatible = "at,24c01";
-				pagesize = <8>;
-				reg = <0x51>;
-			};
 		};
 
 		i2c at 1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
-			eeprom at 51 {
-				compatible = "at,24c01";
-				pagesize = <8>;
-				reg = <0x51>;
-			};
 		};
 
 		i2c at 2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
-			eeprom at 51 {
-				compatible = "at,24c01";
-				pagesize = <8>;
-				reg = <0x51>;
-			};
 		};
 
 		i2c at 3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
-			eeprom at 51 {
-				compatible = "at,24c01";
-				pagesize = <8>;
-				reg = <0x51>;
-			};
 		};
 
 		i2c at 4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <4>;
-			eeprom at 51 {
-				compatible = "at,24c01";
-				pagesize = <8>;
-				reg = <0x51>;
-			};
 		};
 
 		i2c at 5 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <5>;
-			eeprom at 51 {
-				compatible = "at,24c01";
-				pagesize = <8>;
-				reg = <0x51>;
-			};
 		};
 
-		i2c at 6 {
+		i2c at 6 {	/* Backplane EEPROM */
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <6>;
@@ -276,7 +246,7 @@
 			};
 		};
 
-		i2c at 7 {
+		i2c at 7 {	/* Power board EEPROM */
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <7>;
-- 
2.11.0
