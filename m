Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123EEC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:16:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A8F218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KkIeca+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A8F218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soulik.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ERFKbMDQAgQzKnFo1bcQlh/MljAdbkv5gxRa6fWmWE4=; b=KkIeca+kdsFv3F
	qS5wFbo1VwjJznfhIAqqfLeaRYclzlEcZuQHWKYJJTM3H2bKe5wRvoTBRwq8WH4Af6ECJqm7hTzlz
	RW6+in1HRtZqZbJgTqIEgZ4pd1WPIGbDJBKaoM9cXwJFyqvb8XZoanW58/DY4A7PSeKLmmVe5cRX9
	tw5zp+2T8UPlqsJKGLMr08QfDVtUnB6TL0Mg2fHPoByuzuS1SWiWwdPaGhzJ+IJLsPZ28ExGbqvk7
	JdKY7kcJE+/y83Hj6cwAp4i5oHGUFhQalu0j4WNcuZQT04np0ixBoDOc512j42U1TvYXzT5O8c8Q/
	RTSF++1GMkqDsoRgz44Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp2pa-0000m6-3n; Thu, 31 Jan 2019 03:15:58 +0000
Received: from kozue.soulik.info ([108.61.200.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp2ng-0006QR-5r; Thu, 31 Jan 2019 03:14:19 +0000
Received: from misaki.sumomo.pri (unknown
 [IPv6:2001:470:b30d:2:c604:15ff:0:91f])
 by kozue.soulik.info (Postfix) with ESMTPA id 5D2DB1018B9;
 Thu, 31 Jan 2019 12:15:10 +0900 (JST)
From: ayaka <ayaka@soulik.info>
To: linux-media@vger.kernel.org
Subject: [PATCH 3/4] [TEST]: rockchip: mpp: support qtable
Date: Thu, 31 Jan 2019 11:13:32 +0800
Message-Id: <20190131031333.11905-4-ayaka@soulik.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131031333.11905-1-ayaka@soulik.info>
References: <20190131031333.11905-1-ayaka@soulik.info>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_191400_930258_838D72F2 
X-CRM114-Status: GOOD (  11.22  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: hverkuil@xs4all.nl, acourbot@chromium.org, maxime.ripard@bootlin.com,
 joro@8bytes.org, ayaka <ayaka@soulik.info>, randy.li@rock-chips.com,
 linux-kernel@vger.kernel.org, jernej.skrabec@gmail.com, nicolas@ndufresne.ca,
 paul.kocialkowski@bootlin.com, linux-rockchip@lists.infradead.org,
 thomas.petazzoni@bootlin.com, mchehab@kernel.org, ezequiel@collabora.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Yes, the buffer won't be freed.
I don't want to store buffers for a session.
I just want to use it to verify the FFmpeg.

Signed-off-by: ayaka <ayaka@soulik.info>
---
 drivers/staging/rockchip-mpp/mpp_dev_common.h |  3 ++
 drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c  |  3 ++
 drivers/staging/rockchip-mpp/vdpu2/mpeg2.c    | 42 +++++++++++++++----
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rockchip-mpp/mpp_dev_common.h b/drivers/staging/rockchip-mpp/mpp_dev_common.h
index 36770af53a95..33d7725be67b 100644
--- a/drivers/staging/rockchip-mpp/mpp_dev_common.h
+++ b/drivers/staging/rockchip-mpp/mpp_dev_common.h
@@ -100,6 +100,9 @@ struct mpp_session {
 	struct v4l2_ctrl_handler ctrl_handler;
 	/* TODO: FIXME: slower than helper function ? */
 	struct v4l2_ctrl **ctrls;
+
+	dma_addr_t qtable_addr;
+	void *qtable_vaddr;
 };
 
 /* The context for the a task */
diff --git a/drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c b/drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c
index 03ed080bb35c..9e00501c3577 100644
--- a/drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c
+++ b/drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c
@@ -402,6 +402,9 @@ static int rkvdpu_open(struct file *filp)
 		return error;
 	}
 
+	session->qtable_vaddr = dmam_alloc_coherent(mpp_dev->dev, 64 * 4,
+						    &session->qtable_addr,
+						    GFP_KERNEL);
 	filp->private_data = &session->fh;
 
 	mpp_debug_leave();
diff --git a/drivers/staging/rockchip-mpp/vdpu2/mpeg2.c b/drivers/staging/rockchip-mpp/vdpu2/mpeg2.c
index a16f7629a811..416348630779 100644
--- a/drivers/staging/rockchip-mpp/vdpu2/mpeg2.c
+++ b/drivers/staging/rockchip-mpp/vdpu2/mpeg2.c
@@ -27,6 +27,34 @@
 
 #define DEC_LITTLE_ENDIAN	(1)
 
+static const u8 zigzag[64] = {
+	0,   1,  8, 16,  9,  2,  3, 10,
+	17, 24, 32, 25, 18, 11,  4,  5,
+	12, 19, 26, 33, 40, 48, 41, 34,
+	27, 20, 13,  6,  7, 14, 21, 28,
+	35, 42, 49, 56, 57, 50, 43, 36,
+	29, 22, 15, 23, 30, 37, 44, 51,
+	58, 59, 52, 45, 38, 31, 39, 46,
+	53, 60, 61, 54, 47, 55, 62, 63
+};
+
+static void mpeg2_dec_copy_qtable(u8 *qtable,
+	const struct v4l2_ctrl_mpeg2_quantization *ctrl)
+{
+	int i, n;
+
+	if (!qtable || !ctrl)
+		return;
+
+	for (i = 0; i < 64; i++) {
+		n = zigzag[i];
+		qtable[n + 0] = ctrl->intra_quantiser_matrix[i];
+		qtable[n + 64] = ctrl->non_intra_quantiser_matrix[i];
+		qtable[n + 128] = ctrl->chroma_intra_quantiser_matrix[i];
+		qtable[n + 192] = ctrl->chroma_non_intra_quantiser_matrix[i];
+	}
+}
+
 static void init_hw_cfg(struct vdpu2_regs *p_regs)
 {
     p_regs->sw54.dec_strm_wordsp = 1;
@@ -61,7 +89,6 @@ int rkvdpu_mpeg2_gen_reg(struct mpp_session *session, void *regs,
 			 struct vb2_v4l2_buffer *src_buf)
 {
 	const struct v4l2_ctrl_mpeg2_slice_params *params;
-	const struct v4l2_ctrl_mpeg2_quantization *quantization;
 	const struct v4l2_mpeg2_sequence *sequence;
 	const struct v4l2_mpeg2_picture *picture;
 	struct sg_table *sgt;
@@ -69,9 +96,6 @@ int rkvdpu_mpeg2_gen_reg(struct mpp_session *session, void *regs,
 
 	params = rockchip_mpp_get_cur_ctrl(session,
 			V4L2_CID_MPEG_VIDEO_MPEG2_SLICE_PARAMS);
-	quantization = rockchip_mpp_get_cur_ctrl(session,
-			V4L2_CID_MPEG_VIDEO_MPEG2_QUANTIZATION);
-
 	if (!params)
 		return -EINVAL;
 	
@@ -164,6 +188,7 @@ int rkvdpu_mpeg2_prepare_buf(struct mpp_session *session, void *regs)
 {
 	const struct v4l2_ctrl_mpeg2_slice_params *params;
 	const struct v4l2_mpeg2_sequence *sequence;
+	const struct v4l2_ctrl_mpeg2_quantization *quantization;
 	const struct v4l2_mpeg2_picture *picture;
 	struct vb2_v4l2_buffer *dst_buf;
 	dma_addr_t cur_addr, fwd_addr, bwd_addr;
@@ -177,6 +202,9 @@ int rkvdpu_mpeg2_prepare_buf(struct mpp_session *session, void *regs)
 	picture = &params->picture;
 	sequence = &params->sequence;
 
+	quantization = rockchip_mpp_get_cur_ctrl(session,
+			V4L2_CID_MPEG_VIDEO_MPEG2_QUANTIZATION);
+
 	dst_buf = v4l2_m2m_next_dst_buf(session->fh.m2m_ctx);
 
 	sgt = vb2_dma_sg_plane_desc(&dst_buf->vb2_buf, 0);
@@ -219,9 +247,7 @@ int rkvdpu_mpeg2_prepare_buf(struct mpp_session *session, void *regs)
 	p_regs->sw134.refer2_base = bwd_addr >> 2;
 	p_regs->sw135.refer3_base = bwd_addr >> 2;
 
-#if 0
-        //ref & qtable config
-        p_regs->sw61.qtable_base = mpp_buffer_get_fd(ctx->qp_table);
-#endif
+	mpeg2_dec_copy_qtable(session->qtable_vaddr, quantization);
+        p_regs->sw61.qtable_base = session->qtable_addr;
 	return 0;
 }
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
