From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 15 Feb 2018 17:03:23 +0100
Subject: [PATCH 2/3] ARM: dts: stm32: add USB OTG FS support for STM32H743 SoC
In-Reply-To: <1518710604-21632-1-git-send-email-amelie.delaunay@st.com>
References: <1518710604-21632-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1518710604-21632-3-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for USB OTG FS on STM32H743 SoC.
USB OTG FS controller is the same than the one used on STM32F4 SoCs.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32h743.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 65d4509..eb4ba90 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -229,6 +229,15 @@
 			status = "disabled";
 		};
 
+		usbotg_fs: usb at 40080000 {
+			compatible = "st,stm32f4x9-fsotg";
+			reg = <0x40080000 0x40000>;
+			interrupts = <101>;
+			clocks = <&rcc USB2OTG_CK>;
+			clock-names = "otg";
+			status = "disabled";
+		};
+
 		mdma1: dma at 52000000 {
 			compatible = "st,stm32h7-mdma";
 			reg = <0x52000000 0x1000>;
-- 
2.7.4
