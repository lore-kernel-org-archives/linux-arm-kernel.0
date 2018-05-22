From: Anson.Huang@nxp.com (Anson Huang)
Date: Tue, 22 May 2018 11:26:00 +0800
Subject: [PATCH 2/2] ARM: dts: imx6ul: add GPIO clocks
In-Reply-To: <1526959560-6014-1-git-send-email-Anson.Huang@nxp.com>
References: <1526959560-6014-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1526959560-6014-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6UL has GPIO clock gates in CCM CCGR, add
clock property for GPIO driver to make sure all
GPIO banks work as expected.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 1241972..405e068 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -437,6 +437,7 @@
 				reg = <0x0209c000 0x4000>;
 				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_GPIO1>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -450,6 +451,7 @@
 				reg = <0x020a0000 0x4000>;
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_GPIO2>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -462,6 +464,7 @@
 				reg = <0x020a4000 0x4000>;
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_GPIO3>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -474,6 +477,7 @@
 				reg = <0x020a8000 0x4000>;
 				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_GPIO4>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -486,6 +490,7 @@
 				reg = <0x020ac000 0x4000>;
 				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_GPIO5>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-- 
2.7.4
