From: yannick.fertre@st.com (Yannick Fertre)
Date: Mon, 16 Jan 2017 14:29:02 +0100
Subject: [PATCH v1 5/7] ARM: dts: stm32f429: Add ltdc support
In-Reply-To: <1484573344-11609-1-git-send-email-yannick.fertre@st.com>
References: <1484573344-11609-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1484573344-11609-6-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add LTDC (Lcd-tft Display Controller) support.

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 336ee4f..fc43415 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -185,7 +185,7 @@
 			interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <42>, <62>, <76>;
 		};
 
-		pin-controller {
+		pinctrl: pin-controller {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "st,stm32f429-pinctrl";
@@ -404,6 +404,29 @@
 			interrupts = <80>;
 			clocks = <&rcc 0 38>;
 		};
+
+		st-display-subsystem {
+			compatible = "st,display-subsystem";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			dma-ranges;
+
+			ltdc_host: stm32-ltdc at 40016800 {
+				compatible = "st,ltdc";
+				reg = <0x40016800 0x200>;
+				interrupts = <88>, <89>;
+				resets = <&rcc 314>;
+				clocks = <&rcc 1 8>;
+				clock-names = "clk-lcd";
+				status = "disabled";
+
+				port {
+					ltdc_out_rgb: endpoint {
+					};
+				};
+			};
+		};
 	};
 };
 
-- 
1.9.1
