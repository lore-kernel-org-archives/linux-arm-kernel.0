From: rainyfeeling@gmail.com (Josh Wu)
Date: Mon, 18 Jan 2016 20:21:38 +0800
Subject: [PATCH 02/13] atmel-isi: move the is_support() close to try/set
 format function
In-Reply-To: <1453119709-20940-1-git-send-email-rainyfeeling@gmail.com>
References: <1453119709-20940-1-git-send-email-rainyfeeling@gmail.com>
Message-ID: <1453119709-20940-3-git-send-email-rainyfeeling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As is_support() only used by try/set format function so put them
together.

Signed-off-by: Josh Wu <rainyfeeling@gmail.com>
---

 drivers/media/platform/soc_camera/atmel-isi.c | 36 +++++++++++++--------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/media/platform/soc_camera/atmel-isi.c b/drivers/media/platform/soc_camera/atmel-isi.c
index dc81df3..3793b68 100644
--- a/drivers/media/platform/soc_camera/atmel-isi.c
+++ b/drivers/media/platform/soc_camera/atmel-isi.c
@@ -189,24 +189,6 @@ static void configure_geometry(struct atmel_isi *isi, u32 width,
 	return;
 }
 
-static bool is_supported(struct soc_camera_device *icd,
-		const u32 pixformat)
-{
-	switch (pixformat) {
-	/* YUV, including grey */
-	case V4L2_PIX_FMT_GREY:
-	case V4L2_PIX_FMT_YUYV:
-	case V4L2_PIX_FMT_UYVY:
-	case V4L2_PIX_FMT_YVYU:
-	case V4L2_PIX_FMT_VYUY:
-	/* RGB */
-	case V4L2_PIX_FMT_RGB565:
-		return true;
-	default:
-		return false;
-	}
-}
-
 static irqreturn_t atmel_isi_handle_streaming(struct atmel_isi *isi)
 {
 	if (isi->active) {
@@ -571,6 +553,24 @@ static int isi_camera_init_videobuf(struct vb2_queue *q,
 	return vb2_queue_init(q);
 }
 
+static bool is_supported(struct soc_camera_device *icd,
+		const u32 pixformat)
+{
+	switch (pixformat) {
+	/* YUV, including grey */
+	case V4L2_PIX_FMT_GREY:
+	case V4L2_PIX_FMT_YUYV:
+	case V4L2_PIX_FMT_UYVY:
+	case V4L2_PIX_FMT_YVYU:
+	case V4L2_PIX_FMT_VYUY:
+	/* RGB */
+	case V4L2_PIX_FMT_RGB565:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int try_or_set_fmt(struct soc_camera_device *icd,
 		   struct v4l2_format *f,
 		   struct v4l2_subdev_format *format)
-- 
1.9.1
