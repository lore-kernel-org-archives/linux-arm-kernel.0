From: dmurphy@ti.com (Dan Murphy)
Date: Tue, 29 Apr 2014 15:19:50 -0500
Subject: [RFC 11/11] ARM: dts: omap5: Add prm_resets node
In-Reply-To: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
References: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
Message-ID: <1398802790-29287-12-git-send-email-dmurphy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the prm_resets node to the prm parent node.
Add the dt-bindings header to the DT file

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi                |    6 ++++++
 include/dt-bindings/reset/ti,omap5-resets.h |   22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 include/dt-bindings/reset/ti,omap5-resets.h

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index f8c9855..82eebe7 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/omap.h>
+#include <dt-bindings/reset/ti,omap5-resets.h>
 
 #include "skeleton.dtsi"
 
@@ -134,6 +135,11 @@
 
 			prm_clockdomains: clockdomains {
 			};
+
+			prm_resets: resets {
+				compatible = "ti,omap5-resets";
+				#reset-cells = <1>;
+			};
 		};
 
 		cm_core_aon: cm_core_aon at 4a004000 {
diff --git a/include/dt-bindings/reset/ti,omap5-resets.h b/include/dt-bindings/reset/ti,omap5-resets.h
new file mode 100644
index 0000000..33bb295
--- /dev/null
+++ b/include/dt-bindings/reset/ti,omap5-resets.h
@@ -0,0 +1,22 @@
+/*
+ * OMAP5 reset index for PRCM Module
+ *
+ * Copyright 2014 Texas Instruments Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _DT_BINDINGS_RESET_TI_OMAP5_H
+#define _DT_BINDINGS_RESET_TI_OMAP5_H
+
+#define RESET_DEVICE_RESET			0
+#define RESET_DSP_RESET				1
+#define RESET_DSP_MMU_CACHE_RESET	2
+#define RESET_IPU_CPU0_RESET		3
+#define RESET_IPU_CPU1_RESET		4
+#define RESET_IPU_MMU_CACHE_RESET	5
+#define RESET_IVA_RESET				6
+
+#endif
-- 
1.7.9.5
