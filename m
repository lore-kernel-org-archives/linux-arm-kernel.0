From: ludovic.Barre@st.com (Ludovic Barre)
Date: Fri, 7 Jul 2017 09:26:30 +0200
Subject: [PATCH 7/8] ARM: dts: stm32: add exti support for stm32h743
In-Reply-To: <1499412391-25480-1-git-send-email-ludovic.Barre@st.com>
References: <1499412391-25480-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1499412391-25480-8-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

this patch add support of external interrupt (exti)
for stm32h743

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 arch/arm/boot/dts/stm32h743.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 4685629..730cbd8 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -74,6 +74,14 @@
 			interrupts = <50>;
 			clocks = <&timer_clk>;
 		};
+
+		exti: interrupt-controller at 58000000 {
+			compatible = "st,stm32h7-exti";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x58000000 0x400>;
+			interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <62>, <76>;
+		};
 	};
 };
 
-- 
2.7.4
