From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Thu, 22 Feb 2018 10:51:27 +0100
Subject: [PATCH] media: stm32-dcmi: fix unnecessary parentheses
Message-ID: <1519293087-19984-1-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix unnecessary parentheses in if conditions.
Detected by checkpatch.pl --strict.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 536c0d5..269e963 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -477,7 +477,7 @@ static void dcmi_buf_queue(struct vb2_buffer *vb)
 
 	spin_lock_irq(&dcmi->irqlock);
 
-	if ((dcmi->state == RUNNING) && (!dcmi->active)) {
+	if (dcmi->state == RUNNING && !dcmi->active) {
 		dcmi->active = buf;
 
 		dev_dbg(dcmi->dev, "Starting capture on buffer[%d] queued\n",
@@ -730,7 +730,7 @@ static void __find_outer_frame_size(struct stm32_dcmi *dcmi,
 		int h_err = (fsize->height - pix->height);
 		int err = w_err + h_err;
 
-		if ((w_err >= 0) && (h_err >= 0) && (err < min_err)) {
+		if (w_err >= 0 && h_err >= 0 && err < min_err) {
 			min_err = err;
 			match = fsize;
 		}
@@ -1065,10 +1065,10 @@ static int dcmi_s_selection(struct file *file, void *priv,
 	r.top  = clamp_t(s32, r.top, 0, pix.height - r.height);
 	r.left = clamp_t(s32, r.left, 0, pix.width - r.width);
 
-	if (!((r.top == dcmi->sd_bounds.top) &&
-	      (r.left == dcmi->sd_bounds.left) &&
-	      (r.width == dcmi->sd_bounds.width) &&
-	      (r.height == dcmi->sd_bounds.height))) {
+	if (!(r.top == dcmi->sd_bounds.top &&
+	      r.left == dcmi->sd_bounds.left &&
+	      r.width == dcmi->sd_bounds.width &&
+	      r.height == dcmi->sd_bounds.height)) {
 		/* Crop if request is different than sensor resolution */
 		dcmi->do_crop = true;
 		dcmi->crop = r;
-- 
1.9.1
