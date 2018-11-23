From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:55 +0100
Subject: [PATCH v2 23/43] drm/sun4i: backend: Detail the YUV to RGB values
 coding explanation
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-24-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Paul Kocialkowski <contact@paulk.fr>

The values in the BT601 YUV to RGB colorspace translation are not
simply coded as multiples, but rather as fixed-point signed fractional
values on a given number of bits. Add an explanation about that.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index a39d8b75d76a..986bdb64521c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -48,8 +48,12 @@ static const u32 sunxi_rgb2yuv_coef[12] = {
 /*
  * These coefficients are taken from the A33 BSP from Allwinner.
  *
- * The formula is for each component, each coefficient being multiplied by
- * 1024 and each constant being multiplied by 16:
+ * The first three values of each row are coded as 13-bit signed fixed-point
+ * numbers, with 10 bits for the fractional part. The fourth value is a
+ * constant coded as a 14-bit signed fixed-point number with 4 bits for the
+ * fractional part.
+ *
+ * The values in table order give the following colorspace translation:
  * G = 1.164 * Y - 0.391 * U - 0.813 * V + 135
  * R = 1.164 * Y + 1.596 * V - 222
  * B = 1.164 * Y + 2.018 * U + 276
-- 
2.19.1
