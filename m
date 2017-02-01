From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed,  1 Feb 2017 17:05:21 -0300
Subject: [PATCH 1/2] [media] exynos-gsc: Do not swap cb/cr for semi planar
 formats
In-Reply-To: <1485979523-32404-1-git-send-email-javier@osg.samsung.com>
References: <1485979523-32404-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1485979523-32404-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thibault Saunier <thibault.saunier@osg.samsung.com>

In the case of semi planar formats cb and cr are in the same plane
in memory, meaning that will be set to 'cb' whatever the format is,
and whatever the (packed) order of those components are.

Suggested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Thibault Saunier <thibault.saunier@osg.samsung.com>
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/media/platform/exynos-gsc/gsc-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/exynos-gsc/gsc-core.c b/drivers/media/platform/exynos-gsc/gsc-core.c
index 40aff08dd51d..a846659ae5c1 100644
--- a/drivers/media/platform/exynos-gsc/gsc-core.c
+++ b/drivers/media/platform/exynos-gsc/gsc-core.c
@@ -861,9 +861,7 @@ int gsc_prepare_addr(struct gsc_ctx *ctx, struct vb2_buffer *vb,
 
 	if ((frame->fmt->pixelformat == V4L2_PIX_FMT_VYUY) ||
 		(frame->fmt->pixelformat == V4L2_PIX_FMT_YVYU) ||
-		(frame->fmt->pixelformat == V4L2_PIX_FMT_NV61) ||
 		(frame->fmt->pixelformat == V4L2_PIX_FMT_YVU420) ||
-		(frame->fmt->pixelformat == V4L2_PIX_FMT_NV21) ||
 		(frame->fmt->pixelformat == V4L2_PIX_FMT_YVU420M))
 		swap(addr->cb, addr->cr);
 
-- 
2.7.4
