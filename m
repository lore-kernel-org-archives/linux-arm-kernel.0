From: lionel.debieve@st.com (Lionel Debieve)
Date: Mon, 23 Apr 2018 17:19:47 +0200
Subject: [PATCH 4/4] ARM: dts: stm32: Add CRC support on stm32mp157c
In-Reply-To: <20180423151947.2526-1-lionel.debieve@st.com>
References: <20180423151947.2526-1-lionel.debieve@st.com>
Message-ID: <20180423151947.2526-5-lionel.debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add CRC instance of the stm32mp157c SoC

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 5ce7d28f8a1f..2962decacd87 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -185,6 +185,13 @@
 			status = "disabled";
 		};
 
+		crc1: crc at 58009000 {
+			compatible = "st,stm32f7-crc";
+			reg = <0x58009000 0x400>;
+			clocks = <&rcc CRC1>;
+			status = "disabled";
+		};
+
 		usart1: serial at 5c000000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x5c000000 0x400>;
-- 
2.15.1
