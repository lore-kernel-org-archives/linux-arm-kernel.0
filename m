From: ludovic.Barre@st.com (Ludovic Barre)
Date: Thu, 26 Apr 2018 18:18:33 +0200
Subject: [PATCH 10/11] ARM: dts: stm32: add exti support for stm32mp157c
In-Reply-To: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
References: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1524759514-12392-11-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds external interrupt (exti) support
on stm32mp157c SoC.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index bfcf84b..e6fcf8f 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -167,6 +167,13 @@
 			#reset-cells = <1>;
 		};
 
+		exti: interrupt-controller at 5000d000 {
+			compatible = "st,stm32mp1-exti", "syscon";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x5000d000 0x400>;
+		};
+
 		usart1: serial at 5c000000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x5c000000 0x400>;
-- 
2.7.4
