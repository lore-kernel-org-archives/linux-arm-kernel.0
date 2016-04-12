From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 12 Apr 2016 16:16:44 +0100
Subject: [PATCH 5/5] ARM: STi: DT: STiH407: Add the flashss voltage regulator
 DT node.
In-Reply-To: <1460474204-5351-1-git-send-email-peter.griffin@linaro.org>
References: <1460474204-5351-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1460474204-5351-6-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the DT node for the flashss mmc voltage regulator.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/stihxxx-b2120.dtsi  |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 81f8121..2d62036 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -488,6 +488,17 @@
 			status = "disabled";
 		};
 
+		vqmmc_reg: voltage-regulator {
+			compatible = "st,vqmmc";
+			regulator-name = "vqmmc0";
+			/* Control register for the VSENSE Module */
+			reg = <0x9061004 0x4>;
+			status = "disabled";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
 		mmc0: sdhci at 09060000 {
 			compatible = "st,sdhci-stih407", "st,sdhci";
 			status = "disabled";
@@ -501,6 +512,7 @@
 			clocks = <&clk_s_c0_flexgen CLK_MMC_0>;
 			bus-width = <8>;
 			non-removable;
+			vqmmc-supply = <&vqmmc_reg>;
 		};
 
 		mmc1: sdhci at 09080000 {
diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 133375b..f326d57 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -72,6 +72,10 @@
 			status = "okay";
 		};
 
+		vqmmc_reg: voltage-regulator {
+			status = "okay";
+		};
+
 		/* SSC11 to HDMI */
 		hdmiddc: i2c at 9541000 {
 			status = "okay";
-- 
1.9.1
