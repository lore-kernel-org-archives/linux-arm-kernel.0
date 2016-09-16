From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 16 Sep 2016 18:41:20 +0100
Subject: [PATCH 1/2] pinctrl: pm8994: add pad voltage regulator defines
In-Reply-To: <1474047681-6821-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1474047681-6821-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1474047681-6821-2-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds defines for internal voltage regulators used
to switch voltage levels on gpio/mpp pads.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/dt-bindings/pinctrl/qcom,pmic-gpio.h | 4 ++++
 include/dt-bindings/pinctrl/qcom,pmic-mpp.h  | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/include/dt-bindings/pinctrl/qcom,pmic-gpio.h b/include/dt-bindings/pinctrl/qcom,pmic-gpio.h
index aafa76c..d33f17c 100644
--- a/include/dt-bindings/pinctrl/qcom,pmic-gpio.h
+++ b/include/dt-bindings/pinctrl/qcom,pmic-gpio.h
@@ -89,6 +89,10 @@
 #define PMA8084_GPIO_S4			2
 #define PMA8084_GPIO_L6			3
 
+#define PM8994_GPIO_VPH			0
+#define PM8994_GPIO_S4			2
+#define PM8994_GPIO_L12			3
+
 /* To be used with "function" */
 #define PMIC_GPIO_FUNC_NORMAL		"normal"
 #define PMIC_GPIO_FUNC_PAIRED		"paired"
diff --git a/include/dt-bindings/pinctrl/qcom,pmic-mpp.h b/include/dt-bindings/pinctrl/qcom,pmic-mpp.h
index a15c170..2e360d8f 100644
--- a/include/dt-bindings/pinctrl/qcom,pmic-mpp.h
+++ b/include/dt-bindings/pinctrl/qcom,pmic-mpp.h
@@ -65,6 +65,12 @@
 #define PMA8084_MPP_S4			2
 #define PMA8084_MPP_L6			3
 
+#define PM8994_MPP_VPH			0
+/* Only supported for MPP_05-MPP_08 */
+#define PM8994_MPP_L19			1
+#define PM8994_MPP_S4			2
+#define PM8994_MPP_L12			3
+
 /*
  * Analog Input - Set the source for analog input.
  * To be used with "qcom,amux-route" property
-- 
2.7.4
