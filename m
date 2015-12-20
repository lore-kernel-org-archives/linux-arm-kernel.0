From: marex@denx.de (Marek Vasut)
Date: Mon, 21 Dec 2015 00:36:21 +0100
Subject: [PATCH V2] ARM: socfpga: dts: Enable MMC support at correct place in
 the DT
Message-ID: <1450654581-5070-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The socfpga.dtsi explicitly enabled MMC support, but not all boards are
equiped with an MMC card. There are setups which only have QSPI NOR.
Therefore, disable the MMC support on socfpga.dtsi level and enable it
on per-board basis.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alan Tull <atull@altera.com>
Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Thor Thayer <tthayer@altera.com>
Cc: Vince Bridgers <vbridgers2013@gmail.com>
---
 arch/arm/boot/dts/socfpga.dtsi                    | 1 +
 arch/arm/boot/dts/socfpga_arria5_socdk.dts        | 1 +
 arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts | 1 +
 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi       | 1 +
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts      | 1 +
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts     | 1 +
 6 files changed, 6 insertions(+)

NOTE: This should not cause any trouble, since I checked all the boards
      for the presence of the HPS SD card slot / eMMC.

V2: Rebase on top of pristine next/master with just the MCV correction patch

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 39c470e..3ed4abd 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -677,6 +677,7 @@
 			#size-cells = <0>;
 			clocks = <&l4_mp_clk>, <&sdmmc_clk_divided>;
 			clock-names = "biu", "ciu";
+			status = "disabled";
 		};
 
 		ocram: sram at ffff0000 {
diff --git a/arch/arm/boot/dts/socfpga_arria5_socdk.dts b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
index a75a666..3c88678 100644
--- a/arch/arm/boot/dts/socfpga_arria5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
@@ -79,6 +79,7 @@
 &mmc0 {
 	vmmc-supply = <&regulator_3_3v>;
 	vqmmc-supply = <&regulator_3_3v>;
+	status = "okay";
 };
 
 &usb1 {
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
index 555e9ca..afea364 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
@@ -100,6 +100,7 @@
 &mmc0 {
 	vmmc-supply = <&regulator_3_3v>;
 	vqmmc-supply = <&regulator_3_3v>;
+	status = "okay";
 };
 
 &uart0 {
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi b/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
index baecd98..f86f9c0 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
@@ -30,4 +30,5 @@
 
 &mmc0 {	/* On-SoM eMMC */
 	bus-width = <8>;
+	status = "okay";
 };
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
index d4d0a28..15e43f4 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
@@ -84,6 +84,7 @@
 	cd-gpios = <&portb 18 0>;
 	vmmc-supply = <&regulator_3_3v>;
 	vqmmc-supply = <&regulator_3_3v>;
+	status = "okay";
 };
 
 &usb1 {
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
index 48bf651..b61f22f 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
@@ -80,6 +80,7 @@
 &mmc0 {
 	vmmc-supply = <&regulator_3_3v>;
 	vqmmc-supply = <&regulator_3_3v>;
+	status = "okay";
 };
 
 &usb1 {
-- 
2.1.4
