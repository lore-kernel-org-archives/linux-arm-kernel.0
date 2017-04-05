From: minghsiu.tsai@mediatek.com (Minghsiu Tsai)
Date: Wed, 5 Apr 2017 18:54:29 +0800
Subject: [PATCH] media: mtk-vcodec: remove informative log
Message-ID: <1491389669-32737-1-git-send-email-minghsiu.tsai@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver is stable. Remove DEBUG definition from driver.

There are debug message in /var/log/messages if DEBUG is defined,
such as:
[MTK_V4L2] level=0 fops_vcodec_open(),170: decoder capability 0
[MTK_V4L2] level=0 fops_vcodec_open(),177: 16000000.vcodec decoder [0]
[MTK_V4L2] level=0 fops_vcodec_release(),200: [0] decoder

Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
index 7d55975..1248083 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
@@ -31,7 +31,6 @@ struct mtk_vcodec_mem {
 extern int mtk_v4l2_dbg_level;
 extern bool mtk_vcodec_dbg;
 
-#define DEBUG	1
 
 #if defined(DEBUG)
 
-- 
1.9.1
