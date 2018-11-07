From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed,  7 Nov 2018 23:18:43 +0530
Subject: [PATCH v3 3/4] arm64: dts: mediatek: x20: Add pinmux support for UART1
In-Reply-To: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org>
References: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181107174844.5381-4-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinmux support for UART1 on MediatekX20 Development board based
on Mediatek MT6797 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts | 2 ++
 arch/arm64/boot/dts/mediatek/mt6797.dtsi        | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
index 742938a1a548..13939d55b85b 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
@@ -30,4 +30,6 @@
 
 &uart1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins_a>;
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 231230d32d09..a64bb84bdec3 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -141,6 +141,13 @@
 			    "iocfgr", "iocfgt";
 		gpio-controller;
 		#gpio-cells = <2>;
+
+		uart1_pins_a: uart1 {
+			pins1 {
+				pinmux = <MT6797_GPIO232__FUNC_URXD1>,
+					 <MT6797_GPIO233__FUNC_UTXD1>;
+			};
+		};
 	};
 
 	scpsys: scpsys at 10006000 {
-- 
2.17.1
