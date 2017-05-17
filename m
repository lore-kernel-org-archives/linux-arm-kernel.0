From: lionel.debieve@st.com (Lionel Debieve)
Date: Wed, 17 May 2017 17:15:56 +0200
Subject: [PATCH 1/1] ARM: dts: stm32: Add missing reset-cells node in stm32f476
Message-ID: <1495034156-19593-1-git-send-email-lionel.debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rcc node must include reset-cells node.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 arch/arm/boot/dts/stm32f746.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index c2765ce..b5a04f1 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -336,6 +336,7 @@
 		};
 
 		rcc: rcc at 40023800 {
+			#reset-cells = <1>;
 			#clock-cells = <2>;
 			compatible = "st,stm32f746-rcc", "st,stm32-rcc";
 			reg = <0x40023800 0x400>;
-- 
2.7.4
