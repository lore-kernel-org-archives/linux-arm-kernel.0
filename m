From: robh@kernel.org (Rob Herring)
Date: Thu, 13 Sep 2018 13:12:37 -0500
Subject: [PATCH] ARM: dts: socfpga: Fix I2C bus unit-address error
Message-ID: <20180913181245.25484-13-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc has new checks for I2C buses. Fix the warnings in unit-addresses.

arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dtb: Warning (i2c_bus_reg): /soc/i2c at ffc04000/adxl345 at 0: I2C bus unit address format error, expected "53"

Cc: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please apply to the sub-arch tree. The dtc changes haven't landed, but 
will for 4.20.

 arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
index b280e6494193..31b01a998b2e 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
@@ -88,7 +88,7 @@
 	status = "okay";
 	clock-frequency = <100000>;
 
-	adxl345: adxl345 at 0 {
+	adxl345: adxl345 at 53 {
 		compatible = "adi,adxl345";
 		reg = <0x53>;
 
-- 
2.17.1
