Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BCDC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:17:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E902147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ptPFYN5l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RZIpQrUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E902147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B7wD7p+J++d3DXDZxYqX2dQhGWM1m+Jau/MFcpx4aWY=; b=ptPFYN5lJ07smr
	PCRNbIcMF5fZ6FbY1WTvRezRG/91ulgvJ+DlcsVoG/LeBxAKkTllxG8Dd1EavrRaXzU9DaRa+lbnk
	Yx524sUH5HoCDh0iCPb7Wdz61YILs1Ej77p9FviQUsNklcSnGHrJ1dB4lQ14IVNf+Ze8Z5QmxF5PW
	e6pcFnbRgmRdDov2H4cWUIIn+eVuXdugrwg0iYrzII9hQhoTz6kw+v8uISlHYrZEprUhEM4duvmSK
	sV+ttLma1Oi2b9IP61aT5LEDOCrnU5J18kvWxOcYfekKpr8j0Qa4Man9hjhWofCZ9QRtTfxxTM3tK
	vz9chnwIwGsF12b4xdzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grfo7-0005bV-EB; Thu, 07 Feb 2019 09:17:19 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grfo0-0005WG-R6
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 09:17:16 +0000
Received: by mail-ed1-x541.google.com with SMTP id g4so293955eds.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 01:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=D9QBZ2FHmuPZ+KLix+EpnRPfwMPi5HpmHe1n2ClAHug=;
 b=RZIpQrUuI52TV7nlMpv1Nc/iugLW2tA7i1tDcFy94nR60ZLn0AZ8R/hNWJy3fovdYJ
 sG8p6TbAUTD2xx1kvCxqz1Qi+ALlSvSBjqraUVcb7UU4nOmskXcm/0txiRNcIBDP1deO
 BQsVLJSmcfyiirMGRPaxLXh8+lNlU+qHVah4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=D9QBZ2FHmuPZ+KLix+EpnRPfwMPi5HpmHe1n2ClAHug=;
 b=f2sO2SRTxr7drjuCT7IOJAfuA/uPK22nrS4G56v+fEoiTsFnfvGWZJB+PWsDpD36il
 p8TOtbg8moMNVrzdBlu8cErOIpbefTp6HzV9xi3SbVfoqhXRlQoZPEY1G00WOcLrHFon
 o+02wvlXvQ794rRGjWM19DtKIyful12281tLowCzvhfBF5T3KHT3gMUH3dusTjz/Fe9f
 d9mTiTgfGihSL0OzmtWvNuy/Zx7F2d0R0aW4AUoHDr0ZuroCJPxHKF+EJRXv0CqeqDkz
 EqDQ7ItaGCQwwQs8pJFP8eOFtHgeMVznh++pLejNoHtFynva7b3Xi3XfrAFK/6M0WkJd
 v9gQ==
X-Gm-Message-State: AHQUAubkOHRyP1Id6CxziRfdEyaOU/kclynJweI+RsVVSfAerY0E+MwO
 gHl0st8DOrt5oOJgBelxfpv4Jg==
X-Google-Smtp-Source: AHgI3Ibvc4HJlPYjM6jb3erWiCJ8iirf0Y/gmE9gidEha97Xe+W9svXyIuCfrExNr+hCEJho4WZT/w==
X-Received: by 2002:a17:906:1a0a:: with SMTP id
 i10mr1989297ejf.148.1549531029039; 
 Thu, 07 Feb 2019 01:17:09 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
 by smtp.gmail.com with ESMTPSA id x10sm6713703edb.58.2019.02.07.01.17.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 01:17:08 -0800 (PST)
Date: Thu, 7 Feb 2019 10:17:06 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] drm/simple_kms_helper: enable use of external encoder
Message-ID: <20190207091706.GQ3271@phenom.ffwll.local>
References: <20190207083647.20615-1-linus.walleij@linaro.org>
 <20190207083647.20615-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207083647.20615-2-linus.walleij@linaro.org>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_011712_975479_FD3530B0 
X-CRM114-Status: GOOD (  22.12  )
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
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 07, 2019 at 09:36:44AM +0100, Linus Walleij wrote:
> This makes it possible to pass a connector with an already
> attached external encoder into the simple KMS helper.
> 
> This is helpful for my MCDE drivers, as it is pretty simple
> but uses DSI to communicate with the displays and bridges.
> DSI requires the use of the DSI bus which in turn requires
> us to set up a custom connector from the display driver.

So the idea was that you'd just use a bridge for this, if you need more
than a dummy encoder. I'm a bit worried about mission creep for the simple
helpers, sooner or later we'll add extensions and then we're back to full
kms, except it's a hairball of classic midlayer mistake ...

See drm_simple_display_pipe_attach_bridge().

Cheers, Daniel

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpu/drm/drm_simple_kms_helper.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
> index 917812448d1b..e7499b939235 100644
> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
> @@ -266,7 +266,7 @@ int drm_simple_display_pipe_init(struct drm_device *dev,
>  			const uint64_t *format_modifiers,
>  			struct drm_connector *connector)
>  {
> -	struct drm_encoder *encoder = &pipe->encoder;
> +	struct drm_encoder *encoder;
>  	struct drm_plane *plane = &pipe->plane;
>  	struct drm_crtc *crtc = &pipe->crtc;
>  	int ret;
> @@ -289,10 +289,23 @@ int drm_simple_display_pipe_init(struct drm_device *dev,
>  	if (ret)
>  		return ret;
>  
> -	encoder->possible_crtcs = drm_crtc_mask(crtc);
> -	ret = drm_encoder_init(dev, encoder, &drm_simple_kms_encoder_funcs,
> -			       DRM_MODE_ENCODER_NONE, NULL);
> -	if (ret || !connector)
> +	/* Other encoder already attached to the connector */
> +	if (connector->encoder_ids[0] != 0) {
> +		encoder = drm_encoder_find(connector->dev, NULL,
> +					   connector->encoder_ids[0]);
> +		encoder->possible_crtcs = drm_crtc_mask(crtc);
> +		DRM_INFO("an encoder is already attached to the connector\n");
> +	} else {
> +		encoder = &pipe->encoder;
> +		encoder->possible_crtcs = drm_crtc_mask(crtc);
> +		ret = drm_encoder_init(dev, encoder,
> +				       &drm_simple_kms_encoder_funcs,
> +				       DRM_MODE_ENCODER_NONE, NULL);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (!connector)
>  		return ret;
>  
>  	return drm_connector_attach_encoder(connector, encoder);
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
