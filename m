From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 22 Dec 2011 15:56:42 +0100
Subject: [PATCH v4 08/12] arm/dts: twl4030: Add DTS file for twl4030 PM +
 Audio IC
In-Reply-To: <1324565806-31142-1-git-send-email-b-cousson@ti.com>
References: <1324565806-31142-1-git-send-email-b-cousson@ti.com>
Message-ID: <1324565806-31142-9-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a dedicated DTS file for the twl4030/5030 Power + Audio IC.
This chip is a big SoC that will be reused in a lot of various
OMAP3 boards.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/twl4030.dtsi |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/twl4030.dtsi

diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
new file mode 100644
index 0000000..8be5223
--- /dev/null
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Integrated Power Management Chip
+ */
+&twl {
+	compatible = "ti,twl4030";
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	rtc {
+		compatible = "ti,twl4030-rtc";
+		interrupts = <11>;
+	};
+};
-- 
1.7.0.4
