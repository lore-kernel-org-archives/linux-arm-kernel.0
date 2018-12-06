Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F34FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:40:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D03120989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C6n3LxvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D03120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RNgdsPdfCvN6W61g8q2nNN5M1S9wIMWrConxoFp+FL4=; b=C6n3LxvBl94ClX
	DvW5QhoiZJdF2Nugu5q0mI5XK+Lf5E/q/Kgq6q1L9uXA5MZDw/4Puh9IkJJBf3AGKPecPIVdYj91x
	gnqkdj7CF5yhX2SgqLqmFagNSt9XHQjSGGPx2EhSnL74I8f12GpT2zCPkDV+2Zs912QYP3gA5gsr+
	L9x4JHo3OX6QPcQrjt8paW48iRDRoOZNz2nOgsXgIPOVz4JLRmXReymgwXjUAeQDX9+u1MXhEUCGa
	EUzIzTAufGleT/LUkSmgn5Fpai/iHYXQC0wV8ZSgfv7nmjFeVEvgupMjvjNhf2FOkaLTDxXCIIk3h
	d5mC2TnbsuuC1TcrkeSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV2JV-0006VE-EE; Thu, 06 Dec 2018 22:40:09 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV2JR-0005EQ-RS; Thu, 06 Dec 2018 22:40:07 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: ezequiel) with ESMTPSA id E1D40260B79
Message-ID: <80e6ccf201a0e956997651ae8cf698c0b7a9621f.camel@collabora.com>
Subject: Re: [PATCH v2] media: rockchip vpu: remove some unused vars
From: Ezequiel Garcia <ezequiel@collabora.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Thu, 06 Dec 2018 19:39:44 -0300
In-Reply-To: <10b532d7f12ef0718028a3ecb4f00974ebd80c4c.1544054436.git.mchehab+samsung@kernel.org>
References: <10b532d7f12ef0718028a3ecb4f00974ebd80c4c.1544054436.git.mchehab+samsung@kernel.org>
Organization: Collabora
User-Agent: Evolution 3.30.2-1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_144006_163826_05DC5089 
X-CRM114-Status: GOOD (  13.48  )
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 linux-rockchip@lists.infradead.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 linux-arm-kernel@lists.infradead.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2018-12-05 at 19:01 -0500, Mauro Carvalho Chehab wrote:
> As complained by gcc:
> 
> 	drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c: In function 'rk3288_vpu_jpeg_enc_set_qtable':
> 	drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c:70:10: warning: variable 'chroma_qtable_p' set but not used [-Wunused-but-set-
> variable]
> 	  __be32 *chroma_qtable_p;
> 	          ^~~~~~~~~~~~~~~
> 	drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c:69:10: warning: variable 'luma_qtable_p' set but not used [-Wunused-but-set-
> variable]
> 	  __be32 *luma_qtable_p;
> 	          ^~~~~~~~~~~~~
> 	drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c: In function 'rk3399_vpu_jpeg_enc_set_qtable':
> 	drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c:101:10: warning: variable 'chroma_qtable_p' set but not used [-Wunused-but-set-
> variable]
> 	  __be32 *chroma_qtable_p;
> 	          ^~~~~~~~~~~~~~~
> 	drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c:100:10: warning: variable 'luma_qtable_p' set but not used [-Wunused-but-set-
> variable]
> 	  __be32 *luma_qtable_p;
> 	          ^~~~~~~~~~~~~
> 	drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c: In function 'rockchip_vpu_queue_setup':
> 	drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c:522:33: warning: variable 'vpu_fmt' set but not used [-Wunused-but-set-variable]
> 	  const struct rockchip_vpu_fmt *vpu_fmt;
> 	                                 ^~~~~~~
> 	drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c: In function 'rockchip_vpu_buf_prepare':
> 	drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c:560:33: warning: variable 'vpu_fmt' set but not used [-Wunused-but-set-variable]
> 	  const struct rockchip_vpu_fmt *vpu_fmt;
> 	                                 ^~~~~~~
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Ezequiel Garcia <ezequiel@collabora.com>

Thanks!


> ---
>  drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c | 5 -----
>  drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c | 5 -----
>  drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c       | 6 ------
>  3 files changed, 16 deletions(-)
> 
> diff --git a/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c b/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c
> index e27c10855de5..5282236d1bb1 100644
> --- a/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c
> +++ b/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c
> @@ -66,13 +66,8 @@ rk3288_vpu_jpeg_enc_set_qtable(struct rockchip_vpu_dev *vpu,
>  			       unsigned char *luma_qtable,
>  			       unsigned char *chroma_qtable)
>  {
> -	__be32 *luma_qtable_p;
> -	__be32 *chroma_qtable_p;
>  	u32 reg, i;
>  
> -	luma_qtable_p = (__be32 *)luma_qtable;
> -	chroma_qtable_p = (__be32 *)chroma_qtable;
> -
>  	for (i = 0; i < VEPU_JPEG_QUANT_TABLE_COUNT; i++) {
>  		reg = get_unaligned_be32(&luma_qtable[i]);
>  		vepu_write_relaxed(vpu, reg, VEPU_REG_JPEG_LUMA_QUAT(i));
> diff --git a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
> index 5f75e4d11d76..dbc86d95fe3b 100644
> --- a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
> +++ b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
> @@ -97,13 +97,8 @@ rk3399_vpu_jpeg_enc_set_qtable(struct rockchip_vpu_dev *vpu,
>  			       unsigned char *luma_qtable,
>  			       unsigned char *chroma_qtable)
>  {
> -	__be32 *luma_qtable_p;
> -	__be32 *chroma_qtable_p;
>  	u32 reg, i;
>  
> -	luma_qtable_p = (__be32 *)luma_qtable;
> -	chroma_qtable_p = (__be32 *)chroma_qtable;
> -
>  	for (i = 0; i < VEPU_JPEG_QUANT_TABLE_COUNT; i++) {
>  		reg = get_unaligned_be32(&luma_qtable[i]);
>  		vepu_write_relaxed(vpu, reg, VEPU_REG_JPEG_LUMA_QUAT(i));
> diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
> index 038a7136d5d1..ab0fb2053620 100644
> --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
> +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
> @@ -519,17 +519,14 @@ rockchip_vpu_queue_setup(struct vb2_queue *vq,
>  			 struct device *alloc_devs[])
>  {
>  	struct rockchip_vpu_ctx *ctx = vb2_get_drv_priv(vq);
> -	const struct rockchip_vpu_fmt *vpu_fmt;
>  	struct v4l2_pix_format_mplane *pixfmt;
>  	int i;
>  
>  	switch (vq->type) {
>  	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> -		vpu_fmt = ctx->vpu_dst_fmt;
>  		pixfmt = &ctx->dst_fmt;
>  		break;
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> -		vpu_fmt = ctx->vpu_src_fmt;
>  		pixfmt = &ctx->src_fmt;
>  		break;
>  	default:
> @@ -557,7 +554,6 @@ static int rockchip_vpu_buf_prepare(struct vb2_buffer *vb)
>  	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>  	struct vb2_queue *vq = vb->vb2_queue;
>  	struct rockchip_vpu_ctx *ctx = vb2_get_drv_priv(vq);
> -	const struct rockchip_vpu_fmt *vpu_fmt;
>  	struct v4l2_pix_format_mplane *pixfmt;
>  	unsigned int sz;
>  	int ret = 0;
> @@ -565,11 +561,9 @@ static int rockchip_vpu_buf_prepare(struct vb2_buffer *vb)
>  
>  	switch (vq->type) {
>  	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> -		vpu_fmt = ctx->vpu_dst_fmt;
>  		pixfmt = &ctx->dst_fmt;
>  		break;
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> -		vpu_fmt = ctx->vpu_src_fmt;
>  		pixfmt = &ctx->src_fmt;
>  
>  		if (vbuf->field == V4L2_FIELD_ANY)



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
