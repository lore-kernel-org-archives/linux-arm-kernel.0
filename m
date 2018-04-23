From: lionel.debieve@st.com (Lionel Debieve)
Date: Mon, 23 Apr 2018 17:19:46 +0200
Subject: [PATCH 3/4] ARM: dts: stm32: Add CRYP support on stm32mp157c
In-Reply-To: <20180423151947.2526-1-lionel.debieve@st.com>
References: <20180423151947.2526-1-lionel.debieve@st.com>
Message-ID: <20180423151947.2526-4-lionel.debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add CRYP instance of the stm32mp157c SoC

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index bf00885971b3..5ce7d28f8a1f 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -168,6 +168,15 @@
 			#reset-cells = <1>;
 		};
 
+		cryp1: cryp at 54001000 {
+			compatible = "st,stm32mp1-cryp";
+			reg = <0x54001000 0x400>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc CRYP1>;
+			resets = <&rcc CRYP1_R>;
+			status = "disabled";
+		};
+
 		rng1: rng at 54003000 {
 			compatible = "st,stm32-rng";
 			reg = <0x54003000 0x400>;
-- 
2.15.1
