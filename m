From: ludovic.Barre@st.com (Ludovic Barre)
Date: Mon, 6 Nov 2017 18:03:37 +0100
Subject: [PATCH v3 7/9] ARM: dts: stm32: add exti support for stm32h743
In-Reply-To: <1509987819-29599-1-git-send-email-ludovic.Barre@st.com>
References: <1509987819-29599-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1509987819-29599-8-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds support of external interrupt (exti)
for stm32h743.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 arch/arm/boot/dts/stm32h743.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 58ec227..6b2fb4c 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -193,6 +193,14 @@
 				status = "disabled";
 			};
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
