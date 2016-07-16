From: stillcompiling@gmail.com (Joshua Clayton)
Date: Fri, 15 Jul 2016 17:18:23 -0700
Subject: [RCF 3/3] ARM: imx6q-evi: ads ads1118 support
In-Reply-To: <cover.1468626668.git.stillcompiling@gmail.com>
References: <cover.1468626668.git.stillcompiling@gmail.com>
Message-ID: <582a9226dab419d27ea90e21c723856e4669a81c.1468626668.git.stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add support to imx6q-evi for the 3 ADS1118 temperature/adc units,
 now that is has has a kernel driver

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 arch/arm/boot/dts/imx6q-evi.dts | 90 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/imx6q-evi.dts
index 4fa5601..7e175bf 100644
--- a/arch/arm/boot/dts/imx6q-evi.dts
+++ b/arch/arm/boot/dts/imx6q-evi.dts
@@ -105,6 +105,66 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi3 &pinctrl_ecspi3cs>;
 	status = "okay";
+
+	temp1: adc at 0 {
+		compatible = "ti,ads1118";
+		spi-max-frequency = <500000>;
+		spi-cpha;
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		ti,tempsensor;
+		cpu-v at 0 {
+			reg = <0>;
+			ti,fullscale = <6144000>;
+			ti,datarate = <860>;
+		};
+		cpld at 1 {
+			reg = <1>;
+			ti,fullscale = <6144000>;
+			ti,datarate = <860>;
+		};
+		vocm at 2 {
+			reg = <2>;
+			ti,fullscale = <6144000>;
+			ti,datarate = <860>;
+		};
+		fpga at 3 {
+			reg = <3>;
+			ti,fullscale = <6144000>;
+			ti,datarate = <860>;
+		};
+	};
+
+	adc2: adc at 1 {
+		compatible = "ti,ads1118";
+		spi-max-frequency = <500000>;
+		spi-cpha;
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		ti,tempsensor;
+		signal at 0 {
+			reg = <0>;
+			ti,fullscale = <6144000>;
+			ti,datarate = <860>;
+		};
+		signal at 1 {
+			reg = <1>;
+			ti,fullscale = <6144000>;
+			ti,datarate = <860>;
+		};
+		probedrive at 2 {
+			reg = <2>;
+			ti,fullscale = <6144000>;
+			ti,datarate = <860>;
+		};
+		probedrive at 3 {
+			reg = <3>;
+			ti,fullscale = <6144000>;
+			ti,datarate = <860>;
+		};
+	};
 };
 
 &ecspi5 {
@@ -126,6 +186,36 @@
 		reg = <1>;
 	};
 
+	temp0: temp at 2 {
+		compatible = "ti,ads1118";
+		spi-max-frequency = <500000>;
+		spi-cpha;
+		reg = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		ti,tempsensor;
+		analog-x at 0 {
+			reg = <0>;
+			ti,fullscale = <6144000>;
+			ti,datarate = <860>;
+		};
+		analog-y at 1 {
+			reg = <1>;
+			ti,fullscale = <6144000>;
+			ti,datarate = <860>;
+		};
+		main-12v at 2 {
+			reg = <2>;
+			ti,fullscale = <6144000>;
+			ti,datarate = <860>;
+		};
+		battbox at 3 {
+			reg = <3>;
+			ti,fullscale = <6144000>;
+			ti,datarate = <860>;
+		};
+	};
+
 	pb_rtc: rtc at 3 {
 		compatible = "nxp,rtc-pcf2123";
 		spi-max-frequency = <2450000>;
-- 
2.7.4
