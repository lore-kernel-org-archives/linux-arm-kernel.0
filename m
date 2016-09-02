From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Fri, 2 Sep 2016 17:33:13 +0200
Subject: [PATCH v3 4/9] ARM: dts: Add EXTI controller node to stm32f429
In-Reply-To: <1472830398-13275-1-git-send-email-alexandre.torgue@st.com>
References: <1472830398-13275-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1472830398-13275-5-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 35df462..1a189d4 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -176,6 +176,14 @@
 			reg = <0x40013800 0x400>;
 		};
 
+		exti: interrupt-controller at 40013c00 {
+			compatible = "st,stm32-exti";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x40013C00 0x400>;
+			interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <42>, <62>, <76>;
+		};
+
 		pin-controller {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
1.9.1
