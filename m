From: jani.nikula@intel.com (Jani Nikula)
Date: Thu,  2 Apr 2015 13:52:00 +0300
Subject: [PATCH] drm/edid: add #defines for ELD versions
In-Reply-To: <20150401115602.GB24899@n2100.arm.linux.org.uk>
References: <20150401115602.GB24899@n2100.arm.linux.org.uk>
Message-ID: <1427971920-3830-1-git-send-email-jani.nikula@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ELD versions according to HDA Specification v1.0a.

2 indicates version 2, which supports CEA_Ver 861D or below. Maximum
Baseline ELD size of 80 bytes (15 SAD count).

31 indicates an ELD that has been partially populated through
implementation specific mean of default programming before an external
graphics driver is loaded. Only the field that is called out as "canned"
field will be populated, and audio driver should ignore the non "canned"
field.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>

---

Russell, please feel free to include this patch in your series if this
isn't picked up on its own.
---
 include/drm/drm_edid.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 87d85e81d3a7..799050198323 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -215,6 +215,8 @@ struct detailed_timing {
 #define DRM_ELD_VER			0
 # define DRM_ELD_VER_SHIFT		3
 # define DRM_ELD_VER_MASK		(0x1f << 3)
+# define DRM_ELD_VER_CEA861D		(2 << 3) /* supports 861D or below */
+# define DRM_ELD_VER_CANNED		(0x1f << 3)
 
 #define DRM_ELD_BASELINE_ELD_LEN	2	/* in dwords! */
 
-- 
2.1.4
