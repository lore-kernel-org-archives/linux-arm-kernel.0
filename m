From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sat,  2 Jun 2018 22:24:14 +0530
Subject: [PATCH 2/3] arm64: dts: actions: Add interrupt properties to pinctrl
 node for S900
In-Reply-To: <20180602165415.30956-1-manivannan.sadhasivam@linaro.org>
References: <20180602165415.30956-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180602165415.30956-3-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add interrupt properties to pinctrl node for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index aa3a49b0d646..7ae8b931f000 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -181,6 +181,14 @@
 			gpio-controller;
 			gpio-ranges = <&pinctrl 0 0 146>;
 			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		timer: timer at e0228000 {
-- 
2.17.0
