From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed, 21 Nov 2018 09:06:47 +0530
Subject: [PATCH v2 10/15] arm: dts: rda8810pl: Add timer support
In-Reply-To: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181121033652.12247-11-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add timer support for RDA Micro RDA8810PL SoC.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/rda8810pl.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
index ab85ee06d84f..17ae93410769 100644
--- a/arch/arm/boot/dts/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/rda8810pl.dtsi
@@ -6,6 +6,8 @@
  * Copyright (c) 2018 Manivannan Sadhasivam
  */
 
+#include <dt-bindings/interrupt-controller/irq.h>
+
 / {
 	compatible = "rda,8810pl";
 	interrupt-parent = <&intc>;
@@ -50,6 +52,14 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x20900000 0x100000>;
+	
+		timer at 10000 {
+			compatible = "rda,8810pl-timer";
+			reg = <0x10000 0x1000>;
+			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
+				     <17 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hwtimer", "ostimer";
+		};
 	};
 
 	apb at 20a00000 {
-- 
2.17.1
