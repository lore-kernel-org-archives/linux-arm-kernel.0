From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 22 Jun 2018 14:32:34 +0800
Subject: [PATCH 2/2] ARM: dts: imx6sll: add gpio clocks
In-Reply-To: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
References: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1529649154-5724-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SLL has GPIO clock gates in CCM CCGR, add
clock property for GPIO driver to make sure all
GPIO banks work as expected.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index c9b0ccc..116f561 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -375,6 +375,7 @@
 				reg = <0x0209c000 0x4000>;
 				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SLL_CLK_GPIO1>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -386,6 +387,7 @@
 				reg = <0x020a0000 0x4000>;
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SLL_CLK_GPIO2>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -397,6 +399,7 @@
 				reg = <0x020a4000 0x4000>;
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SLL_CLK_GPIO3>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -408,6 +411,7 @@
 				reg = <0x020a8000 0x4000>;
 				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SLL_CLK_GPIO4>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -419,6 +423,7 @@
 				reg = <0x020ac000 0x4000>;
 				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SLL_CLK_GPIO5>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -430,6 +435,7 @@
 				reg = <0x020b0000 0x4000>;
 				interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SLL_CLK_GPIO6>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-- 
2.7.4
