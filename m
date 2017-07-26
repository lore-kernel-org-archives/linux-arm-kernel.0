From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Wed, 26 Jul 2017 11:48:21 +0200
Subject: [PATCH v3 3/4] ARM: dts: stm32: Add MDMA support for STM32H743 SoC
In-Reply-To: <1501062502-18778-1-git-send-email-pierre-yves.mordret@st.com>
References: <1501062502-18778-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1501062502-18778-4-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds MDMA support for STM32H743 SoC.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
 Version history:
    v3:
        * None
    v2:
        * Add MDMA support in DT for H7
---
---
 arch/arm/boot/dts/stm32h743.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 36a99db..af44eae 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -82,6 +82,16 @@
 			interrupts = <50>;
 			clocks = <&timer_clk>;
 		};
+
+		mdma1: dma at 52000000 {
+			compatible = "st,stm32h7-mdma";
+			reg = <0x52000000 0x1000>;
+			interrupts = <122>;
+			clocks = <&timer_clk>;
+			#dma-cells = <5>;
+			dma-channels = <16>;
+			dma-requests = <32>;
+		};
 	};
 };
 
-- 
2.7.4
