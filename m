Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB575C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:33:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72764205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cBj6TAMX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="EblUqcEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72764205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IfnoxaGGD6ihOfL4R2ZV35Tyc07gIjCmUCTbbAAW5U0=; b=cBj6TAMXye6eyZ
	GbVqFpobYhjPVRKvRhPmCnJLC93ZJv9b25jZP6oYUj6s1aSFstabckTg+vjjpz8nBm0T+oBbSOIIO
	yYj0Ogn+mq8GYyjFAsyhs8z5y+O1x9OlbKE3R72LhBz5T++dTBxz0V1N2Xavv4rqRg+gIE2ad9Wb3
	O90bZHOVn14B6LWMm9SZMiTOolzb4zB6gjVpQlvrgNrmgaD6wdYu6OzLvOWnl1uWp30t2exh6Kwyv
	BYbcAY9VfQCli88w2X6oRCL1o14Ddh/7ru6nhsQVIvBCSHg5DUbC3GA/3PQaQEKkR9ODSIExiRMex
	az5nSpVU27fmof0SZwSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk7nl-0005QV-PA; Thu, 17 Jan 2019 13:33:45 +0000
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk7nh-0005Pt-Mt
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 13:33:43 +0000
Received: by mail-yb1-xb44.google.com with SMTP id i6so2987734ybo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 05:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poorly.run; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ZRARg234UQKVSq41AjrEKQ+5c7yzrHeZ4hw/irAy5ws=;
 b=EblUqcEo9Li6sgfPoEh51lq1Jqin+oA5kUE4ILCnsCbpILc4POXuGzeu30FhnSWnbf
 z152M8Gzb7N0KujOIMTmtk7vfgWlQw4fubXLZVTO54jymDytkpKAsV3v3EElByiriGRK
 MnwYZmoVXORtw6t55zhdD6jI9MJG4IEGe69TPujKF1Xk3VZdRrEwa8jMUCX0rpg2qG9l
 fYUVcu4GODzWIGjKUYb8zihTvNbwrbuE1oNYiX1ZMTEkt07xG6yLSZ4YajqTpfJvbw//
 WSP7RxXwUEqTsw0CyJNkWmB9LaGk6rEScM5ghsJaP4Vs+Y8+Ujp9PCAe2PgTF/lfcMSJ
 X5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZRARg234UQKVSq41AjrEKQ+5c7yzrHeZ4hw/irAy5ws=;
 b=lwytPwu1zzLnxsCZwBt1+ERgLgWYYqpjBCPzn0f/1ZoatfuWfiuFcQnO5eauyVyOtN
 5z5idmX+l2iirTDgDDjwrnXk/pVd6UMKO5vIpZu4JL/1Bgj7z0zGTQuWzBDzJt/QZei7
 VKF8VXXDiUv/T4DIPIBaFOlm3ehJKVQ2fd6lzRGNlccXFjzwANwmBH/uReJ1bnxYH1gH
 ikhiXcZ4To4w9rGNkVUSAqmkBP9fsJiyq+v77ormlckEryom1Ob2/q1BBSpEWaJfJLbO
 mRRg5Q6lIcsPnjxTpwOCo3c42l3MtpRCfDddRoYpLLzrvnYCfffQlB4g4mnD00+YIvtb
 eP/w==
X-Gm-Message-State: AJcUukf6j9gN1VGMczRYPCcX8pbGSvMB09IrdbhKqSK4ToZG03Bq+syc
 30FeAiNvpwA1vCS0gFHPmuNP7w==
X-Google-Smtp-Source: ALg8bN596NMzviejCC9J+HUnvsbq2QQ3OqR5yiZfa9Y/HY6VdbT0dLYoeqosR52sBeAmv1/J4kgnsg==
X-Received: by 2002:a25:4cc4:: with SMTP id z187mr9886470yba.121.1547732020037; 
 Thu, 17 Jan 2019 05:33:40 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
 by smtp.gmail.com with ESMTPSA id k64sm656400ywc.56.2019.01.17.05.33.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Jan 2019 05:33:39 -0800 (PST)
Date: Thu, 17 Jan 2019 08:33:38 -0500
From: Sean Paul <sean@poorly.run>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v4 6/9] drm/bridge: cdns: Separate DSI and D-PHY
 configuration
Message-ID: <20190117133338.GA114153@art_vandelay>
References: <cover.5d91ef683e3f432342f536e0f2fe239dbcebcb3e.1547026369.git-series.maxime.ripard@bootlin.com>
 <df619f059617d85c00efa146884e295240a07ae7.1547026369.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <df619f059617d85c00efa146884e295240a07ae7.1547026369.git-series.maxime.ripard@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_053341_811633_0924C18D 
X-CRM114-Status: GOOD (  23.80  )
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
Cc: Archit Taneja <architt@codeaurora.org>, Rafal Ciepiela <rafalc@cadence.com>,
 Krzysztof Witos <kwitos@cadence.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Kishon Vijay Abraham I <kishon@ti.com>,
 Andrzej Hajda <a.hajda@samsung.com>, Chen-Yu Tsai <wens@csie.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 09, 2019 at 10:33:23AM +0100, Maxime Ripard wrote:
> The current configuration of the DSI bridge and its associated D-PHY is
> intertwined. In order to ease the future conversion to the phy framework
> for the D-PHY part, let's split the configuration in two.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/cdns-dsi.c | 96 ++++++++++++++++++++++----------
>  1 file changed, 68 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
> index ce9496d13986..3ac6dd524b6d 100644
> --- a/drivers/gpu/drm/bridge/cdns-dsi.c
> +++ b/drivers/gpu/drm/bridge/cdns-dsi.c
> @@ -545,6 +545,11 @@ bridge_to_cdns_dsi_input(struct drm_bridge *bridge)
>  	return container_of(bridge, struct cdns_dsi_input, bridge);
>  }
>  
> +static unsigned int mode_to_dpi_hfp(const struct drm_display_mode *mode)
> +{
> +	return mode->crtc_hsync_start - mode->crtc_hdisplay;
> +}
> +
>  static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
>  				     struct cdns_dphy_cfg *cfg,
>  				     unsigned int dpi_htotal,
> @@ -731,14 +736,12 @@ static unsigned int dpi_to_dsi_timing(unsigned int dpi_timing,
>  static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
>  			     const struct drm_display_mode *mode,
>  			     struct cdns_dsi_cfg *dsi_cfg,
> -			     struct cdns_dphy_cfg *dphy_cfg,
>  			     bool mode_valid_check)
>  {
> -	unsigned long dsi_htotal = 0, dsi_hss_hsa_hse_hbp = 0;
>  	struct cdns_dsi_output *output = &dsi->output;
> -	unsigned int dsi_hfp_ext = 0, dpi_hfp, tmp;
> +	unsigned int tmp;
>  	bool sync_pulse = false;
> -	int bpp, nlanes, ret;
> +	int bpp, nlanes;
>  
>  	memset(dsi_cfg, 0, sizeof(*dsi_cfg));
>  
> @@ -757,8 +760,6 @@ static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
>  		       mode->crtc_hsync_end : mode->crtc_hsync_start);
>  
>  	dsi_cfg->hbp = dpi_to_dsi_timing(tmp, bpp, DSI_HBP_FRAME_OVERHEAD);
> -	dsi_htotal += dsi_cfg->hbp + DSI_HBP_FRAME_OVERHEAD;
> -	dsi_hss_hsa_hse_hbp += dsi_cfg->hbp + DSI_HBP_FRAME_OVERHEAD;
>  
>  	if (sync_pulse) {
>  		if (mode_valid_check)
> @@ -768,49 +769,90 @@ static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
>  
>  		dsi_cfg->hsa = dpi_to_dsi_timing(tmp, bpp,
>  						 DSI_HSA_FRAME_OVERHEAD);
> -		dsi_htotal += dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
> -		dsi_hss_hsa_hse_hbp += dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
>  	}
>  
>  	dsi_cfg->hact = dpi_to_dsi_timing(mode_valid_check ?
>  					  mode->hdisplay : mode->crtc_hdisplay,
>  					  bpp, 0);
> -	dsi_htotal += dsi_cfg->hact;
> +	dsi_cfg->hfp = dpi_to_dsi_timing(mode_to_dpi_hfp(mode), bpp,
> +					 DSI_HFP_FRAME_OVERHEAD);

We're throwing away the mode_valid_check switch here to flip between crtc_h*
value and h* value. Is that intentional? We're using it above for hdisplay, so
it's a bit confusing.

>  
> -	if (mode_valid_check)
> -		dpi_hfp = mode->hsync_start - mode->hdisplay;
> -	else
> -		dpi_hfp = mode->crtc_hsync_start - mode->crtc_hdisplay;
> +	return 0;
> +}
> +
> +static int cdns_dphy_validate(struct cdns_dsi *dsi,
> +			      struct cdns_dsi_cfg *dsi_cfg,
> +			      struct cdns_dphy_cfg *dphy_cfg,
> +			      const struct drm_display_mode *mode,
> +			      bool mode_valid_check)
> +{
> +	struct cdns_dsi_output *output = &dsi->output;
> +	unsigned long dsi_htotal;
> +	unsigned int dsi_hfp_ext = 0;
> +
> +	int ret;
>  
> -	dsi_cfg->hfp = dpi_to_dsi_timing(dpi_hfp, bpp, DSI_HFP_FRAME_OVERHEAD);
> +	dsi_htotal = dsi_cfg->hbp + DSI_HBP_FRAME_OVERHEAD;
> +	if (output->dev->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
> +		dsi_htotal += dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
> +
> +	dsi_htotal += dsi_cfg->hact;
>  	dsi_htotal += dsi_cfg->hfp + DSI_HFP_FRAME_OVERHEAD;
>  
>  	if (mode_valid_check)
>  		ret = cdns_dsi_get_dphy_pll_cfg(dsi->dphy, dphy_cfg,
> -						mode->htotal, bpp,
> +						mode->htotal,
>  						mode->clock * 1000,
> -						dsi_htotal, nlanes,
> +						mipi_dsi_pixel_format_to_bpp(output->dev->format),
> +						dsi_htotal,
> +						output->dev->lanes,
>  						&dsi_hfp_ext);
>  	else
>  		ret = cdns_dsi_get_dphy_pll_cfg(dsi->dphy, dphy_cfg,
> -						mode->crtc_htotal, bpp,
> +						mode->crtc_htotal,
> +						mipi_dsi_pixel_format_to_bpp(output->dev->format),
>  						mode->crtc_clock * 1000,
> -						dsi_htotal, nlanes,
> +						dsi_htotal,
> +						output->dev->lanes,
>  						&dsi_hfp_ext);
> -
>  	if (ret)
>  		return ret;
>  
>  	dsi_cfg->hfp += dsi_hfp_ext;
> -	dsi_htotal += dsi_hfp_ext;
> -	dsi_cfg->htotal = dsi_htotal;
> +	dsi_cfg->htotal = dsi_htotal + dsi_hfp_ext;
> +
> +	return 0;
> +}
> +
> +static int cdns_dsi_check_conf(struct cdns_dsi *dsi,
> +			       const struct drm_display_mode *mode,
> +			       struct cdns_dsi_cfg *dsi_cfg,
> +			       struct cdns_dphy_cfg *dphy_cfg,
> +			       bool mode_valid_check)
> +{
> +	struct cdns_dsi_output *output = &dsi->output;
> +	unsigned long dsi_hss_hsa_hse_hbp;
> +	unsigned int nlanes = output->dev->lanes;
> +	int ret;
> +
> +	ret = cdns_dsi_mode2cfg(dsi, mode, dsi_cfg, mode_valid_check);
> +	if (ret)
> +		return ret;
> +
> +	ret = cdns_dphy_validate(dsi, dsi_cfg, dphy_cfg, mode, mode_valid_check);
> +	if (ret)
> +		return ret;
> +
> +	dsi_hss_hsa_hse_hbp = dsi_cfg->hbp + DSI_HBP_FRAME_OVERHEAD;
> +	if (output->dev->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
> +		dsi_hss_hsa_hse_hbp += dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
>  
>  	/*
>  	 * Make sure DPI(HFP) > DSI(HSS+HSA+HSE+HBP) to guarantee that the FIFO
>  	 * is empty before we start a receiving a new line on the DPI
>  	 * interface.
>  	 */
> -	if ((u64)dphy_cfg->lane_bps * dpi_hfp * nlanes <
> +	if ((u64)dphy_cfg->lane_bps * mode_to_dpi_hfp(mode) * nlanes <
>  	    (u64)dsi_hss_hsa_hse_hbp *
>  	    (mode_valid_check ? mode->clock : mode->crtc_clock) * 1000)
>  		return -EINVAL;
> @@ -842,7 +884,7 @@ cdns_dsi_bridge_mode_valid(struct drm_bridge *bridge,
>  	struct cdns_dsi_output *output = &dsi->output;
>  	struct cdns_dphy_cfg dphy_cfg;
>  	struct cdns_dsi_cfg dsi_cfg;
> -	int bpp, nlanes, ret;
> +	int bpp, ret;
>  
>  	/*
>  	 * VFP_DSI should be less than VFP_DPI and VFP_DSI should be at
> @@ -860,11 +902,9 @@ cdns_dsi_bridge_mode_valid(struct drm_bridge *bridge,
>  	if ((mode->hdisplay * bpp) % 32)
>  		return MODE_H_ILLEGAL;
>  
> -	nlanes = output->dev->lanes;
> -
> -	ret = cdns_dsi_mode2cfg(dsi, mode, &dsi_cfg, &dphy_cfg, true);
> +	ret = cdns_dsi_check_conf(dsi, mode, &dsi_cfg, &dphy_cfg, true);
>  	if (ret)
> -		return MODE_CLOCK_RANGE;
> +		return MODE_BAD;
>  
>  	return MODE_OK;
>  }
> @@ -990,7 +1030,7 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
>  	bpp = mipi_dsi_pixel_format_to_bpp(output->dev->format);
>  	nlanes = output->dev->lanes;
>  
> -	WARN_ON_ONCE(cdns_dsi_mode2cfg(dsi, mode, &dsi_cfg, &dphy_cfg, false));
> +	WARN_ON_ONCE(cdns_dsi_check_conf(dsi, mode, &dsi_cfg, &dphy_cfg, false));
>  
>  	cdns_dsi_hs_init(dsi, &dphy_cfg);
>  	cdns_dsi_init_link(dsi);
> -- 
> git-series 0.9.1

-- 
Sean Paul, Software Engineer, Google / Chromium OS

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
