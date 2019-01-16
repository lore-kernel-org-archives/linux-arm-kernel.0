Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352DCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:36:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007F620859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S6SmpuEP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZZVX/NA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007F620859
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=79mDPzTAe/sX1iIfH2QCGfM5TF5QBe12ZIGzZr4QKZk=; b=S6SmpuEPjcYmWD
	NB0i4zj6TGp2gGp//c06cq15098YYNytkwcrOOqDaLl7pvwbKV4U2E9hW3EUhfIR1xn8JcmirxCE1
	E/aJ7Kw/fiskLmcSdNxgpNA8dlEf6c2zXqPSu8G5gbZlJLlZeneBPpmUa1IeV4AzO37TcyPBMW1G6
	tG+AAgdtmBbcqwK2S3gGvXzdN2/MAgXh9Dv6ngTNHDN1eRRxdoQJlU66nOJyyMz0wRD5rjBEWGy8x
	sR1smDJ9qvGmhCC6O/FzyPhPkJ1SW2cL/BF2RS28S2LE+A/cl8ruaxXamTjNeqDDVq8cuUmKNTozc
	+Lq0lMBVvAf3+tYcUAUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjggq-00046e-9U; Wed, 16 Jan 2019 08:36:48 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjggm-00046C-O4
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 08:36:46 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0G8aUv9006989;
 Wed, 16 Jan 2019 02:36:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547627790;
 bh=rQCLzBuk+zHc6xIAfnZUMjVNTxox6aVRhSKyrxLQoTA=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=ZZVX/NA+laEJI9Yf5eRDJuMiKWmh33jOJ00Sen+GwUkIIYyFB8UCkrVJkGNlJqIlw
 rmmbp49tjYRzNgFobGrmw68T/sa3OCRsYDy4SGKfIfJX2zMhS3+7qpPpJ/3RArxi2q
 2oGWjbxp9AmpAPY8zK9sZstzuI8WD1SarSu0FX0s=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0G8aUDr069007
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Jan 2019 02:36:30 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 02:36:30 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 02:36:30 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0G8aQ0M015337;
 Wed, 16 Jan 2019 02:36:27 -0600
Subject: Re: [PATCH v4 6/9] drm/bridge: cdns: Separate DSI and D-PHY
 configuration
To: Maxime Ripard <maxime.ripard@bootlin.com>
References: <cover.5d91ef683e3f432342f536e0f2fe239dbcebcb3e.1547026369.git-series.maxime.ripard@bootlin.com>
 <df619f059617d85c00efa146884e295240a07ae7.1547026369.git-series.maxime.ripard@bootlin.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a37a8c64-06b4-559f-e39a-d2d567239e62@ti.com>
Date: Wed, 16 Jan 2019 14:06:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <df619f059617d85c00efa146884e295240a07ae7.1547026369.git-series.maxime.ripard@bootlin.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_003644_866946_F6867EF1 
X-CRM114-Status: GOOD (  27.84  )
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
 dri-devel@lists.freedesktop.org, Andrzej Hajda <a.hajda@samsung.com>,
 Chen-Yu Tsai <wens@csie.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Maxime,

On 09/01/19 3:03 PM, Maxime Ripard wrote:
> The current configuration of the DSI bridge and its associated D-PHY is
> intertwined. In order to ease the future conversion to the phy framework
> for the D-PHY part, let's split the configuration in two.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Can we get Ack from DRM MAINTAINERS?

Thanks
Kishon
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
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
