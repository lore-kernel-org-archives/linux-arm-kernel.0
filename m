From: dmurphy@ti.com (Dan Murphy)
Date: Tue, 29 Apr 2014 15:19:48 -0500
Subject: [RFC 09/11] ARM: dts: am4372: Add prcm_resets node
In-Reply-To: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
References: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
Message-ID: <1398802790-29287-10-git-send-email-dmurphy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the prcm_resets node to the prcm parent node.
Add the dt-bindings header to the DT file

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi                |    6 ++++++
 include/dt-bindings/reset/ti,am437x-resets.h |   19 +++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 include/dt-bindings/reset/ti,am437x-resets.h

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 36d523a..f8bd4ca 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -10,6 +10,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/ti,am437x-resets.h>
 
 #include "skeleton.dtsi"
 
@@ -84,6 +85,11 @@
 
 			prcm_clockdomains: clockdomains {
 			};
+
+			prcm_resets: resets {
+				compatible = "ti,am4372-resets";
+				#reset-cells = <1>;
+			};
 		};
 
 		scrm: scrm at 44e10000 {
diff --git a/include/dt-bindings/reset/ti,am437x-resets.h b/include/dt-bindings/reset/ti,am437x-resets.h
new file mode 100644
index 0000000..cf3e329
--- /dev/null
+++ b/include/dt-bindings/reset/ti,am437x-resets.h
@@ -0,0 +1,19 @@
+/*
+ * AM437x reset index for PRCM Module
+ *
+ * Copyright 2014 Texas Instruments Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _DT_BINDINGS_RESET_TI_AM437X_H
+#define _DT_BINDINGS_RESET_TI_AM437X_H
+
+#define RESET_DEVICE_RESET			0
+#define RESET_ICSS_RESET			1
+#define RESET_GFX_RESET				2
+#define RESET_PER_RESET				3
+
+#endif
-- 
1.7.9.5
