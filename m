From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 19 May 2016 00:00:20 -0500
Subject: [PATCH 5/5] ARM: dts: qcom: pma8084: Add pwrkey entry
In-Reply-To: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1463634020-17252-6-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the power key device tree node.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm/boot/dts/qcom-pma8084.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pma8084.dtsi b/arch/arm/boot/dts/qcom-pma8084.dtsi
index ea7fce3..82d2580 100644
--- a/arch/arm/boot/dts/qcom-pma8084.dtsi
+++ b/arch/arm/boot/dts/qcom-pma8084.dtsi
@@ -18,6 +18,14 @@
 			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
 		};
 
+		pwrkey at 800 {
+			compatible = "qcom,pm8941-pwrkey";
+			reg = <0x800>;
+			interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
+			debounce = <15625>;
+			bias-pull-up;
+		};
+
 		pma8084_gpios: gpios at c000 {
 			compatible = "qcom,pma8084-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
1.9.1
