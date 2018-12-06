Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F2DC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:01:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21172082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iUW8k8AL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21172082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tFlIZyjI0SzuWKdrQAgocKBs4a3OGNYRCBGBxbiBkh8=; b=iUW8k8ALiBvXZL
	yXRAjHEzmxBgaCUskC6CoBfR5EFg1wt4TsXwmauQqks8zH3Tb8AIwjdK1v9MOzf6kC+rUp3WWdL3W
	t4ddu15U8nDHtCtz8tQOo4wBqnphk8Xr06N8Bv08u9WgIGnn6qgO08M1apaJvvk/DjPBgC2NLx65V
	VW8yZgBvWUq4B8RjkXffDfBW2559Rv0BHrWJ7YUBcOtoTC88gdYFJ4tHb0d/25780xwqgcm9VknbR
	iVxYWXYfAWnB0AltdPdeSPBU8LXxJx8aY2oNNr0yxCAI+XUx0/rnEcfDHGCioruEAq8vWjndu4cu3
	OkLahDuUWyCfQTyUFmog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUh6Q-00062v-DG; Thu, 06 Dec 2018 00:01:14 +0000
Received: from 201.86.173.17.dynamic.adsl.gvt.net.br ([201.86.173.17]
 helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUh6O-00062X-4Q; Thu, 06 Dec 2018 00:01:12 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.91)
 (envelope-from <mchehab@bombadil.infradead.org>)
 id 1gUh6L-000ALf-VL; Wed, 05 Dec 2018 19:01:09 -0500
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: 
Subject: [PATCH v2] media: rockchip vpu: remove some unused vars
Date: Wed,  5 Dec 2018 19:01:09 -0500
Message-Id: <10b532d7f12ef0718028a3ecb4f00974ebd80c4c.1544054436.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, Heiko Stuebner <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

As complained by gcc:

	drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c: In function 'rk3288_vpu_jpeg_enc_set_qtable':
	drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c:70:10: warning: variable 'chroma_qtable_p' set but not used [-Wunused-but-set-variable]
	  __be32 *chroma_qtable_p;
	          ^~~~~~~~~~~~~~~
	drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c:69:10: warning: variable 'luma_qtable_p' set but not used [-Wunused-but-set-variable]
	  __be32 *luma_qtable_p;
	          ^~~~~~~~~~~~~
	drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c: In function 'rk3399_vpu_jpeg_enc_set_qtable':
	drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c:101:10: warning: variable 'chroma_qtable_p' set but not used [-Wunused-but-set-variable]
	  __be32 *chroma_qtable_p;
	          ^~~~~~~~~~~~~~~
	drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c:100:10: warning: variable 'luma_qtable_p' set but not used [-Wunused-but-set-variable]
	  __be32 *luma_qtable_p;
	          ^~~~~~~~~~~~~
	drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c: In function 'rockchip_vpu_queue_setup':
	drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c:522:33: warning: variable 'vpu_fmt' set but not used [-Wunused-but-set-variable]
	  const struct rockchip_vpu_fmt *vpu_fmt;
	                                 ^~~~~~~
	drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c: In function 'rockchip_vpu_buf_prepare':
	drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c:560:33: warning: variable 'vpu_fmt' set but not used [-Wunused-but-set-variable]
	  const struct rockchip_vpu_fmt *vpu_fmt;
	                                 ^~~~~~~

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c | 5 -----
 drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c | 5 -----
 drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c       | 6 ------
 3 files changed, 16 deletions(-)

diff --git a/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c b/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c
index e27c10855de5..5282236d1bb1 100644
--- a/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c
+++ b/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c
@@ -66,13 +66,8 @@ rk3288_vpu_jpeg_enc_set_qtable(struct rockchip_vpu_dev *vpu,
 			       unsigned char *luma_qtable,
 			       unsigned char *chroma_qtable)
 {
-	__be32 *luma_qtable_p;
-	__be32 *chroma_qtable_p;
 	u32 reg, i;
 
-	luma_qtable_p = (__be32 *)luma_qtable;
-	chroma_qtable_p = (__be32 *)chroma_qtable;
-
 	for (i = 0; i < VEPU_JPEG_QUANT_TABLE_COUNT; i++) {
 		reg = get_unaligned_be32(&luma_qtable[i]);
 		vepu_write_relaxed(vpu, reg, VEPU_REG_JPEG_LUMA_QUAT(i));
diff --git a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
index 5f75e4d11d76..dbc86d95fe3b 100644
--- a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
+++ b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
@@ -97,13 +97,8 @@ rk3399_vpu_jpeg_enc_set_qtable(struct rockchip_vpu_dev *vpu,
 			       unsigned char *luma_qtable,
 			       unsigned char *chroma_qtable)
 {
-	__be32 *luma_qtable_p;
-	__be32 *chroma_qtable_p;
 	u32 reg, i;
 
-	luma_qtable_p = (__be32 *)luma_qtable;
-	chroma_qtable_p = (__be32 *)chroma_qtable;
-
 	for (i = 0; i < VEPU_JPEG_QUANT_TABLE_COUNT; i++) {
 		reg = get_unaligned_be32(&luma_qtable[i]);
 		vepu_write_relaxed(vpu, reg, VEPU_REG_JPEG_LUMA_QUAT(i));
diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
index 038a7136d5d1..ab0fb2053620 100644
--- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
+++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
@@ -519,17 +519,14 @@ rockchip_vpu_queue_setup(struct vb2_queue *vq,
 			 struct device *alloc_devs[])
 {
 	struct rockchip_vpu_ctx *ctx = vb2_get_drv_priv(vq);
-	const struct rockchip_vpu_fmt *vpu_fmt;
 	struct v4l2_pix_format_mplane *pixfmt;
 	int i;
 
 	switch (vq->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
-		vpu_fmt = ctx->vpu_dst_fmt;
 		pixfmt = &ctx->dst_fmt;
 		break;
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
-		vpu_fmt = ctx->vpu_src_fmt;
 		pixfmt = &ctx->src_fmt;
 		break;
 	default:
@@ -557,7 +554,6 @@ static int rockchip_vpu_buf_prepare(struct vb2_buffer *vb)
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 	struct vb2_queue *vq = vb->vb2_queue;
 	struct rockchip_vpu_ctx *ctx = vb2_get_drv_priv(vq);
-	const struct rockchip_vpu_fmt *vpu_fmt;
 	struct v4l2_pix_format_mplane *pixfmt;
 	unsigned int sz;
 	int ret = 0;
@@ -565,11 +561,9 @@ static int rockchip_vpu_buf_prepare(struct vb2_buffer *vb)
 
 	switch (vq->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
-		vpu_fmt = ctx->vpu_dst_fmt;
 		pixfmt = &ctx->dst_fmt;
 		break;
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
-		vpu_fmt = ctx->vpu_src_fmt;
 		pixfmt = &ctx->src_fmt;
 
 		if (vbuf->field == V4L2_FIELD_ANY)
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
