From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Thu, 15 Sep 2016 18:42:43 +0200
Subject: [PATCH 11/11] ARM: DT: STM32: add dma for usart1 on F429
In-Reply-To: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
References: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1473957763-30629-12-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 35df462..227376b 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -161,6 +161,9 @@
 			interrupts = <37>;
 			clocks = <&rcc 0 164>;
 			status = "disabled";
+			dmas = <&dma2 2 4 0x414 0x0>,
+			       <&dma2 7 4 0x414 0x0>;
+			dma-names = "rx", "tx";
 		};
 
 		usart6: serial at 40011400 {
-- 
1.9.1
