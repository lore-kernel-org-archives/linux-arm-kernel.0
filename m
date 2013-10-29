From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Oct 2013 18:20:58 +0100
Subject: [PATCH] drm: shmobile: Add dependency on BACKLIGHT_CLASS_DEVICE
In-Reply-To: <20131029100413.GA8857@n2100.arm.linux.org.uk>
References: <20131029100413.GA8857@n2100.arm.linux.org.uk>
Message-ID: <1383067258-1711-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The driver registers a backlight device and thus requires
BACKLIGHT_CLASS_DEVICE to be selected to avoid compilation breakages.

Cc: stable at vger.kernel.org
Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/gpu/drm/shmobile/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/shmobile/Kconfig b/drivers/gpu/drm/shmobile/Kconfig
index ca498d1..5240690 100644
--- a/drivers/gpu/drm/shmobile/Kconfig
+++ b/drivers/gpu/drm/shmobile/Kconfig
@@ -1,6 +1,7 @@
 config DRM_SHMOBILE
 	tristate "DRM Support for SH Mobile"
 	depends on DRM && (ARM || SUPERH)
+	select BACKLIGHT_CLASS_DEVICE
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
 	select DRM_GEM_CMA_HELPER
-- 
Regards,

Laurent Pinchart
