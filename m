From: wuchengli@chromium.org (Wu-Cheng Li)
Date: Tue, 19 Jan 2016 15:07:10 +0800
Subject: [PATCH v4 2/2] s5p-mfc: add the support of
 V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME.
In-Reply-To: <1453187230-97231-1-git-send-email-wuchengli@chromium.org>
References: <1453187230-97231-1-git-send-email-wuchengli@chromium.org>
Message-ID: <1453187230-97231-3-git-send-email-wuchengli@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a new control V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME to
force an encoder key frame. It is the same as requesting
V4L2_MPEG_MFC51_VIDEO_FORCE_FRAME_TYPE_I_FRAME.

Signed-off-by: Wu-Cheng Li <wuchengli@chromium.org>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
index 0434f02..034b5c1 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
@@ -212,6 +212,14 @@ static struct mfc_control controls[] = {
 		.menu_skip_mask = 0,
 	},
 	{
+		.id = V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME,
+		.type = V4L2_CTRL_TYPE_BUTTON,
+		.minimum = 0,
+		.maximum = 0,
+		.step = 0,
+		.default_value = 0,
+	},
+	{
 		.id = V4L2_CID_MPEG_VIDEO_VBV_SIZE,
 		.type = V4L2_CTRL_TYPE_INTEGER,
 		.minimum = 0,
@@ -1423,6 +1431,10 @@ static int s5p_mfc_enc_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MPEG_MFC51_VIDEO_FORCE_FRAME_TYPE:
 		ctx->force_frame_type = ctrl->val;
 		break;
+	case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
+		ctx->force_frame_type =
+			V4L2_MPEG_MFC51_VIDEO_FORCE_FRAME_TYPE_I_FRAME;
+		break;
 	case V4L2_CID_MPEG_VIDEO_VBV_SIZE:
 		p->vbv_size = ctrl->val;
 		break;
-- 
2.6.0.rc2.230.g3dd15c0
