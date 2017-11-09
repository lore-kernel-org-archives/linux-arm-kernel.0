From: j-keerthy@ti.com (Keerthy)
Date: Thu, 9 Nov 2017 17:12:58 +0530
Subject: [PATCH] ARM: dts: keystone-k2l: Add the second gpio bank node
Message-ID: <1510227778-20491-1-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of k2l there are 2 more banks with 16 pins each.
Adding the node as the da-vinci driver now supports multiple
banks.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

This is based on linux-next branch. Boot tested on keystone-k2l-evm.

 arch/arm/boot/dts/keystone-k2l.dtsi | 44 +++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2l.dtsi b/arch/arm/boot/dts/keystone-k2l.dtsi
index 4370e65..cc77113 100644
--- a/arch/arm/boot/dts/keystone-k2l.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l.dtsi
@@ -63,6 +63,50 @@
 			interrupts = <GIC_SPI 435 IRQ_TYPE_EDGE_RISING>;
 		};
 
+		gpio1: gpio at 2348000 {
+			compatible = "ti,keystone-gpio";
+			reg = <0x02348000 0x100>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* HW Interrupts mapped to GPIO pins */
+			interrupts = <GIC_SPI 152 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 153 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 154 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 155 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 156 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 157 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 158 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 159 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 160 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 161 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 163 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 164 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 165 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 166 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 167 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 168 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 169 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 170 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 171 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 172 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 173 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 174 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 175 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 176 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 401 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 402 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 403 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 404 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 405 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 406 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 407 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&clkgpio>;
+			clock-names = "gpio";
+			ti,ngpio = <32>;
+			ti,davinci-gpio-unbanked = <32>;
+		};
+
 		k2l_pmx: pinmux at 2620690 {
 			compatible = "pinctrl-single";
 			reg = <0x02620690 0xc>;
-- 
1.9.1
