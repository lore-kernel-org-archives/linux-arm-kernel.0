From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Thu, 1 Mar 2018 11:53:43 +0100
Subject: [PATCH v2 6/6] ARM: dts: stm32: Fix sdio2 rcc hard coded value
In-Reply-To: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
References: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1519901623-23216-7-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Replace sdio2 rcc hard coded clock value by its macro.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stm32f746.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index 07c29658696c..2c5704f96801 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -432,7 +432,7 @@
 			compatible = "arm,pl180", "arm,primecell";
 			arm,primecell-periphid = <0x00880180>;
 			reg = <0x40011c00 0x400>;
-			clocks = <&rcc 0 167>;
+			clocks = <&rcc 0 STM32F7_APB2_CLOCK(SDMMC2)>;
 			clock-names = "apb_pclk";
 			interrupts = <103>;
 			max-frequency = <48000000>;
-- 
1.9.1
