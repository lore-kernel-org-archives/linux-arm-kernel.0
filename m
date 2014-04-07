From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 7 Apr 2014 10:08:32 -0500
Subject: [PATCHv2] ARM: socfpga: dts: add eeprom and rtc on i2c0
Message-ID: <1396883312-6195-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The Altera Cyclone5 and Arria5 devkit has an EEPROM and a RTC on the
board. This patch adds support for them.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
v2: Remove LCD as the driver has not been upstreamed.
---
 arch/arm/boot/dts/socfpga_arria5_socdk.dts   |   15 +++++++++++++++
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts |   15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria5_socdk.dts b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
index 88e4a8e..a04061f 100644
--- a/arch/arm/boot/dts/socfpga_arria5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
@@ -59,3 +59,18 @@
 	rxdv-skew-ps = <0>;
 	rxc-skew-ps = <2000>;
 };
+
+&i2c0 {
+	status = "okay";
+
+	eeprom at 51 {
+		compatible = "atmel,24c32";
+		reg = <0x51>;
+		pagesize = <32>;
+	};
+
+	rtc at 68 {
+		compatible = "dallas,ds1339";
+		reg = <0x68>;
+	};
+};
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
index 5e9445a..55d54f7 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
@@ -52,3 +52,18 @@
 	rxdv-skew-ps = <0>;
 	rxc-skew-ps = <2000>;
 };
+
+&i2c0 {
+	status = "okay";
+
+	eeprom at 51 {
+		compatible = "atmel,24c32";
+		reg = <0x51>;
+		pagesize = <32>;
+	};
+
+	rtc at 68 {
+		compatible = "dallas,ds1339";
+		reg = <0x68>;
+	};
+};
-- 
1.7.9.5
