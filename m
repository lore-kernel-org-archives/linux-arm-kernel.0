From: keiichiw@chromium.org (Keiichi Watanabe)
Date: Thu, 14 Jun 2018 16:46:52 +0900
Subject: [PATCH v3 3/3] media: mtk-vcodec: Support VP9 profile in decoder
In-Reply-To: <20180614074652.162796-1-keiichiw@chromium.org>
References: <20180614074652.162796-1-keiichiw@chromium.org>
Message-ID: <20180614074652.162796-4-keiichiw@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add V4L2_CID_MPEG_VIDEO_VP9_PROFILE control in MediaTek decoder's
driver.
MediaTek decoder only supports profile 0 for now.

Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
index 86f0a7134365..ba986232b953 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
@@ -1400,6 +1400,11 @@ int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
 				V4L2_CID_MIN_BUFFERS_FOR_CAPTURE,
 				0, 32, 1, 1);
 	ctrl->flags |= V4L2_CTRL_FLAG_VOLATILE;
+	v4l2_ctrl_new_std_menu(&ctx->ctrl_hdl,
+				&mtk_vcodec_dec_ctrl_ops,
+				V4L2_CID_MPEG_VIDEO_VP9_PROFILE,
+				V4L2_MPEG_VIDEO_VP9_PROFILE_0,
+				0, V4L2_MPEG_VIDEO_VP9_PROFILE_0);

 	if (ctx->ctrl_hdl.error) {
 		mtk_v4l2_err("Adding control failed %d",
--
2.18.0.rc1.242.g61856ae69a-goog
