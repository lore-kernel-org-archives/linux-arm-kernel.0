From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed,  1 May 2013 14:46:59 +0400
Subject: [PATCH 3/3] ARM: dts: Add MC13783 support for i.MX27 Phytec PCM038
 module
In-Reply-To: <1367405219-19078-1-git-send-email-shc_work@mail.ru>
References: <1367405219-19078-1-git-send-email-shc_work@mail.ru>
Message-ID: <1367405219-19078-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added MC13783 node to imx27-phytec-phycore DT file.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore.dts | 92 ++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore.dts b/arch/arm/boot/dts/imx27-phytec-phycore.dts
index b0e9372..5c4fea9 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore.dts
@@ -76,6 +76,98 @@
 	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio4 28 0>;
 	status = "okay";
+
+	pmic: mc13783 at 0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,mc13783";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <23 0x4>;
+		fsl,mc13xxx-uses-adc;
+
+		regulators {
+			sw1a_reg: sw1a {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			sw1b_reg: sw1b {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			sw2a_reg: sw2a {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			sw2b_reg: sw2b {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			sw3_reg: sw3 {
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5000000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			vaudio_reg: vaudio {
+				regulator-min-microvolt = <2775000>;
+				regulator-max-microvolt = <2775000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			violo_reg: violo {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			viohi_reg: viohi {
+				regulator-min-microvolt = <2775000>;
+				regulator-max-microvolt = <2775000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			vgen_reg: vgen {
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			vcam_reg: vcam {
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+			};
+			vrf1_reg: vrf1 {
+				regulator-min-microvolt = <2775000>;
+				regulator-max-microvolt = <2775000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			vrf2_reg: vrf2 {
+				regulator-min-microvolt = <2775000>;
+				regulator-max-microvolt = <2775000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			vmmc1_reg: vmmc1 {
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3000000>;
+			};
+			gpo1_reg: gpo1 {
+			};
+			pwgt1spi_reg: pwgt1spi {
+			};
+		};
+	};
 };
 
 &nfc {
-- 
1.8.1.5
