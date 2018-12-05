Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DA0C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:48:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18CF5208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q7pNc6Ze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18CF5208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R73Hy//kHYH2frB+cVaaRj1M6fs1AMJDFB2cZsLJhBI=; b=q7pNc6Ze7FKcRI
	zETUrSJRL2Scn0w58tKjdF0Y8aKHgDq5sFzb+GE4larco4H07EwLNwn1wrTbv1WK9SLPgC0TZKx7m
	Dyy1doYvnHPHvhmBjHbM2q3d0w2TJnMVn1pBdVpz1h5TKzJUlLYMxo5+WLEZTzDQXS/RWBMZ62NoC
	eO9vP7Ht+gbi4an6tBPNrKhkrjv2yN63ZuSVO6FwbQPuCl8Y3810hUMtt7hAgj6QPq1tzyyTTgUoG
	4/yLNXrCA4SQzshiC7oh3qXWJsjSBKb32mkIa25KPVIwqqTiNwtdHPR2VxoBo0AYA3xN5cC9Dpuot
	Em/WKoAfLMlUUbTwiBIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUcEC-0001ev-9l; Wed, 05 Dec 2018 18:48:56 +0000
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUcE8-0001Zt-W3; Wed, 05 Dec 2018 18:48:55 +0000
Received: from [192.168.2.10] ([212.251.195.8])
 by smtp-cloud8.xs4all.net with ESMTPA
 id UcDigS9JXO44XUcDlgRD5L; Wed, 05 Dec 2018 19:48:35 +0100
Subject: Re: [PATCH] media: rockchip/vpu: fix a few alignments
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <bcebf81255a71b34541bc00bcb505e815193f0be.1544035391.git.mchehab+samsung@kernel.org>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <45972676-265a-51ce-c9eb-ff49f8eab5bb@xs4all.nl>
Date: Wed, 5 Dec 2018 19:48:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <bcebf81255a71b34541bc00bcb505e815193f0be.1544035391.git.mchehab+samsung@kernel.org>
Content-Language: en-US
X-CMAE-Envelope: MS4wfEG44pmZ0sP0oQ4vQyIuoULKsD44URqjxKVgka6KtJxoiVXzEUZ564GoMFfzTLmCzzCQsOa3v72rlK97CLq5Mh6z2f+hZoQ2bsuXFgjHSLGknyRdO6pT
 KIUEkBoAPwrLzCqiCIwT9o0l+jQPH4pbOG969gR6lE3fzUfyRpPVBLW6uyd+Yacf0SA0H3daP+8XZOOPizSmqvAkfuBx5FgAeEAUmlPDOaE8tgL2CKShU/cb
 7lSEXSlL4loEPMupCgcdxjfm2D0H6Fx1GH9BKjhCE2UOQp1tskkMcvi+hD9Dda/3jyOLGWdmul3pGZ8OQg1tsVsr3NA8R/IiEavGWwi321kuHDnwawAuarHv
 JtM7UzRJPcTHK/luSl4RP2z6gV+RmhksW9iW4OguPi4/siMbWfFymQ5cUKelN/AGg0DBE84PDvanB1CQhH0obiZ35nR/QOfvf3dJKRE3gclQBWW7sZlIesBO
 PagHXBXx+3hfBl7mrHD+G9PuDfDhZGYwKYmm7g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_104853_247677_02C06B79 
X-CRM114-Status: GOOD (  14.98  )
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
 linux-rockchip@lists.infradead.org, Ezequiel Garcia <ezequiel@collabora.com>,
 linux-arm-kernel@lists.infradead.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/05/2018 07:43 PM, Mauro Carvalho Chehab wrote:
> As reported by checkpatch.pl, some function calls have a wrong
> alignment.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c | 4 ++--
>  drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c b/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c
> index 8919151e1631..e27c10855de5 100644
> --- a/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c
> +++ b/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c
> @@ -106,8 +106,8 @@ void rk3288_vpu_jpeg_enc_run(struct rockchip_vpu_ctx *ctx)
>  	rk3288_vpu_set_src_img_ctrl(vpu, ctx);
>  	rk3288_vpu_jpeg_enc_set_buffers(vpu, ctx, src_buf);
>  	rk3288_vpu_jpeg_enc_set_qtable(vpu,
> -		rockchip_vpu_jpeg_get_qtable(&jpeg_ctx, 0),
> -		rockchip_vpu_jpeg_get_qtable(&jpeg_ctx, 1));
> +				       rockchip_vpu_jpeg_get_qtable(&jpeg_ctx, 0),
> +				       rockchip_vpu_jpeg_get_qtable(&jpeg_ctx, 1));

But now you get warnings because this is > 80 columns.

I think the 'cure' is worse than the disease.

I see this is already merged, but I don't think this patch improves readability,
which is more important than a checkpatch warning IMHO.

Regards,

	Hans

>  
>  	reg = VEPU_REG_AXI_CTRL_OUTPUT_SWAP16
>  		| VEPU_REG_AXI_CTRL_INPUT_SWAP16
> diff --git a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
> index 8afa2162bf9f..5f75e4d11d76 100644
> --- a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
> +++ b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
> @@ -137,8 +137,8 @@ void rk3399_vpu_jpeg_enc_run(struct rockchip_vpu_ctx *ctx)
>  	rk3399_vpu_set_src_img_ctrl(vpu, ctx);
>  	rk3399_vpu_jpeg_enc_set_buffers(vpu, ctx, src_buf);
>  	rk3399_vpu_jpeg_enc_set_qtable(vpu,
> -			rockchip_vpu_jpeg_get_qtable(&jpeg_ctx, 0),
> -			rockchip_vpu_jpeg_get_qtable(&jpeg_ctx, 1));
> +				       rockchip_vpu_jpeg_get_qtable(&jpeg_ctx, 0),
> +				       rockchip_vpu_jpeg_get_qtable(&jpeg_ctx, 1));
>  
>  	reg = VEPU_REG_OUTPUT_SWAP32
>  		| VEPU_REG_OUTPUT_SWAP16
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
