From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 25 Oct 2016 18:25:20 +0200
Subject: [PATCH 08/10] ARM: dts: stm32f429: Add adc support
In-Reply-To: <1477412722-24061-1-git-send-email-fabrice.gasnier@st.com>
References: <1477412722-24061-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1477412722-24061-9-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add adc support & pinctrl analog phandle (adc3_in8) to stm32f429.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 62 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 336ee4f..3fcd941 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -172,6 +172,62 @@
 			status = "disabled";
 		};
 
+		adc: adc at 40012000 {
+			compatible = "st,stm32f4-adc";
+			reg = <0x40012000 0x400>;
+			interrupts = <18>;
+			clocks = <&rcc 0 168>;
+			clock-names = "adc";
+			status = "disabled";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			adc1: adc1-master at 0 {
+				#io-channel-cells = <1>;
+				reg = <0x0>;
+				clocks = <&rcc 0 168>;
+				status = "disabled";
+			};
+
+			jadc1: adc1-injected at 0 {
+				#io-channel-cells = <1>;
+				reg = <0x0>;
+				clocks = <&rcc 0 168>;
+				st,injected;
+				status = "disabled";
+			};
+
+			adc2: adc2-slave at 100 {
+				#io-channel-cells = <1>;
+				reg = <0x100>;
+				clocks = <&rcc 0 169>;
+				status = "disabled";
+			};
+
+			jadc2: adc2-injected at 100 {
+				#io-channel-cells = <1>;
+				reg = <0x100>;
+				clocks = <&rcc 0 169>;
+				st,injected;
+				status = "disabled";
+			};
+
+			adc3: adc3-slave at 200 {
+				#io-channel-cells = <1>;
+				reg = <0x200>;
+				clocks = <&rcc 0 170>;
+				status = "disabled";
+			};
+
+			jadc3: adc3-injected at 200 {
+				#io-channel-cells = <1>;
+				reg = <0x200>;
+				clocks = <&rcc 0 170>;
+				st,injected;
+				status = "disabled";
+			};
+		};
+
 		syscfg: system-config at 40013800 {
 			compatible = "syscon";
 			reg = <0x40013800 0x400>;
@@ -332,6 +388,12 @@
 					slew-rate = <2>;
 				};
 			};
+
+			adc3_in8_pin: adc at 0 {
+				pins {
+					pinmux = <STM32F429_PF10_FUNC_ANALOG>;
+				};
+			};
 		};
 
 		rcc: rcc at 40023810 {
-- 
1.9.1
