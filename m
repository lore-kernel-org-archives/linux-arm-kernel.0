From: ludovic.Barre@st.com (Ludovic Barre)
Date: Wed, 28 Feb 2018 16:47:22 +0100
Subject: [PATCH V2 3/5] ARM: dts: stm32: add sdmmc support for stm32h743
In-Reply-To: <1519832844-28068-1-git-send-email-ludovic.Barre@st.com>
References: <1519832844-28068-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1519832844-28068-4-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds sdmmc support for stm32h743.
2?SD/SDIO/MMC interfaces (up to 125 MHz)

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 arch/arm/boot/dts/stm32h743.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index bbfcbac..5e85538 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -217,6 +217,19 @@
 			};
 		};
 
+		sdmmc2: sdmmc at 48022400 {
+			compatible = "st,stm32h7-sdmmc";
+			reg = <0x48022400 0x400>;
+			reg-names = "sdmmc";
+			interrupts = <124>;
+			clocks = <&rcc SDMMC2_CK>;
+			resets = <&rcc STM32H7_AHB2_RESET(SDMMC2)>;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
+			max-frequency = <125000000>;
+			status = "disabled";
+		};
+
 		mdma1: dma at 52000000 {
 			compatible = "st,stm32h7-mdma";
 			reg = <0x52000000 0x1000>;
@@ -227,6 +240,19 @@
 			dma-requests = <32>;
 		};
 
+		sdmmc1: sdmmc at 52007000 {
+			compatible = "st,stm32h7-sdmmc";
+			reg = <0x52007000 0x1000>;
+			reg-names = "sdmmc";
+			interrupts = <49>;
+			clocks = <&rcc SDMMC1_CK>;
+			resets = <&rcc STM32H7_AHB3_RESET(SDMMC1)>;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
+			max-frequency = <125000000>;
+			status = "disabled";
+		};
+
 		lptimer2: timer at 58002400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4
