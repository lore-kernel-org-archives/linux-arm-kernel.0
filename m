Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77CDC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 19:19:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E5DA2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 19:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TXJgUv/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5DA2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bE8Hkb6X3ZOf2JQpO8W7SObd/Ljg6kCpkWrLlbgY5r4=; b=TXJgUv/fMQ2HCu
	XRkB/OuGVaDjPCfFsJn8JpELUa4LTFgdxLMhCe2Uk12vwGJKnuugMwjswJVt1ZyzVccTQeBnbW/jO
	a+hmzIqSDRNooo6quXZz3gzaIoCN8auyO33W6wKt5qvowWlP7SXxCzqygIR9gO2VAI+uBuAWJZvWa
	jmDfJIe20ElqopcjsHISEwYIFud+jZhM4eT7RfsQWwaQcnDqZNyzOpvG3zYrFCb+R2iAZB9wpUwTJ
	wAGgLsJn09RbmXujkD5TqBh4Fmiwbpj09Clh9Y2KBhKq2QbegOhG4C4vNnW8aUmwGdeWbmzU+y7hY
	fYHEJq9RE+AfgOd+BUgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnpxc-0002gu-5d; Sun, 27 Jan 2019 19:19:16 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnpxY-0002gM-2s; Sun, 27 Jan 2019 19:19:13 +0000
Received: from p5b12725f.dip0.t-ipconnect.de ([91.18.114.95]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gnpxL-0000Kp-4I; Sun, 27 Jan 2019 20:18:59 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 21/26] drm/rockchip: Use drm_fb_helper_fill_info
Date: Sun, 27 Jan 2019 20:18:58 +0100
Message-ID: <4175833.BHsNDjujy6@phil>
In-Reply-To: <20190124165831.16427-22-daniel.vetter@ffwll.ch>
References: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
 <20190124165831.16427-22-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_111912_274991_46B85A6F 
X-CRM114-Status: GOOD (  13.84  )
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
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Sandy Huang <hjc@rock-chips.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 linux-rockchip@lists.infradead.org, Daniel Vetter <daniel.vetter@intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Donnerstag, 24. Januar 2019, 17:58:26 CET schrieb Daniel Vetter:
> This will set an fb name for the first time!
> =

> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Sandy Huang <hjc@rock-chips.com>
> Cc: "Heiko St=FCbner" <heiko@sntech.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org

After looking up the rest of the series and also realizing that
fbi->par seems to be set when a client attaches to the fb,
this looks good to me, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> =

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c b/drivers/gpu/=
drm/rockchip/rockchip_drm_fbdev.c
> index 7bd3b89022be..d12164878e05 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
> @@ -90,13 +90,11 @@ static int rockchip_drm_fbdev_create(struct drm_fb_he=
lper *helper,
>  		goto out;
>  	}
>  =

> -	fbi->par =3D helper;
>  	fbi->flags =3D FBINFO_FLAG_DEFAULT;
>  	fbi->fbops =3D &rockchip_drm_fbdev_ops;
>  =

>  	fb =3D helper->fb;
> -	drm_fb_helper_fill_fix(fbi, fb->pitches[0], fb->format->depth);
> -	drm_fb_helper_fill_var(fbi, helper, sizes->fb_width, sizes->fb_height);
> +	drm_fb_helper_fill_info(fbi, helper);
>  =

>  	offset =3D fbi->var.xoffset * bytes_per_pixel;
>  	offset +=3D fbi->var.yoffset * fb->pitches[0];
> =






_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
