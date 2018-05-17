From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 17 May 2018 17:47:31 +0200
Subject: [PATCH 1/2] ARM: dts: stm32: add USB OTG HS support for stm32mp157c
 SoC
In-Reply-To: <1526572052-17155-1-git-send-email-amelie.delaunay@st.com>
References: <1526572052-17155-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1526572052-17155-2-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for USB OTG HS on STM32MP157C SoC.
USB OTG HS controller is based on DWC2 controller.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index b66f673..6c3815f 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -600,6 +600,21 @@
 			clocks = <&rcc DMAMUX>;
 		};
 
+		usbotg_hs: usb-otg at 49000000 {
+			compatible = "snps,dwc2";
+			reg = <0x49000000 0x10000>;
+			clocks = <&rcc USBO_K>;
+			clock-names = "otg";
+			resets = <&rcc USBO_R>;
+			reset-names = "dwc2";
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			g-rx-fifo-size = <256>;
+			g-np-tx-fifo-size = <32>;
+			g-tx-fifo-size = <128 128 64 64 64 64 32 32>;
+			dr_mode = "otg";
+			status = "disabled";
+		};
+
 		rcc: rcc at 50000000 {
 			compatible = "st,stm32mp1-rcc", "syscon";
 			reg = <0x50000000 0x1000>;
-- 
2.7.4
