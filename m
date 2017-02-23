From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 23 Feb 2017 16:05:33 +0800
Subject: [PATCH 01/11] drm/sun4i: Make sunxi_rgb2yuv_coef constant
In-Reply-To: <20170223080543.6659-1-wens@csie.org>
References: <20170223080543.6659-1-wens@csie.org>
Message-ID: <20170223080543.6659-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sunxi_rgb2yuv_coef is a table of RGB-to-YUV conversion coefficients.
They are programmed into the hardware, and can be declared constant.

Reported-by: Priit Laes <plaes@plaes.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 5bf1ea4d92fc..7a61bd330f04 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -24,7 +24,7 @@
 #include "sun4i_backend.h"
 #include "sun4i_drv.h"
 
-static u32 sunxi_rgb2yuv_coef[12] = {
+static const u32 sunxi_rgb2yuv_coef[12] = {
 	0x00000107, 0x00000204, 0x00000064, 0x00000108,
 	0x00003f69, 0x00003ed6, 0x000001c1, 0x00000808,
 	0x000001c1, 0x00003e88, 0x00003fb8, 0x00000808
-- 
2.11.0
