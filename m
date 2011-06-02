From: khilman@ti.com (Kevin Hilman)
Date: Wed,  1 Jun 2011 17:19:29 -0700
Subject: [PATCH v4 03/18] I2C: OMAP2+: Introduce I2C IP versioning constants
In-Reply-To: <1306973984-15165-1-git-send-email-khilman@ti.com>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
Message-ID: <1306973984-15165-4-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andy Green <andy@warmcat.com>

These represent the two kinds of (incompatible) OMAP I2C
peripheral unit in use so far.

The constants are in linux/i2c-omap.h so the omap i2c driver can have
them too.

Cc: patches at linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/i2c.h |    1 +
 include/linux/i2c-omap.h              |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
index 878d632..a1d3d06 100644
--- a/arch/arm/plat-omap/include/plat/i2c.h
+++ b/arch/arm/plat-omap/include/plat/i2c.h
@@ -22,6 +22,7 @@
 #define __ASM__ARCH_OMAP_I2C_H
 
 #include <linux/i2c.h>
+#include <linux/i2c-omap.h>
 
 #if defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
 extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index 7472449..701886d 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -3,6 +3,18 @@
 
 #include <linux/platform_device.h>
 
+/*
+ * Version 2 of the I2C peripheral unit has a different register
+ * layout and extra registers.  The ID register in the V2 peripheral
+ * unit on the OMAP4430 reports the same ID as the V1 peripheral
+ * unit on the OMAP3530, so we must inform the driver which IP
+ * version we know it is running on from platform / cpu-specific
+ * code using these constants in the hwmod class definition.
+ */
+
+#define OMAP_I2C_IP_VERSION_1 1
+#define OMAP_I2C_IP_VERSION_2 2
+
 struct omap_i2c_bus_platform_data {
 	u32		clkrate;
 	void		(*set_mpu_wkup_lat)(struct device *dev, long set);
-- 
1.7.4
