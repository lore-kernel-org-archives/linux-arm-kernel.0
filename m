From: vkoul@kernel.org (Vinod Koul)
Date: Fri,  9 Nov 2018 15:14:17 +0530
Subject: [PATCH v5 18/18] arm64: dts: qcom: pms405: Add pon and pwrkey nodes
In-Reply-To: <20181109094417.12109-1-vkoul@kernel.org>
References: <20181109094417.12109-1-vkoul@kernel.org>
Message-ID: <20181109094417.12109-19-vkoul@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PMS405 also features PON block, so add PON and PWRKEY nodes

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/pms405.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index 8e5a8573430e..ad2b62dfc9f6 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -2,6 +2,7 @@
 // Copyright (c) 2018, Linaro Limited
 
 #include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/input/linux-event-codes.h>
 
 &spmi_bus {
 	pms405_0: pms405 at 0 {
@@ -29,6 +30,21 @@
 				<0 0xcb 0 IRQ_TYPE_NONE>;
 		};
 
+		pon at 800 {
+			compatible = "qcom,pms405-pon";
+			reg = <0x0800>;
+			mode-bootloader = <0x2>;
+			mode-recovery = <0x1>;
+
+			pwrkey {
+				compatible = "qcom,pm8941-pwrkey";
+				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				linux,code = <KEY_POWER>;
+			};
+		};
+
 		rtc at 6000 {
 			compatible = "qcom,pm8941-rtc";
 			reg = <0x6000>;
-- 
2.14.4
