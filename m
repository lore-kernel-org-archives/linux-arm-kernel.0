From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Fri, 23 Aug 2013 19:15:53 -0400
Subject: [RFC PATCH 12/14] arm: dts: add omap5 CORE thermal data
In-Reply-To: <1377299755-5134-1-git-send-email-eduardo.valentin@ti.com>
References: <1377299755-5134-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1377299755-5134-13-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes a dtsi file to contain the thermal data
for CORE domain on OMAP5 and later SoCs. This data will
enable a thermal shutdown at 125C.

This thermal data can be reused across TI SoC devices.

Cc: "Beno?t Cousson" <b-cousson@ti.com>
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
---
 arch/arm/boot/dts/omap5-core-thermal.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap5-core-thermal.dtsi

diff --git a/arch/arm/boot/dts/omap5-core-thermal.dtsi b/arch/arm/boot/dts/omap5-core-thermal.dtsi
new file mode 100644
index 0000000..3d9fa09
--- /dev/null
+++ b/arch/arm/boot/dts/omap5-core-thermal.dtsi
@@ -0,0 +1,27 @@
+
+/*
+ * Device Tree Source for OMAP543x SoC CORE thermal
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
+core_thermal: core_thermal {
+	#thermal-cells = <1>;
+	mask = <0x01>; /* trips writability */
+	passive_delay = <250>; /* milliseconds */
+	polling_delay = <1000>; /* milliseconds */
+	trips {
+		crit at 125000{
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = <THERMAL_TRIP_CRITICAL>;
+		};
+	};
+};
-- 
1.8.2.1.342.gfa7285d
