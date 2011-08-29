From: khilman@ti.com (Kevin Hilman)
Date: Mon, 29 Aug 2011 11:10:49 -0700
Subject: [PATCH 7/7] omap: voltage: add a stub header file for
	external/regulator use
In-Reply-To: <1314641449-5089-1-git-send-email-khilman@ti.com>
References: <1314641449-5089-1-git-send-email-khilman@ti.com>
Message-ID: <1314641449-5089-8-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tero Kristo <t-kristo@ti.com>

Needed as some of the voltage layer functionality is accessed from the
SMPS regulator driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/voltage.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/voltage.h

diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
new file mode 100644
index 0000000..0a6a482
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -0,0 +1,20 @@
+/*
+ * OMAP Voltage Management Routines
+ *
+ * Copyright (C) 2011, Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_OMAP_VOLTAGE_H
+#define __ARCH_ARM_OMAP_VOLTAGE_H
+
+struct voltagedomain;
+
+struct voltagedomain *voltdm_lookup(const char *name);
+int voltdm_scale(struct voltagedomain *voltdm, unsigned long target_volt);
+unsigned long voltdm_get_voltage(struct voltagedomain *voltdm);
+
+#endif
-- 
1.7.6
