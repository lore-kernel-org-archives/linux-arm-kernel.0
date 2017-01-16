From: christopher.lee.bostic@gmail.com (christopher.lee.bostic at gmail.com)
Date: Mon, 16 Jan 2017 15:23:36 -0600
Subject: [PATCH v3 02/18] drivers/fsi: Add device & driver definitions
Message-ID: <1484601816-98188-1-git-send-email-christopher.lee.bostic@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

Add structs for fsi devices & drivers, and struct device conversion
functions.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Chris Bostic <cbostic@us.ibm.com>
---
 include/linux/fsi.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/fsi.h b/include/linux/fsi.h
index 47aa181..f73886a 100644
--- a/include/linux/fsi.h
+++ b/include/linux/fsi.h
@@ -17,6 +17,17 @@
 
 #include <linux/device.h>
 
+struct fsi_device {
+	struct device dev;
+};
+
+struct fsi_driver {
+	struct device_driver drv;
+};
+
+#define to_fsi_dev(devp) container_of(devp, struct fsi_device, dev)
+#define to_fsi_drv(drvp) container_of(drvp, struct fsi_driver, drv)
+
 extern struct bus_type fsi_bus_type;
 
 #endif /* LINUX_FSI_H */
-- 
1.8.2.2
