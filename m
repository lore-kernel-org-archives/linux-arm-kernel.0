From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed,  1 Feb 2017 17:05:22 -0300
Subject: [PATCH 2/2] [media] exynos-gsc: Add support for NV{16, 21,
 61}M pixel formats
In-Reply-To: <1485979523-32404-1-git-send-email-javier@osg.samsung.com>
References: <1485979523-32404-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1485979523-32404-3-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thibault Saunier <thibault.saunier@osg.samsung.com>

Those are useful formats that should be handled.

Signed-off-by: Thibault Saunier <thibault.saunier@osg.samsung.com>
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/media/platform/exynos-gsc/gsc-core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/media/platform/exynos-gsc/gsc-core.c b/drivers/media/platform/exynos-gsc/gsc-core.c
index a846659ae5c1..eff636d4502b 100644
--- a/drivers/media/platform/exynos-gsc/gsc-core.c
+++ b/drivers/media/platform/exynos-gsc/gsc-core.c
@@ -112,6 +112,15 @@ static const struct gsc_fmt gsc_formats[] = {
 		.num_planes	= 1,
 		.num_comp	= 2,
 	}, {
+		.name		= "YUV 4:2:2 non-contig, Y/CbCr",
+		.pixelformat	= V4L2_PIX_FMT_NV16M,
+		.depth		= { 8, 8 },
+		.color		= GSC_YUV422,
+		.yorder		= GSC_LSB_Y,
+		.corder		= GSC_CBCR,
+		.num_planes	= 2,
+		.num_comp	= 2,
+	}, {
 		.name		= "YUV 4:2:2 planar, Y/CrCb",
 		.pixelformat	= V4L2_PIX_FMT_NV61,
 		.depth		= { 16 },
@@ -121,6 +130,15 @@ static const struct gsc_fmt gsc_formats[] = {
 		.num_planes	= 1,
 		.num_comp	= 2,
 	}, {
+		.name		= "YUV 4:2:2 non-contig, Y/CrCb",
+		.pixelformat	= V4L2_PIX_FMT_NV61M,
+		.depth		= { 8, 8 },
+		.color		= GSC_YUV422,
+		.yorder		= GSC_LSB_Y,
+		.corder		= GSC_CRCB,
+		.num_planes	= 2,
+		.num_comp	= 2,
+	}, {
 		.name		= "YUV 4:2:0 planar, YCbCr",
 		.pixelformat	= V4L2_PIX_FMT_YUV420,
 		.depth		= { 12 },
@@ -158,6 +176,15 @@ static const struct gsc_fmt gsc_formats[] = {
 		.num_planes	= 1,
 		.num_comp	= 2,
 	}, {
+		.name		= "YUV 4:2:0 non-contig. 2p, Y/CrCb",
+		.pixelformat	= V4L2_PIX_FMT_NV21M,
+		.depth		= { 8, 4 },
+		.color		= GSC_YUV420,
+		.yorder		= GSC_LSB_Y,
+		.corder		= GSC_CRCB,
+		.num_planes	= 2,
+		.num_comp	= 2,
+	}, {
 		.name		= "YUV 4:2:0 non-contig. 2p, Y/CbCr",
 		.pixelformat	= V4L2_PIX_FMT_NV12M,
 		.depth		= { 8, 4 },
-- 
2.7.4
