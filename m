From: lionel.debieve@st.com (Lionel Debieve)
Date: Mon, 14 May 2018 12:00:34 +0200
Subject: [PATCH 1/1] ARM: dts: stm32: Add HASH support on stm32mp157c
Message-ID: <20180514100034.10282-1-lionel.debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add HASH instance of the stm32mp157c SoC

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index b66f673b5038..cb39fb6d9960 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -702,6 +702,18 @@
 			status = "disabled";
 		};
 
+		hash1: hash at 54002000 {
+			compatible = "st,stm32f756-hash";
+			reg = <0x54002000 0x400>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc HASH1>;
+			resets = <&rcc HASH1_R>;
+			dmas = <&mdma1 31 0x10 0x1000A02 0x0 0x0 0x0>;
+			dma-names = "in";
+			dma-maxburst = <2>;
+			status = "disabled";
+		};
+
 		rng1: rng at 54003000 {
 			compatible = "st,stm32-rng";
 			reg = <0x54003000 0x400>;
-- 
2.15.1
