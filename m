From: marex@denx.de (Marek Vasut)
Date: Fri, 18 Dec 2015 00:38:18 +0100
Subject: [PATCH] ARM: socfpga: Repair incorrectly applied MCV patch
Message-ID: <1450395498-9827-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For whatever reason, this patch was not applied verbatim and had all
tabs replaced with spaces. Replace them back by a quick sed.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alan Tull <atull@altera.com>
Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Thor Thayer <tthayer@altera.com>
Cc: Vince Bridgers <vbridgers2013@gmail.com>
---
 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi   | 18 +++---
 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts | 90 +++++++++++++--------------
 2 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi b/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
index f0e03a2..baecd98 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
@@ -18,16 +18,16 @@
 #include "socfpga_cyclone5.dtsi"
 
 / {
-       model = "DENX MCV";
-       compatible = "altr,socfpga-cyclone5", "altr,socfpga";
+	model = "DENX MCV";
+	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
 
-       memory {
-               name = "memory";
-               device_type = "memory";
-               reg = <0x0 0x40000000>; /* 1 GiB */
-       };
+	memory {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x40000000>; /* 1 GiB */
+	};
 };
 
-&mmc0 {        /* On-SoM eMMC */
-       bus-width = <8>;
+&mmc0 {	/* On-SoM eMMC */
+	bus-width = <8>;
 };
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts b/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
index 09d0ded..7186a29 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
@@ -18,77 +18,77 @@
 #include "socfpga_cyclone5_mcv.dtsi"
 
 / {
-       model = "DENX MCV EVK";
-       compatible = "altr,socfpga-cyclone5", "altr,socfpga";
+	model = "DENX MCV EVK";
+	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
 
-       aliases {
-               ethernet0 = &gmac0;
-               stmpe-i2c0 = &stmpe1;
-       };
+	aliases {
+		ethernet0 = &gmac0;
+		stmpe-i2c0 = &stmpe1;
+	};
 
-       chosen {
-               stdout-path = "serial0:115200n8";
-       };
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
 };
 
 &can0 {
-       status = "okay";
+	status = "okay";
 };
 
 &can1 {
-       status = "okay";
+	status = "okay";
 };
 
 &gmac0 {
-       phy-mode = "rgmii";
-       status = "okay";
+	phy-mode = "rgmii";
+	status = "okay";
 };
 
-&gpio0 {       /* GPIO  0 ... 28 */
-       status = "okay";
+&gpio0 {	/* GPIO  0 ... 28 */
+	status = "okay";
 };
 
-&gpio1 {       /* GPIO 29 ... 57 */
-       status = "okay";
+&gpio1 {	/* GPIO 29 ... 57 */
+	status = "okay";
 };
 
-&gpio2 {       /* GPIO 58..66 (HLGPI 0..13 at offset 13) */
-       status = "okay";
+&gpio2 {	/* GPIO 58..66 (HLGPI 0..13 at offset 13) */
+	status = "okay";
 };
 
 &i2c0 {
-       status = "okay";
-       speed-mode = <0>;
+	status = "okay";
+	speed-mode = <0>;
 
-       stmpe1: stmpe811 at 41 {
-               compatible = "st,stmpe811";
-               #address-cells = <1>;
-               #size-cells = <0>;
-               reg = <0x41>;
-               id = <0>;
-               blocks = <0x5>;
-               irq-gpio = <&portb 28 0x4>;     /* GPIO 57, trig. level HI */
+	stmpe1: stmpe811 at 41 {
+		compatible = "st,stmpe811";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x41>;
+		id = <0>;
+		blocks = <0x5>;
+		irq-gpio = <&portb 28 0x4>;     /* GPIO 57, trig. level HI */
 
-               stmpe_touchscreen {
-                       compatible = "st,stmpe-ts";
-                       reg = <0>;
-                       ts,sample-time = <4>;
-                       ts,mod-12b = <1>;
-                       ts,ref-sel = <0>;
-                       ts,adc-freq = <1>;
-                       ts,ave-ctrl = <1>;
-                       ts,touch-det-delay = <3>;
-                       ts,settling = <4>;
-                       ts,fraction-z = <7>;
-                       ts,i-drive = <1>;
-               };
-       };
+		stmpe_touchscreen {
+			compatible = "st,stmpe-ts";
+			reg = <0>;
+			ts,sample-time = <4>;
+			ts,mod-12b = <1>;
+			ts,ref-sel = <0>;
+			ts,adc-freq = <1>;
+			ts,ave-ctrl = <1>;
+			ts,touch-det-delay = <3>;
+			ts,settling = <4>;
+			ts,fraction-z = <7>;
+			ts,i-drive = <1>;
+		};
+	};
 };
 
 &uart0 {
-       status = "okay";
+	status = "okay";
 };
 
 &usb1 {
-       status = "okay";
+	status = "okay";
 };
-- 
2.6.4
