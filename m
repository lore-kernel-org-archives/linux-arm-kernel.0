From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 17 Nov 2014 16:48:00 +0000
Subject: [PATCH v3 07/11] ARM: STi: DT: STiH410: Add pinctl config for usb
 controllers.
In-Reply-To: <1416242884-5261-1-git-send-email-peter.griffin@linaro.org>
References: <1416242884-5261-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1416242884-5261-8-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the required pin configiguration for the extra usb
controllers found on the stih410 device.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih410-pinctrl.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 arch/arm/boot/dts/stih410-pinctrl.dtsi

diff --git a/arch/arm/boot/dts/stih410-pinctrl.dtsi b/arch/arm/boot/dts/stih410-pinctrl.dtsi
new file mode 100644
index 0000000..b3e9dfc
--- /dev/null
+++ b/arch/arm/boot/dts/stih410-pinctrl.dtsi
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2014 STMicroelectronics Limited.
+ * Author: Peter Griffin <peter.griffin@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
+#include "st-pincfg.h"
+/ {
+
+	soc {
+		pin-controller-rear {
+
+			usb0 {
+				pinctrl_usb0: usb2-0 {
+					st,pins {
+						usb-oc-detect = <&pio35 0 ALT1 IN>;
+						usb-pwr-enable = <&pio35 1 ALT1 OUT>;
+					};
+				};
+			};
+
+			usb1 {
+				pinctrl_usb1: usb2-1 {
+					st,pins {
+						usb-oc-detect = <&pio35 2 ALT1 IN>;
+						usb-pwr-enable = <&pio35 3 ALT1 OUT>;
+					};
+				};
+			};
+		};
+	};
+};
-- 
1.9.1
