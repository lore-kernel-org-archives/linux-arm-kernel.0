From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 15 Feb 2018 17:03:22 +0100
Subject: [PATCH 1/3] ARM: dts: stm32: add USB OTG HS support for STM32H743 SoC
In-Reply-To: <1518710604-21632-1-git-send-email-amelie.delaunay@st.com>
References: <1518710604-21632-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1518710604-21632-2-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for USB OTG HS on STM32H743 SoC.
USB OTG HS controller is the same than the one used on STM32F7 SoCs.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32h743.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 38d7cb8..65d4509 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -217,6 +217,18 @@
 			};
 		};
 
+		usbotg_hs: usb at 40040000 {
+			compatible = "st,stm32f7xx-hsotg";
+			reg = <0x40040000 0x40000>;
+			interrupts = <77>;
+			clocks = <&rcc USB1OTG_CK>;
+			clock-names = "otg";
+			g-rx-fifo-size = <256>;
+			g-np-tx-fifo-size = <32>;
+			g-tx-fifo-size = <128 128 64 64 64 64 32 32>;
+			status = "disabled";
+		};
+
 		mdma1: dma at 52000000 {
 			compatible = "st,stm32h7-mdma";
 			reg = <0x52000000 0x1000>;
-- 
2.7.4
