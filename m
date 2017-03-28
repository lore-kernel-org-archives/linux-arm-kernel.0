From: yannick.fertre@st.com (Yannick Fertre)
Date: Tue, 28 Mar 2017 11:44:44 +0200
Subject: [PATCH v5 01/10] drm/cma: Update DEFINE_DRM_GEM_CMA_FOPS to add
 get_unmapped_area
In-Reply-To: <1490694293-18358-1-git-send-email-yannick.fertre@st.com>
References: <1490694293-18358-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1490694293-18358-2-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Missing field get_unmapped_area which is necessary with device without MMU

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 include/drm/drm_gem_cma_helper.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/drm/drm_gem_cma_helper.h b/include/drm/drm_gem_cma_helper.h
index f962d33..7320b14 100644
--- a/include/drm/drm_gem_cma_helper.h
+++ b/include/drm/drm_gem_cma_helper.h
@@ -50,6 +50,7 @@ struct drm_gem_cma_object {
 		.read		= drm_read,\
 		.llseek		= noop_llseek,\
 		.mmap		= drm_gem_cma_mmap,\
+		.get_unmapped_area	= drm_gem_cma_get_unmapped_area,\
 	}
 
 /* free GEM object */
-- 
1.9.1
