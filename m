From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 21 May 2014 09:20:13 +0100
Subject: [PATCH 1/3] ARM: sti: stih416: Add support for B2020 RevE
Message-ID: <1400660415-14720-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The B2020 RevE differs from the other B2020 boards in a few subtle ways;
including the Ethernet reset GPIO which this patch adds support for and
the LED wiring which will follow in a latter patch.  Without supplying
these differences Ethernet and the board LEDs simply will not work.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/Makefile               |  3 ++-
 arch/arm/boot/dts/stih416-b2020-revE.dts | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/stih416-b2020-revE.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 35c146f..0f89cdf 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -338,7 +338,8 @@ dtb-$(CONFIG_ARCH_SPEAR6XX)+= spear600-evb.dtb
 dtb-$(CONFIG_ARCH_STI)+= stih415-b2000.dtb \
 	stih416-b2000.dtb \
 	stih415-b2020.dtb \
-	stih416-b2020.dtb
+	stih416-b2020.dtb \
+	stih416-b2020-revE.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += \
 	sun4i-a10-a1000.dtb \
 	sun4i-a10-cubieboard.dtb \
diff --git a/arch/arm/boot/dts/stih416-b2020-revE.dts b/arch/arm/boot/dts/stih416-b2020-revE.dts
new file mode 100644
index 0000000..202919a
--- /dev/null
+++ b/arch/arm/boot/dts/stih416-b2020-revE.dts
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2014 STMicroelectronics (R&D) Limited.
+ * Author: Lee Jones <lee.jones@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
+/dts-v1/;
+#include "stih416.dtsi"
+#include "stih41x-b2020.dtsi"
+/ {
+        model = "STiH416 B2020 REV-E";
+	compatible = "st,stih416-b2020", "st,stih416";
+
+	soc {
+		ethernet1: ethernet at fef08000 {
+			snps,reset-gpio = <&PIO0 7>;
+		};
+	};
+};
-- 
1.8.3.2
