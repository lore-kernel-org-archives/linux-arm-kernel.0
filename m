From: yannick.fertre@st.com (Yannick Fertre)
Date: Wed, 22 Mar 2017 15:12:52 +0100
Subject: [PATCH v2 3/5] ARM: dts: stm32: Add watchdog support for STM32F429 SoC
In-Reply-To: <1490191974-29722-1-git-send-email-yannick.fertre@st.com>
References: <1490191974-29722-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1490191974-29722-4-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add watchdog into DT for stm32f429 family.

Signed-off-by: Yannick FERTRE <yannick.fertre@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index ee0da97..148273b 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -65,7 +65,7 @@
 			clock-frequency = <32768>;
 		};
 
-		clk-lsi {
+		clk_lsi: clk-lsi {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32000>;
@@ -812,6 +812,13 @@
 			clocks = <&rcc 0 STM32F4_AHB2_CLOCK(RNG)>;
 
 		};
+
+		iwdg: iwdg at 40003000 {
+			compatible = "st,stm32-iwdg";
+			reg = <0x40003000 0x400>;
+			clocks = <&clk_lsi>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.9.1
