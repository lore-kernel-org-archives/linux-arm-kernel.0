From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Thu, 18 Jan 2018 15:34:22 +0100
Subject: [PATCH v3 06/14] ARM: dts: stm32: Add SDIO controller for stm32f746
In-Reply-To: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
References: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1516286070-24927-7-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

stm32f746 embeds ARM_PL180 sdio IP, adds SDIO controller
nodes to allow MMC support.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v3: _ none

v2: _ none

 arch/arm/boot/dts/stm32f746.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index 5f66d15..7f55d00 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -429,6 +429,28 @@
 			status = "disabled";
 		};
 
+		sdio2: sdio2 at 40011c00 {
+			compatible = "arm,pl180", "arm,primecell";
+			arm,primecell-periphid = <0x00880180>;
+			reg = <0x40011c00 0x400>;
+			clocks = <&rcc 0 167>;
+			clock-names = "apb_pclk";
+			interrupts = <103>;
+			max-frequency = <48000000>;
+			status = "disabled";
+		};
+
+		sdio1: sdio1 at 40012c00 {
+			compatible = "arm,pl180", "arm,primecell";
+			arm,primecell-periphid = <0x00880180>;
+			reg = <0x40012c00 0x400>;
+			clocks = <&rcc 0 171>;
+			clock-names = "apb_pclk";
+			interrupts = <49>;
+			max-frequency = <48000000>;
+			status = "disabled";
+		};
+
 		syscfg: system-config at 40013800 {
 			compatible = "syscon";
 			reg = <0x40013800 0x400>;
-- 
1.9.1
