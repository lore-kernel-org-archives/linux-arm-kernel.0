From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Apr 2016 15:22:44 +0200
Subject: [PATCH v4 03/11] drm: fb: Add seq_file definition
In-Reply-To: <1461590572-4027-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1461590572-4027-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1461590572-4027-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise, building with DEBUG_FS enabled will trigger a build warning
because we're using a structure that has not been declared.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 include/drm/drm_fb_cma_helper.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/drm/drm_fb_cma_helper.h b/include/drm/drm_fb_cma_helper.h
index be62bd321e75..ae49c24fbf50 100644
--- a/include/drm/drm_fb_cma_helper.h
+++ b/include/drm/drm_fb_cma_helper.h
@@ -24,6 +24,8 @@ struct drm_gem_cma_object *drm_fb_cma_get_gem_obj(struct drm_framebuffer *fb,
 	unsigned int plane);
 
 #ifdef CONFIG_DEBUG_FS
+struct seq_file;
+
 int drm_fb_cma_debugfs_show(struct seq_file *m, void *arg);
 #endif
 
-- 
2.8.1
