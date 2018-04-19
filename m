From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 19 Apr 2018 16:59:54 +0200
Subject: [PATCH 1/3] ARM: dts: stm32: add USBPHYC support to stm32mp157c
In-Reply-To: <1524149996-27809-1-git-send-email-amelie.delaunay@st.com>
References: <1524149996-27809-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1524149996-27809-2-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for USBPHYC (USB PHY Controller) to STM32MP157C SoC.
It manages two usb2 ports.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index bc3eddc..c64cac1 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -167,6 +167,26 @@
 			#reset-cells = <1>;
 		};
 
+		usbphyc: usbphyc at 5a006000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32mp1-usbphyc";
+			reg = <0x5a006000 0x1000>;
+			clocks = <&rcc USBPHY_K>;
+			resets = <&rcc USBPHY_R>;
+			status = "disabled";
+
+			usbphyc_port0: usb-phy at 0 {
+				#phy-cells = <0>;
+				reg = <0>;
+			};
+
+			usbphyc_port1: usb-phy at 1 {
+				#phy-cells = <1>;
+				reg = <1>;
+			};
+		};
+
 		usart1: serial at 5c000000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x5c000000 0x400>;
-- 
2.7.4
