From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 04 Oct 2012 21:12:44 +0530
Subject: [PATCH v1 06/14] drm: exynos: remove drm hdmi platform data struct
In-Reply-To: <1349365372-21417-1-git-send-email-rahul.sharma@samsung.com>
References: <1349365372-21417-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1349365372-21417-7-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the drm hdmi platform data structure which is no
longer in use by drm hdmi driver after this patch set get merged. s5p
hdmi platform data structure is used instead.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 include/drm/exynos_drm.h |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/include/drm/exynos_drm.h b/include/drm/exynos_drm.h
index 0d1c503..8bdd49a 100644
--- a/include/drm/exynos_drm.h
+++ b/include/drm/exynos_drm.h
@@ -254,18 +254,5 @@ struct exynos_drm_common_hdmi_pd {
 	struct device *mixer_dev;
 };
 
-/**
- * Platform Specific Structure for DRM based HDMI core.
- *
- * @is_v13: set if hdmi version 13 is.
- * @cfg_hpd: function pointer to configure hdmi hotplug detection pin
- * @get_hpd: function pointer to get value of hdmi hotplug detection pin
- */
-struct exynos_drm_hdmi_pdata {
-	bool is_v13;
-	void (*cfg_hpd)(bool external);
-	int (*get_hpd)(void);
-};
-
 #endif	/* __KERNEL__ */
 #endif	/* _EXYNOS_DRM_H_ */
-- 
1.7.0.4
