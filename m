Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22529C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:37:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E322E222B2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uMCcD495"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E322E222B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PwQs0xoon/ZRJRRx+OylSNRKD1xwIOgbh6JSqmIBQ0w=; b=uMCcD495YlyEha
	ytzqEGbdvJ/7eeJfnl/EaLJ9FtqNaodTVAD8d57KaF02t53hAsvfstzhTZAscDlJr0L4LKMqAqKuo
	WnKmF+ey33IVPFpCUkk/20aY6OxLN20viX/Fm8Y6UHgTsB2xTcMU1i6Dsu28H34XcC0BWh0NFLnxb
	zv3cGcMkzIHlb95BkvPEdUyRzzzS2AGm2TKv6BBZt3dxnU4CTAS++igayNLpoYIqKaWwq2rXDL+oF
	skDxQ0rXJ2y6iRQ5Yhi2baHlLPhLTscVbJ/dq+aFbCZjkiTqWOaL7fJHvSgpwSFbfYh8eQbVYbF3d
	o7dG1el4iTidVqjoAnFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtves-0000E5-3Y; Wed, 13 Feb 2019 14:37:06 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtvei-0008R4-Pa
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 14:37:01 +0000
X-Originating-IP: 90.88.30.68
Received: from aptenodytes (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: paul.kocialkowski@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 5603BFF807;
 Wed, 13 Feb 2019 14:36:49 +0000 (UTC)
Message-ID: <ec69feeda5ec2b09f87c81b555f664e562276803.camel@bootlin.com>
Subject: Re: [PATCH v3 7/8] drm/sun4i: dsi: Add burst support
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Sean Paul <seanpaul@chromium.org>
Date: Wed, 13 Feb 2019 15:36:48 +0100
In-Reply-To: <1dcabf2b38d3f0d3387b1cf02575e3d14e3ecd4e.1549896081.git-series.maxime.ripard@bootlin.com>
References: <cover.f28d9994585553a089a519392616b0d26ed54af1.1549896081.git-series.maxime.ripard@bootlin.com>
 <1dcabf2b38d3f0d3387b1cf02575e3d14e3ecd4e.1549896081.git-series.maxime.ripard@bootlin.com>
Organization: Bootlin
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_063657_426477_73FCBD41 
X-CRM114-Status: GOOD (  21.75  )
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
Cc: Konstantin Sudakov <k.sudakov@integrasources.com>, bbrezillon@kernel.org,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Mon, 2019-02-11 at 15:41 +0100, Maxime Ripard wrote:
> From: Konstantin Sudakov <k.sudakov@integrasources.com>
> 
> The current driver doesn't support the DSI burst operation mode.
> 
> Let's add the needed quirks to make it work.
> 
> Signed-off-by: Konstantin Sudakov <k.sudakov@integrasources.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 171 ++++++++++++++++++++------
>  1 file changed, 132 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index e0288e7dc64e..4cb715dc9100 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c

[...]

> @@ -457,52 +531,71 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
>  	struct mipi_dsi_device *device = dsi->device;
>  	unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
>  	u16 hbp, hfp, hsa, hblk, vblk;
> +	u32 basic_ctl = 0;
>  	size_t bytes;
>  	u8 *buffer;
>  
>  	/* Do all timing calculations up front to allocate buffer space */
>  
> -	/*
> -	 * A sync period is composed of a blanking packet (4 bytes +
> -	 * payload + 2 bytes) and a sync event packet (4 bytes). Its
> -	 * minimal size is therefore 10 bytes
> -	 */
> +	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> +		hsa = 0;
> +		hbp = 0;
> +		hfp = 0;
> +		hblk = mode->hdisplay * Bpp;
> +		vblk = 0;

It looks a bit strange to zero these variables here while basic_ctl is
initialized to zero when declared. I think it would be more consistent
to have these variables set to zero in the same fashion.

With that fixed:

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> +		basic_ctl = SUN6I_DSI_BASIC_CTL_VIDEO_BURST |
> +			    SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS |
> +			    SUN6I_DSI_BASIC_CTL_HBP_DIS;
> +
> +		if (device->lanes == 4)
> +			basic_ctl |= SUN6I_DSI_BASIC_CTL_TRAIL_FILL |
> +				     SUN6I_DSI_BASIC_CTL_TRAIL_INV(0xc);
> +	} else {
> +		/*
> +		 * A sync period is composed of a blanking packet (4
> +		 * bytes + payload + 2 bytes) and a sync event packet
> +		 * (4 bytes). Its minimal size is therefore 10 bytes
> +		 */
>  #define HSA_PACKET_OVERHEAD	10
> -	hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
> -		  (mode->hsync_end - mode->hsync_start) * Bpp - HSA_PACKET_OVERHEAD);
> -
> -	/*
> -	 * The backporch is set using a blanking packet (4 bytes +
> -	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
> -	 */
> +		hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
> +			  (mode->hsync_end - mode->hsync_start) * Bpp - HSA_PACKET_OVERHEAD);
> +
> +		/*
> +		 * The backporch is set using a blanking packet (4
> +		 * bytes + payload + 2 bytes). Its minimal size is
> +		 * therefore 6 bytes
> +		 */
>  #define HBP_PACKET_OVERHEAD	6
> -	hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
> -		  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
> -
> -	/*
> -	 * The frontporch is set using a blanking packet (4 bytes +
> -	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
> -	 */
> +		hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
> +			  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
> +
> +		/*
> +		 * The frontporch is set using a blanking packet (4
> +		 * bytes + payload + 2 bytes). Its minimal size is
> +		 * therefore 6 bytes
> +		 */
>  #define HFP_PACKET_OVERHEAD	6
> -	hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
> -		  (mode->hsync_start - mode->hdisplay) * Bpp - HFP_PACKET_OVERHEAD);
> -
> -	/*
> -	 * The blanking is set using a sync event (4 bytes) and a
> -	 * blanking packet (4 bytes + payload + 2 bytes). Its minimal
> -	 * size is therefore 10 bytes.
> -	 */
> +		hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
> +			  (mode->hsync_start - mode->hdisplay) * Bpp - HFP_PACKET_OVERHEAD);
> +
> +		/*
> +		 * The blanking is set using a sync event (4 bytes)
> +		 * and a blanking packet (4 bytes + payload + 2
> +		 * bytes). Its minimal size is therefore 10 bytes.
> +		 */
>  #define HBLK_PACKET_OVERHEAD	10
> -	hblk = max((unsigned int)HBLK_PACKET_OVERHEAD,
> -		   (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp - HBLK_PACKET_OVERHEAD);
> -
> -	/*
> -	 * And I'm not entirely sure what vblk is about. The driver in
> -	 * Allwinner BSP is using a rather convoluted calculation
> -	 * there only for 4 lanes. However, using 0 (the !4 lanes
> -	 * case) even with a 4 lanes screen seems to work...
> -	 */
> -	vblk = 0;
> +		hblk = max((unsigned int)HBLK_PACKET_OVERHEAD,
> +			   (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp -
> +			   HBLK_PACKET_OVERHEAD);
> +
> +		/*
> +		 * And I'm not entirely sure what vblk is about. The driver in
> +		 * Allwinner BSP is using a rather convoluted calculation
> +		 * there only for 4 lanes. However, using 0 (the !4 lanes
> +		 * case) even with a 4 lanes screen seems to work...
> +		 */
> +		vblk = 0;
> +	}
>  
>  	/* How many bytes do we need to send all payloads? */
>  	bytes = max_t(size_t, max(max(hfp, hblk), max(hsa, hbp)), vblk);
> @@ -510,7 +603,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
>  	if (WARN_ON(!buffer))
>  		return;
>  
> -	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, 0);
> +	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, basic_ctl);
>  
>  	regmap_write(dsi->regs, SUN6I_DSI_SYNC_HSS_REG,
>  		     sun6i_dsi_build_sync_pkt(MIPI_DSI_H_SYNC_START,
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
