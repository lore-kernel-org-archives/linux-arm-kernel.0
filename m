From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Sat, 21 Jul 2018 15:08:26 +0200
Subject: [PATCH v5 3/4] ARM: dts: imx7s: add i.MX7 messaging unit support
In-Reply-To: <20180721130827.944-1-o.rempel@pengutronix.de>
References: <20180721130827.944-1-o.rempel@pengutronix.de>
Message-ID: <20180721130827.944-4-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Messaging Unit (MU) for i.MX7 in the processor's dtsi.
The respective driver is added in the next commit.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx7s.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index ce85b3ca1a55..038e0eafc549 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1001,6 +1001,25 @@
 				status = "disabled";
 			};
 
+			mu0a: mailbox at 30aa0000 {
+				compatible = "fsl,imx7s-mu";
+				reg = <0x30aa0000 0x10000>;
+				interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_MU_ROOT_CLK>;
+				#mbox-cells = <1>;
+				status = "disabled";
+			};
+
+			mu0b: mailbox at 30ab0000 {
+				compatible = "fsl,imx7s-mu";
+				reg = <0x30ab0000 0x10000>;
+				interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_MU_ROOT_CLK>;
+				#mbox-cells = <1>;
+				fsl,mu-side-b;
+				status = "disabled";
+			};
+
 			usbotg1: usb at 30b10000 {
 				compatible = "fsl,imx7d-usb", "fsl,imx27-usb";
 				reg = <0x30b10000 0x200>;
-- 
2.18.0
