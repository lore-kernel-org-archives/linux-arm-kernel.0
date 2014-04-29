From: dmurphy@ti.com (Dan Murphy)
Date: Tue, 29 Apr 2014 15:19:47 -0500
Subject: [RFC 08/11] ARM: dts: am33xx: Add prcm_resets node
In-Reply-To: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
References: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
Message-ID: <1398802790-29287-9-git-send-email-dmurphy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the prcm_resets node to the prcm parent node.
Add the dt-bindings header to the DT file

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi                |    6 ++++++
 include/dt-bindings/reset/ti,am33xx-resets.h |   18 ++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 include/dt-bindings/reset/ti,am33xx-resets.h

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 07f283c..df9d9c6 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -10,6 +10,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/am33xx.h>
+#include <dt-bindings/reset/ti,am33xx-resets.h>
 
 #include "skeleton.dtsi"
 
@@ -117,6 +118,11 @@
 
 			prcm_clockdomains: clockdomains {
 			};
+
+			prcm_resets: resets {
+				compatible = "ti,am335x-resets";
+				#reset-cells = <1>;
+			};
 		};
 
 		scrm: scrm at 44e10000 {
diff --git a/include/dt-bindings/reset/ti,am33xx-resets.h b/include/dt-bindings/reset/ti,am33xx-resets.h
new file mode 100644
index 0000000..dfe7954
--- /dev/null
+++ b/include/dt-bindings/reset/ti,am33xx-resets.h
@@ -0,0 +1,18 @@
+/*
+ * AM33xx reset index for PRCM Module
+ *
+ * Copyright 2014 Texas Instruments Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _DT_BINDINGS_RESET_TI_AM33XX_H
+#define _DT_BINDINGS_RESET_TI_AM33XX_H
+
+#define RESET_DEVICE_RESET			0
+#define RESET_GFX_RESET				1
+#define RESET_PER_RESET				2
+
+#endif
-- 
1.7.9.5
