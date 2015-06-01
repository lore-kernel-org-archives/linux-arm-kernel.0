From: vigneshr@ti.com (Vignesh R)
Date: Mon, 1 Jun 2015 17:23:32 +0530
Subject: [PATCH 3/5] ARM: dts: DRA7: Add TBCLK for PWMSS
In-Reply-To: <1433159614-437-1-git-send-email-vigneshr@ti.com>
References: <1433159614-437-1-git-send-email-vigneshr@ti.com>
Message-ID: <1433159614-437-4-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tbclk is used by ehrpwm to generate PWM waveform on DRA7 SoC. Add Linux
clock to control ehrpwm tbclk.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi          |  5 +++++
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index f03a091cd076..387c76ca41f9 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -131,6 +131,11 @@
 							regulator-max-microvolt = <3000000>;
 						};
 					};
+
+					scm_conf_clocks: clocks {
+						#address-cells = <1>;
+						#size-cells = <0>;
+					};
 				};
 
 				dra7_pmx_core: pinmux at 1400 {
diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 3b933f74d000..92452d61cf58 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -2136,3 +2136,29 @@
 		clocks = <&dpll_usb_ck>;
 	};
 };
+
+&scm_conf_clocks {
+       ehrpwm0_tbclk: ehrpwm0_tbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l4_root_clk_div>;
+		ti,bit-shift = <20>;
+		reg = <0x0558>;
+	};
+
+	ehrpwm1_tbclk: ehrpwm1_tbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l4_root_clk_div>;
+		ti,bit-shift = <21>;
+		reg = <0x0558>;
+	};
+
+	ehrpwm2_tbclk: ehrpwm2_tbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l4_root_clk_div>;
+		ti,bit-shift = <22>;
+		reg = <0x0558>;
+	};
+};
-- 
2.4.1
