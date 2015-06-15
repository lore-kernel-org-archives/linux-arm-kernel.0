From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 15 Jun 2015 11:09:42 +0200
Subject: [PATCH v4 1/4] VFIO: platform: add reset struct and lookup table
In-Reply-To: <1434359385-19916-1-git-send-email-eric.auger@linaro.org>
References: <1434359385-19916-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1434359385-19916-2-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces the vfio_platform_reset_combo struct that
stores all the information useful to handle the reset modality:
compat string, name of the reset function, name of the module that
implements the reset function. A lookup table of such structures
is added, currently void.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v3 -> v4:
- update the commit message

v2 -> v3:
- add const in struct vfio_platform_reset_combo
- remove enum vfio_platform_reset_type

v2: creation
---
 drivers/vfio/platform/vfio_platform_common.c  | 3 +++
 drivers/vfio/platform/vfio_platform_private.h | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index abcff7a..611597e 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -25,6 +25,9 @@
 
 static DEFINE_MUTEX(driver_lock);
 
+static const struct vfio_platform_reset_combo reset_lookup_table[] = {
+};
+
 static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
 {
 	int cnt = 0, i;
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 5d31e04..9e37b9f 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -69,6 +69,12 @@ struct vfio_platform_device {
 	int	(*get_irq)(struct vfio_platform_device *vdev, int i);
 };
 
+struct vfio_platform_reset_combo {
+	const char *compat;
+	const char *reset_function_name;
+	const char *module_name;
+};
+
 extern int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 				      struct device *dev);
 extern struct vfio_platform_device *vfio_platform_remove_common
-- 
1.9.1
