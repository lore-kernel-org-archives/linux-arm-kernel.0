From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 15 Feb 2018 16:54:38 +0100
Subject: [PATCH 1/3] ARM: dts: stm32: add gadget fifo sizes to usbotg_hs on
 stm32f746
In-Reply-To: <1518710080-18164-1-git-send-email-amelie.delaunay@st.com>
References: <1518710080-18164-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1518710080-18164-2-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB OTG HS on STM32F746 can also be used as Peripheral (gadget), so
this patch adds DWC2 gadget mode fifo sizes bindings.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32f746.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index 5f66d15..b75af8c 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -771,6 +771,9 @@
 			interrupts = <77>;
 			clocks = <&rcc 0 STM32F7_AHB1_CLOCK(OTGHS)>;
 			clock-names = "otg";
+			g-rx-fifo-size = <256>;
+			g-np-tx-fifo-size = <32>;
+			g-tx-fifo-size = <128 128 64 64 64 64 32 32>;
 			status = "disabled";
 		};
 
-- 
2.7.4
