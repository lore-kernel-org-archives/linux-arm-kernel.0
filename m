From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 20 Nov 2015 12:42:44 +0100
Subject: [PATCH] ARM: mediatek: DT: Move reset controller constants into
 common location
Message-ID: <1448019764-31723-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By popular vote, the DT binding includes for reset controllers are located
in include/dt-bindings/reset/. Move the mediatek reset constants in there,
too, to avoid confusion.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |  2 +-
 .../bindings/arm/mediatek/mediatek,pericfg.txt     |  2 +-
 arch/arm/boot/dts/mt8135.dtsi                      |  2 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  2 +-
 .../dt-bindings/reset-controller/mt8135-resets.h   | 64 ----------------------
 .../dt-bindings/reset-controller/mt8173-resets.h   | 63 ---------------------
 include/dt-bindings/reset/mt8135-resets.h          | 64 ++++++++++++++++++++++
 include/dt-bindings/reset/mt8173-resets.h          | 63 +++++++++++++++++++++
 8 files changed, 131 insertions(+), 131 deletions(-)
 delete mode 100644 include/dt-bindings/reset-controller/mt8135-resets.h
 delete mode 100644 include/dt-bindings/reset-controller/mt8173-resets.h
 create mode 100644 include/dt-bindings/reset/mt8135-resets.h
 create mode 100644 include/dt-bindings/reset/mt8173-resets.h

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
index f6cd3e4..aaf8d14 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
@@ -18,7 +18,7 @@ The available clocks are defined in dt-bindings/clock/mt*-clk.h.
 Also it uses the common reset controller binding from
 Documentation/devicetree/bindings/reset/reset.txt.
 The available reset outputs are defined in
-dt-bindings/reset-controller/mt*-resets.h
+dt-bindings/reset/mt*-resets.h
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
index f25b854..2f6ff86 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
@@ -18,7 +18,7 @@ The available clocks are defined in dt-bindings/clock/mt*-clk.h.
 Also it uses the common reset controller binding from
 Documentation/devicetree/bindings/reset/reset.txt.
 The available reset outputs are defined in
-dt-bindings/reset-controller/mt*-resets.h
+dt-bindings/reset/mt*-resets.h
 
 Example:
 
diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index cb99b02..1d7f92b 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -15,7 +15,7 @@
 #include <dt-bindings/clock/mt8135-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/reset-controller/mt8135-resets.h>
+#include <dt-bindings/reset/mt8135-resets.h>
 #include "skeleton64.dtsi"
 #include "mt8135-pinfunc.h"
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 4dd5f93..fd71a87 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -15,7 +15,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/mt8173-power.h>
-#include <dt-bindings/reset-controller/mt8173-resets.h>
+#include <dt-bindings/reset/mt8173-resets.h>
 #include "mt8173-pinfunc.h"
 
 / {
diff --git a/include/dt-bindings/reset-controller/mt8135-resets.h b/include/dt-bindings/reset-controller/mt8135-resets.h
deleted file mode 100644
index 1fb6295..0000000
--- a/include/dt-bindings/reset-controller/mt8135-resets.h
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- * Copyright (c) 2014 MediaTek Inc.
- * Author: Flora Fu, MediaTek
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8135
-#define _DT_BINDINGS_RESET_CONTROLLER_MT8135
-
-/* INFRACFG resets */
-#define MT8135_INFRA_EMI_REG_RST        0
-#define MT8135_INFRA_DRAMC0_A0_RST      1
-#define MT8135_INFRA_CCIF0_RST          2
-#define MT8135_INFRA_APCIRQ_EINT_RST    3
-#define MT8135_INFRA_APXGPT_RST         4
-#define MT8135_INFRA_SCPSYS_RST         5
-#define MT8135_INFRA_CCIF1_RST          6
-#define MT8135_INFRA_PMIC_WRAP_RST      7
-#define MT8135_INFRA_KP_RST             8
-#define MT8135_INFRA_EMI_RST            32
-#define MT8135_INFRA_DRAMC0_RST         34
-#define MT8135_INFRA_SMI_RST            35
-#define MT8135_INFRA_M4U_RST            36
-
-/*  PERICFG resets */
-#define MT8135_PERI_UART0_SW_RST        0
-#define MT8135_PERI_UART1_SW_RST        1
-#define MT8135_PERI_UART2_SW_RST        2
-#define MT8135_PERI_UART3_SW_RST        3
-#define MT8135_PERI_IRDA_SW_RST         4
-#define MT8135_PERI_PTP_SW_RST          5
-#define MT8135_PERI_AP_HIF_SW_RST       6
-#define MT8135_PERI_GPCU_SW_RST         7
-#define MT8135_PERI_MD_HIF_SW_RST       8
-#define MT8135_PERI_NLI_SW_RST          9
-#define MT8135_PERI_AUXADC_SW_RST       10
-#define MT8135_PERI_DMA_SW_RST          11
-#define MT8135_PERI_NFI_SW_RST          14
-#define MT8135_PERI_PWM_SW_RST          15
-#define MT8135_PERI_THERM_SW_RST        16
-#define MT8135_PERI_MSDC0_SW_RST        17
-#define MT8135_PERI_MSDC1_SW_RST        18
-#define MT8135_PERI_MSDC2_SW_RST        19
-#define MT8135_PERI_MSDC3_SW_RST        20
-#define MT8135_PERI_I2C0_SW_RST         22
-#define MT8135_PERI_I2C1_SW_RST         23
-#define MT8135_PERI_I2C2_SW_RST         24
-#define MT8135_PERI_I2C3_SW_RST         25
-#define MT8135_PERI_I2C4_SW_RST         26
-#define MT8135_PERI_I2C5_SW_RST         27
-#define MT8135_PERI_I2C6_SW_RST         28
-#define MT8135_PERI_USB_SW_RST          29
-#define MT8135_PERI_SPI1_SW_RST         33
-#define MT8135_PERI_PWRAP_BRIDGE_SW_RST 34
-
-#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8135 */
diff --git a/include/dt-bindings/reset-controller/mt8173-resets.h b/include/dt-bindings/reset-controller/mt8173-resets.h
deleted file mode 100644
index 9464b37..0000000
--- a/include/dt-bindings/reset-controller/mt8173-resets.h
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * Copyright (c) 2014 MediaTek Inc.
- * Author: Flora Fu, MediaTek
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8173
-#define _DT_BINDINGS_RESET_CONTROLLER_MT8173
-
-/* INFRACFG resets */
-#define MT8173_INFRA_EMI_REG_RST        0
-#define MT8173_INFRA_DRAMC0_A0_RST      1
-#define MT8173_INFRA_APCIRQ_EINT_RST    3
-#define MT8173_INFRA_APXGPT_RST         4
-#define MT8173_INFRA_SCPSYS_RST         5
-#define MT8173_INFRA_KP_RST             6
-#define MT8173_INFRA_PMIC_WRAP_RST      7
-#define MT8173_INFRA_MPIP_RST           8
-#define MT8173_INFRA_CEC_RST            9
-#define MT8173_INFRA_EMI_RST            32
-#define MT8173_INFRA_DRAMC0_RST         34
-#define MT8173_INFRA_APMIXEDSYS_RST     35
-#define MT8173_INFRA_MIPI_DSI_RST       36
-#define MT8173_INFRA_TRNG_RST           37
-#define MT8173_INFRA_SYSIRQ_RST         38
-#define MT8173_INFRA_MIPI_CSI_RST       39
-#define MT8173_INFRA_GCE_FAXI_RST       40
-#define MT8173_INFRA_MMIOMMURST         47
-
-
-/*  PERICFG resets */
-#define MT8173_PERI_UART0_SW_RST        0
-#define MT8173_PERI_UART1_SW_RST        1
-#define MT8173_PERI_UART2_SW_RST        2
-#define MT8173_PERI_UART3_SW_RST        3
-#define MT8173_PERI_IRRX_SW_RST         4
-#define MT8173_PERI_PWM_SW_RST          8
-#define MT8173_PERI_AUXADC_SW_RST       10
-#define MT8173_PERI_DMA_SW_RST          11
-#define MT8173_PERI_I2C6_SW_RST         13
-#define MT8173_PERI_NFI_SW_RST          14
-#define MT8173_PERI_THERM_SW_RST        16
-#define MT8173_PERI_MSDC2_SW_RST        17
-#define MT8173_PERI_MSDC3_SW_RST        18
-#define MT8173_PERI_MSDC0_SW_RST        19
-#define MT8173_PERI_MSDC1_SW_RST        20
-#define MT8173_PERI_I2C0_SW_RST         22
-#define MT8173_PERI_I2C1_SW_RST         23
-#define MT8173_PERI_I2C2_SW_RST         24
-#define MT8173_PERI_I2C3_SW_RST         25
-#define MT8173_PERI_I2C4_SW_RST         26
-#define MT8173_PERI_HDMI_SW_RST         29
-#define MT8173_PERI_SPI0_SW_RST         33
-
-#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8173 */
diff --git a/include/dt-bindings/reset/mt8135-resets.h b/include/dt-bindings/reset/mt8135-resets.h
new file mode 100644
index 0000000..1fb6295
--- /dev/null
+++ b/include/dt-bindings/reset/mt8135-resets.h
@@ -0,0 +1,64 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Flora Fu, MediaTek
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8135
+#define _DT_BINDINGS_RESET_CONTROLLER_MT8135
+
+/* INFRACFG resets */
+#define MT8135_INFRA_EMI_REG_RST        0
+#define MT8135_INFRA_DRAMC0_A0_RST      1
+#define MT8135_INFRA_CCIF0_RST          2
+#define MT8135_INFRA_APCIRQ_EINT_RST    3
+#define MT8135_INFRA_APXGPT_RST         4
+#define MT8135_INFRA_SCPSYS_RST         5
+#define MT8135_INFRA_CCIF1_RST          6
+#define MT8135_INFRA_PMIC_WRAP_RST      7
+#define MT8135_INFRA_KP_RST             8
+#define MT8135_INFRA_EMI_RST            32
+#define MT8135_INFRA_DRAMC0_RST         34
+#define MT8135_INFRA_SMI_RST            35
+#define MT8135_INFRA_M4U_RST            36
+
+/*  PERICFG resets */
+#define MT8135_PERI_UART0_SW_RST        0
+#define MT8135_PERI_UART1_SW_RST        1
+#define MT8135_PERI_UART2_SW_RST        2
+#define MT8135_PERI_UART3_SW_RST        3
+#define MT8135_PERI_IRDA_SW_RST         4
+#define MT8135_PERI_PTP_SW_RST          5
+#define MT8135_PERI_AP_HIF_SW_RST       6
+#define MT8135_PERI_GPCU_SW_RST         7
+#define MT8135_PERI_MD_HIF_SW_RST       8
+#define MT8135_PERI_NLI_SW_RST          9
+#define MT8135_PERI_AUXADC_SW_RST       10
+#define MT8135_PERI_DMA_SW_RST          11
+#define MT8135_PERI_NFI_SW_RST          14
+#define MT8135_PERI_PWM_SW_RST          15
+#define MT8135_PERI_THERM_SW_RST        16
+#define MT8135_PERI_MSDC0_SW_RST        17
+#define MT8135_PERI_MSDC1_SW_RST        18
+#define MT8135_PERI_MSDC2_SW_RST        19
+#define MT8135_PERI_MSDC3_SW_RST        20
+#define MT8135_PERI_I2C0_SW_RST         22
+#define MT8135_PERI_I2C1_SW_RST         23
+#define MT8135_PERI_I2C2_SW_RST         24
+#define MT8135_PERI_I2C3_SW_RST         25
+#define MT8135_PERI_I2C4_SW_RST         26
+#define MT8135_PERI_I2C5_SW_RST         27
+#define MT8135_PERI_I2C6_SW_RST         28
+#define MT8135_PERI_USB_SW_RST          29
+#define MT8135_PERI_SPI1_SW_RST         33
+#define MT8135_PERI_PWRAP_BRIDGE_SW_RST 34
+
+#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8135 */
diff --git a/include/dt-bindings/reset/mt8173-resets.h b/include/dt-bindings/reset/mt8173-resets.h
new file mode 100644
index 0000000..9464b37
--- /dev/null
+++ b/include/dt-bindings/reset/mt8173-resets.h
@@ -0,0 +1,63 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Flora Fu, MediaTek
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8173
+#define _DT_BINDINGS_RESET_CONTROLLER_MT8173
+
+/* INFRACFG resets */
+#define MT8173_INFRA_EMI_REG_RST        0
+#define MT8173_INFRA_DRAMC0_A0_RST      1
+#define MT8173_INFRA_APCIRQ_EINT_RST    3
+#define MT8173_INFRA_APXGPT_RST         4
+#define MT8173_INFRA_SCPSYS_RST         5
+#define MT8173_INFRA_KP_RST             6
+#define MT8173_INFRA_PMIC_WRAP_RST      7
+#define MT8173_INFRA_MPIP_RST           8
+#define MT8173_INFRA_CEC_RST            9
+#define MT8173_INFRA_EMI_RST            32
+#define MT8173_INFRA_DRAMC0_RST         34
+#define MT8173_INFRA_APMIXEDSYS_RST     35
+#define MT8173_INFRA_MIPI_DSI_RST       36
+#define MT8173_INFRA_TRNG_RST           37
+#define MT8173_INFRA_SYSIRQ_RST         38
+#define MT8173_INFRA_MIPI_CSI_RST       39
+#define MT8173_INFRA_GCE_FAXI_RST       40
+#define MT8173_INFRA_MMIOMMURST         47
+
+
+/*  PERICFG resets */
+#define MT8173_PERI_UART0_SW_RST        0
+#define MT8173_PERI_UART1_SW_RST        1
+#define MT8173_PERI_UART2_SW_RST        2
+#define MT8173_PERI_UART3_SW_RST        3
+#define MT8173_PERI_IRRX_SW_RST         4
+#define MT8173_PERI_PWM_SW_RST          8
+#define MT8173_PERI_AUXADC_SW_RST       10
+#define MT8173_PERI_DMA_SW_RST          11
+#define MT8173_PERI_I2C6_SW_RST         13
+#define MT8173_PERI_NFI_SW_RST          14
+#define MT8173_PERI_THERM_SW_RST        16
+#define MT8173_PERI_MSDC2_SW_RST        17
+#define MT8173_PERI_MSDC3_SW_RST        18
+#define MT8173_PERI_MSDC0_SW_RST        19
+#define MT8173_PERI_MSDC1_SW_RST        20
+#define MT8173_PERI_I2C0_SW_RST         22
+#define MT8173_PERI_I2C1_SW_RST         23
+#define MT8173_PERI_I2C2_SW_RST         24
+#define MT8173_PERI_I2C3_SW_RST         25
+#define MT8173_PERI_I2C4_SW_RST         26
+#define MT8173_PERI_HDMI_SW_RST         29
+#define MT8173_PERI_SPI0_SW_RST         33
+
+#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8173 */
-- 
2.6.2
