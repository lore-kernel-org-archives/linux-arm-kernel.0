From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue,  9 May 2017 09:27:16 -0500
Subject: [PATCH] ARM: dts: socfpga: set the i2c frequency
Message-ID: <1494340036-26099-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use 'clock-frequency' binding for the i2c node that will put the I2C driver
into the standard operating mode. 'speed-mode' was not a valid binding for
the I2C driver, remove it.

Signed-off-by: Alan Tull <atull@kernel.org>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi      | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
index c57e6ce..0a500e77 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
@@ -125,13 +125,13 @@
 };
 
 &i2c1 {
-	speed-mode = <0>;
 	status = "okay";
 
 	/*
 	 * adjust the falling times to decrease the i2c frequency to 50Khz
 	 * because the LCD module does not work at the standard 100Khz
 	 */
+	clock-frequency = <100000>;
 	i2c-sda-falling-time-ns = <6000>;
 	i2c-scl-falling-time-ns = <6000>;
 
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
index 5ecd2ef..b13642c 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
@@ -86,7 +86,7 @@
 
 &i2c0 {
 	status = "okay";
-	speed-mode = <0>;
+	clock-frequency = <100000>;
 
 	adxl345: adxl345 at 0 {
 		compatible = "adi,adxl345";
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts b/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
index e5a98e5..7221908 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
@@ -58,7 +58,7 @@
 
 &i2c0 {
 	status = "okay";
-	speed-mode = <0>;
+	clock-frequency = <100000>;
 
 	stmpe1: stmpe811 at 41 {
 		compatible = "st,stmpe811";
-- 
2.7.4
