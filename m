From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 05 Aug 2014 12:47:38 +0200
Subject: [PATCH 10/29] drivers: add DRIVER_HAS_OWN_IOMMU_MANAGER flag
In-Reply-To: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1407235677-26324-11-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a new flags for device drivers. This flag instructs
kernel that the device driver does it own management of IOMMU assisted
IO address space translations, so no default dma-mapping structures
should be initialized.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/device.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 5f4ff02..2e62371 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -253,6 +253,8 @@ struct device_driver {
 
 /* disables bind/unbind via sysfs */
 #define DRIVER_SUPPRESS_BIND_ATTRS	(1 << 0)
+/* driver uses own methods to manage IO address space */
+#define DRIVER_HAS_OWN_IOMMU_MANAGER	(1 << 1)
 
 extern int __must_check driver_register(struct device_driver *drv);
 extern void driver_unregister(struct device_driver *drv);
-- 
1.9.2
