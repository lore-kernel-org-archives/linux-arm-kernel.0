From: alex.shi@linaro.org (Alex Shi)
Date: Tue, 25 Mar 2014 18:49:25 +0800
Subject: [PATCH 12/19] arm: dts: add omap5 GPU thermal data
In-Reply-To: <1395744572-20014-1-git-send-email-alex.shi@linaro.org>
References: <1395744572-20014-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1395744572-20014-13-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eduardo Valentin <eduardo.valentin@ti.com>

This patch changes a dtsi file to contain the thermal data
for GPU domain on OMAP5 and later SoCs. This data will
enable a thermal shutdown at 125C.

This thermal data can be reused across TI SoC devices.

Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
(cherry picked from commit 28c90169f1d5eabf503e356c76bf49a67aef4cc0)

Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm/boot/dts/omap5-gpu-thermal.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap5-gpu-thermal.dtsi

diff --git a/arch/arm/boot/dts/omap5-gpu-thermal.dtsi b/arch/arm/boot/dts/omap5-gpu-thermal.dtsi
new file mode 100644
index 0000000..1b87aca
--- /dev/null
+++ b/arch/arm/boot/dts/omap5-gpu-thermal.dtsi
@@ -0,0 +1,28 @@
+/*
+ * Device Tree Source for OMAP543x SoC GPU thermal
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Contact: Eduardo Valentin <eduardo.valentin@ti.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <dt-bindings/thermal/thermal.h>
+
+gpu_thermal: gpu_thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <1000>; /* milliseconds */
+
+			/* sensor       ID */
+	thermal-sensors = <&bandgap     1>;
+
+	trips {
+		gpu_crit: gpu_crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
-- 
1.8.1.2
