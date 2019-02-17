Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67210C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 20:17:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39343217FA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 20:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="epWbHr6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39343217FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FXd0r70jzF01CUzaYttNKre0YcU2tX9gHhhnbPZ1L0E=; b=epWbHr6XRJE8/T
	T0KNYx/rowXgTl+2hLoSVocCw3la4vCbuNVpjWjaq6iMVTWjEZ8SDRCS6MVTTFslWCiZDqXiStwh6
	GK0aN6MVEsmOju6QauWXyzWw0olDJUvxOXsQnen5JFe9jO8BgY9lmSGkNp8L4HMazmjkAARb8ZmA7
	33Ij1oRkQXfk7nFuI4/Zt6jxYlfVe5+jub3VLr+YWl1DHs+fnlTJ0ovWYHlOIZQV1k2k1Z10OfV9W
	YLHnh60usor0S3JrncK4U+EAdum3s+Euo788c9vJCNzQrU0j3B27Wd3uijfeXOcXuTTgRQdjnX0fI
	bsKT2JLCRBa5VU274V+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvSsa-0002FO-Ph; Sun, 17 Feb 2019 20:17:36 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvSsV-0002Ec-RG; Sun, 17 Feb 2019 20:17:33 +0000
Received: from p5b127a91.dip0.t-ipconnect.de ([91.18.122.145]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gvSsQ-0003H2-Gf; Sun, 17 Feb 2019 21:17:26 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Urja Rannikko <urjaman@gmail.com>
Subject: Re: [PATCH] drm/rockchip: vop: Dither down to RGB666 if output bpc is
 6
Date: Sun, 17 Feb 2019 21:17:25 +0100
Message-ID: <5787325.TG7Q2WIxUi@phil>
In-Reply-To: <20190217134255.6287-1-urjaman@gmail.com>
References: <20190217134255.6287-1-urjaman@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_121732_032617_908B80D3 
X-CRM114-Status: GOOD (  17.16  )
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
Cc: linux-rockchip@lists.infradead.org, hjc@rock-chips.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Am Sonntag, 17. Februar 2019, 14:42:27 CET schrieb Urja Rannikko:
> Tested to fix banding on the 6-bit panel of the ASUS C201.
> 
> Signed-off-by: Urja Rannikko <urjaman@gmail.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 0c35a88e33dd..96ba1b4cd07b 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -896,6 +896,7 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
>  	u16 vsync_len = adjusted_mode->vsync_end - adjusted_mode->vsync_start;
>  	u16 vact_st = adjusted_mode->vtotal - adjusted_mode->vsync_start;
>  	u16 vact_end = vact_st + vdisplay;
> +	uint32_t dither_bits = 0;
>  	uint32_t pin_pol, val;
>  	int ret;
>  
> @@ -951,10 +952,15 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
>  	    !(vop_data->feature & VOP_FEATURE_OUTPUT_RGB10))
>  		s->output_mode = ROCKCHIP_OUT_MODE_P888;
>  
> -	if (s->output_mode == ROCKCHIP_OUT_MODE_AAAA && s->output_bpc == 8)
> -		VOP_REG_SET(vop, common, pre_dither_down, 1);
> -	else
> -		VOP_REG_SET(vop, common, pre_dither_down, 0);
> +	/* dither_down includes the bit for pre_dither_down */
> +	if (s->output_bpc) { /* Only dither if bpc known. */
> +		if (s->output_mode == ROCKCHIP_OUT_MODE_AAAA && s->output_bpc <= 8)
> +			dither_bits = 0x1;
> +		/* Enable allegro dither to RGB666 */
> +		if (s->output_bpc == 6)
> +			dither_bits |= 0x6;
> +	}
> +	VOP_REG_SET(vop, common, dither_down, dither_bits);

That won't work in this form. The vops change way to much in each
iteration, so that these "bits" are not guaranteed to stay the same
order for example.

Another caveat is that the "pre_dither_down" option is even only
available on rk3288 and rk3328 and right now pre_dither_down
and dither_down options seem to overlay each other.

In the vendor-kernel they seem to have changed how they handle
dithering, including splitting up the dither-bits [0]. Sadly nobody
from Rockchip seems to have found the time to upstream any of this.

In any case, I'd suggest to get inspiration from there (including the
constants) to get dithering in mainline into a nice state.


Heiko

[0] https://github.com/rockchip-linux/kernel/blob/release-4.4/drivers/gpu/drm/rockchip/rockchip_drm_vop.c#L2547



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
