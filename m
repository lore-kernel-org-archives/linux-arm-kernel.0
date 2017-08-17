From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 17 Aug 2017 11:33:05 +0200
Subject: [PATCH 6/7] ARM: dts: stm32: Add USB FS support for STM32F746 MCU
In-Reply-To: <1502962386-6683-1-git-send-email-amelie.delaunay@st.com>
References: <1502962386-6683-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1502962386-6683-7-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the USB pins and nodes for USB FS core on STM32F746 SoC.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32f746.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index fcfe5a6..a9476ea 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -419,6 +419,28 @@
 					slew-rate = <2>;
 				};
 			};
+
+			usbotg_fs_pins_a: usbotg_fs at 0 {
+				pins {
+					pinmux = <STM32F746_PA10_FUNC_OTG_FS_ID>,
+						 <STM32F746_PA11_FUNC_OTG_FS_DM>,
+						 <STM32F746_PA12_FUNC_OTG_FS_DP>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+			};
+
+			usbotg_fs_pins_b: usbotg_fs at 1 {
+				pins {
+					pinmux = <STM32F746_PB12_FUNC_OTG_HS_ID>,
+						 <STM32F746_PB14_FUNC_OTG_HS_DM>,
+						 <STM32F746_PB15_FUNC_OTG_HS_DP>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+			};
 		};
 
 		crc: crc at 40023000 {
@@ -480,6 +502,15 @@
 			clock-names = "otg";
 			status = "disabled";
 		};
+
+		usbotg_fs: usb at 50000000 {
+			compatible = "st,stm32f4x9-fsotg";
+			reg = <0x50000000 0x40000>;
+			interrupts = <67>;
+			clocks = <&rcc 0 STM32F7_AHB2_CLOCK(OTGFS)>;
+			clock-names = "otg";
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.7.4
