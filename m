From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 22 Nov 2015 08:45:34 +0100
Subject: [PATCH] [media] s5p-mfc: constify s5p_mfc_codec_ops structures
Message-ID: <1448178334-8495-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The s5p_mfc_codec_ops structures are never modified, so declare them as
const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/media/platform/s5p-mfc/s5p_mfc_common.h |    2 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c    |    4 ++--
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.h    |    2 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c    |    4 ++--
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.h    |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
index d1a3f9b..e90ad7e 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
@@ -653,7 +653,7 @@ struct s5p_mfc_ctx {
 		unsigned int bits;
 	} slice_size;
 
-	struct s5p_mfc_codec_ops *c_ops;
+	const struct s5p_mfc_codec_ops *c_ops;
 
 	struct v4l2_ctrl *ctrls[MFC_MAX_CTRLS];
 	struct v4l2_ctrl_handler ctrl_handler;
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
index 1c4998c..e741550 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -252,7 +252,7 @@ static int s5p_mfc_ctx_ready(struct s5p_mfc_ctx *ctx)
 	return 0;
 }
 
-static struct s5p_mfc_codec_ops decoder_codec_ops = {
+static const struct s5p_mfc_codec_ops decoder_codec_ops = {
 	.pre_seq_start		= NULL,
 	.post_seq_start		= NULL,
 	.pre_frame_start	= NULL,
@@ -1104,7 +1104,7 @@ static struct vb2_ops s5p_mfc_dec_qops = {
 	.buf_queue		= s5p_mfc_buf_queue,
 };
 
-struct s5p_mfc_codec_ops *get_dec_codec_ops(void)
+const struct s5p_mfc_codec_ops *get_dec_codec_ops(void)
 {
 	return &decoder_codec_ops;
 }
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.h b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.h
index d06a7ca..886628b 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.h
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.h
@@ -13,7 +13,7 @@
 #ifndef S5P_MFC_DEC_H_
 #define S5P_MFC_DEC_H_
 
-struct s5p_mfc_codec_ops *get_dec_codec_ops(void);
+const struct s5p_mfc_codec_ops *get_dec_codec_ops(void);
 struct vb2_ops *get_dec_queue_ops(void);
 const struct v4l2_ioctl_ops *get_dec_v4l2_ioctl_ops(void);
 struct s5p_mfc_fmt *get_dec_def_fmt(bool src);
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
index 115b7da..dec228f 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
@@ -936,7 +936,7 @@ static int enc_post_frame_start(struct s5p_mfc_ctx *ctx)
 	return 0;
 }
 
-static struct s5p_mfc_codec_ops encoder_codec_ops = {
+static const struct s5p_mfc_codec_ops encoder_codec_ops = {
 	.pre_seq_start		= enc_pre_seq_start,
 	.post_seq_start		= enc_post_seq_start,
 	.pre_frame_start	= enc_pre_frame_start,
@@ -2052,7 +2052,7 @@ static struct vb2_ops s5p_mfc_enc_qops = {
 	.buf_queue		= s5p_mfc_buf_queue,
 };
 
-struct s5p_mfc_codec_ops *get_enc_codec_ops(void)
+const struct s5p_mfc_codec_ops *get_enc_codec_ops(void)
 {
 	return &encoder_codec_ops;
 }
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.h b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.h
index 5118d46..d0d42f8 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.h
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.h
@@ -13,7 +13,7 @@
 #ifndef S5P_MFC_ENC_H_
 #define S5P_MFC_ENC_H_
 
-struct s5p_mfc_codec_ops *get_enc_codec_ops(void);
+const struct s5p_mfc_codec_ops *get_enc_codec_ops(void);
 struct vb2_ops *get_enc_queue_ops(void);
 const struct v4l2_ioctl_ops *get_enc_v4l2_ioctl_ops(void);
 struct s5p_mfc_fmt *get_enc_def_fmt(bool src);
