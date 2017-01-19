From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 19 Jan 2017 14:45:17 +0100
Subject: [PATCH 1/3] ARM: dts: stm32: set HSE_RTC clock frequency to 1 MHz on
 stm32f746
In-Reply-To: <1484833519-9298-1-git-send-email-amelie.delaunay@st.com>
References: <1484833519-9298-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1484833519-9298-2-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set HSE_RTC clock frequency to 1 MHz, as the clock supplied to
the RTC must be 1 MHz.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32f746.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index 5bbee56..b42f23d 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -343,6 +343,8 @@
 			reg = <0x40023800 0x400>;
 			clocks = <&clk_hse>, <&clk_i2s_ckin>;
 			st,syscfg = <&pwrcfg>;
+			assigned-clocks = <&rcc 1 CLK_HSE_RTC>;
+			assigned-clock-rates = <1000000>;
 		};
 
 		dma1: dma-controller at 40026000 {
-- 
1.9.1
