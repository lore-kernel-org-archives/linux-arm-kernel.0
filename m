From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Mon, 6 Jan 2014 08:36:45 -0400
Subject: [PATCHv2 1/7] arm: dts: add dra7 DSPEVE thermal data
In-Reply-To: <1389011811-13004-1-git-send-email-eduardo.valentin@ti.com>
References: <1389011811-13004-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1389011811-13004-2-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces a dtsi file to contain the thermal data
for DSPEVE domain on DRA7 and later SoCs. This data will
enable a thermal shutdown at 125C.

Cc: Beno?t Cousson <bcousson@baylibre.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi

diff --git a/arch/arm/boot/dts/dra7-dspeve-thermal.dtsi b/arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
new file mode 100644
index 0000000..50e78b6
--- /dev/null
+++ b/arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
@@ -0,0 +1,28 @@
+/*
+ * Device Tree Source for DRA7 SoC DSPEVE thermal
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
+dspeve_thermal: dspeve_thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <1000>; /* milliseconds */
+
+			/* sensor       ID */
+	thermal-sensors = <&bandgap     3>;
+
+	trips {
+		dspeve_crit: dspeve_crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
-- 
1.8.2.1.342.gfa7285d
