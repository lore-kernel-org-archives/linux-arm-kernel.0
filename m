From: colin.king@canonical.com (Colin King)
Date: Thu, 29 Nov 2018 10:50:38 +0000
Subject: [PATCH][media-next] media: sun6i: fix spelling mistake "droped" ->
 "dropped"
Message-ID: <20181129105038.17902-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in dev_dbg messages, fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
index 37c85b8f37a9..b04300c3811f 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
@@ -261,7 +261,7 @@ void sun6i_video_frame_done(struct sun6i_video *video)
 	buf = list_first_entry(&video->dma_queue,
 			       struct sun6i_csi_buffer, list);
 	if (list_is_last(&buf->list, &video->dma_queue)) {
-		dev_dbg(video->csi->dev, "Frame droped!\n");
+		dev_dbg(video->csi->dev, "Frame dropped!\n");
 		goto unlock;
 	}
 
@@ -274,7 +274,7 @@ void sun6i_video_frame_done(struct sun6i_video *video)
 	if (!next_buf->queued_to_csi) {
 		next_buf->queued_to_csi = true;
 		sun6i_csi_update_buf_addr(video->csi, next_buf->dma_addr);
-		dev_dbg(video->csi->dev, "Frame droped!\n");
+		dev_dbg(video->csi->dev, "Frame dropped!\n");
 		goto unlock;
 	}
 
-- 
2.19.1
