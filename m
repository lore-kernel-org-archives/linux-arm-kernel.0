From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 6 Nov 2015 16:59:30 +0100
Subject: [PATCH 2/2] ARM: at91/dt: sama5d2 Xplained: add regulators for sdhci
 devices
In-Reply-To: <1446825570-30029-1-git-send-email-ludovic.desroches@atmel.com>
References: <1446825570-30029-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1446825570-30029-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add vmmc and vqmmc regulators for sdhci devices.

The voltage for sdmmc0 vqmmc is selected by a signal from coming from
the sdhci device.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 361cbf8..1ca4942 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -96,6 +96,8 @@
 			bus-width = <8>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_sdmmc0_default>;
+			vmmc-supply = <&vdd_3v3_reg>;
+			vqmmc-supply = <&vdd_sdhc_reg>;
 			non-removable;
 			mmc-ddr-1_8v;
 			status = "okay";
@@ -105,6 +107,8 @@
 			bus-width = <4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_sdmmc1_default>;
+			vmmc-supply = <&vdd_3v3_reg>;
+			vqmmc-supply = <&vdd_3v3_reg>;
 			status = "okay"; /* conflict with qspi0 */
 		};
 
@@ -355,4 +359,14 @@
 			};
 		};
 	};
+
+	vdd_sdhc_reg: regulator at 0 {
+		regulator-name = "VDD_SDHC";
+		vin_1v8-supply = <&vdd_sdhc_1v8_reg>;
+		vin_3v3-supply = <&vdd_3v3_reg>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		states = <1800000 0x1
+			  3300000 0x0>;
+	};
 };
-- 
2.5.0
