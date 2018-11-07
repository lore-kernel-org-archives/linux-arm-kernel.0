From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed,  7 Nov 2018 23:18:42 +0530
Subject: [PATCH v3 2/4] arm64: dts: mediatek: mt6797: Add pinctrl support
In-Reply-To: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org>
References: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181107174844.5381-3-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl support for Mediatek MT6797 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt6797.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 4beaa71107d7..231230d32d09 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/mt6797-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/mt6797-pinfunc.h>
 
 / {
 	compatible = "mediatek,mt6797";
@@ -129,6 +130,19 @@
 		#clock-cells = <1>;
 	};
 
+	pio: pinctrl at 10005000 {
+		compatible = "mediatek,mt6797-pinctrl";
+		reg = <0 0x10005000 0 0x1000>,
+		      <0 0x10002000 0 0x400>,
+		      <0 0x10002400 0 0x400>,
+		      <0 0x10002800 0 0x400>,
+		      <0 0x10002C00 0 0x400>;
+		reg-names = "gpio", "iocfgl", "iocfgb",
+			    "iocfgr", "iocfgt";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	scpsys: scpsys at 10006000 {
 		compatible = "mediatek,mt6797-scpsys";
 		#power-domain-cells = <1>;
-- 
2.17.1
