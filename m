Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF37C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:40:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA0121473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N8nqKE/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA0121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q4t8cNObOoHQFNyCR1ecN6Gj/e7J+dgXZdfCg6P5aXI=; b=N8nqKE/Fp//GHm
	uya3IUxSQor3Z7p0LaljzIxaRAdP43pK6d1lLn0X9Riq6yStHLL+stEhFEY+Jmc2/dRIruLv5qN8q
	4DpvmHw0cmOMKForp/7u/hIrVVpK583j1K+DjLYWXWLgslFs89ytXRSbbZ4Iqh6eI+vyc2aenQlo3
	ubglv+Yfz6coxRoO1U2ZVjeAyYOL4b5xxvQ8+0YKzJX2l6UtzVegjQUzs/d7O//vqtM+Z/T/o3/8i
	LE/3vJkjprhWtqMGCnXRGv89h45bj5Oq4BUm7cdh68EY9qY8PisgAwnesEg9BJoIzUr0zZCcqszHK
	9ZnFyDw5IM33FltrV53A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goVUg-0005xH-Ek; Tue, 29 Jan 2019 15:40:10 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goVUd-00053c-DC
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 15:40:09 +0000
X-Originating-IP: 90.88.147.226
Received: from aptenodytes (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr
 [90.88.147.226])
 (Authenticated sender: paul.kocialkowski@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A74F1E0013;
 Tue, 29 Jan 2019 15:39:53 +0000 (UTC)
Message-ID: <5ca088ece86f8ee6033d481c7f9e86128fc5e355.camel@bootlin.com>
Subject: Re: [PATCH 1/4] drm/sun4i: dsi: Restrict DSI tcon clock divider
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Sean Paul <seanpaul@chromium.org>
Date: Tue, 29 Jan 2019 16:39:53 +0100
In-Reply-To: <92e4e5f4c58c8c1a439e93614fdcd8bad6823358.1548236066.git-series.maxime.ripard@bootlin.com>
References: <cover.f7a136448029ab87c498d68164670712639748e7.1548236066.git-series.maxime.ripard@bootlin.com>
 <92e4e5f4c58c8c1a439e93614fdcd8bad6823358.1548236066.git-series.maxime.ripard@bootlin.com>
Organization: Bootlin
User-Agent: Evolution 3.30.4 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_074007_648369_9B0D21BD 
X-CRM114-Status: GOOD (  16.02  )
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
Cc: bbrezillon@kernel.org, dri-devel@lists.freedesktop.org,
 Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, 2019-01-23 at 16:54 +0100, Maxime Ripard wrote:
> The current code allows the TCON clock divider to have a range between 4
> and 127 when feeding the DSI controller.
> 
> The only display supported so far had a display clock rate that ended up
> using a divider of 4, but testing with other displays show that only 4
> seems to be functional.
> 
> This also aligns with what Allwinner is doing in their BSP, so let's just
> hardcode that we want a divider of 4 when using the DSI output.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c     | 4 ++--
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 0420f5c978b9..bee73ead732a 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -341,8 +341,8 @@ static void sun4i_tcon0_mode_set_cpu(struct sun4i_tcon *tcon,
>  	u32 block_space, start_delay;
>  	u32 tcon_div;
>  
> -	tcon->dclk_min_div = 4;
> -	tcon->dclk_max_div = 127;
> +	tcon->dclk_min_div = SUN6I_DSI_TCON_DIV;
> +	tcon->dclk_max_div = SUN6I_DSI_TCON_DIV;
>  
>  	sun4i_tcon0_mode_set_common(tcon, mode);
>  
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> index dbbc5b3ecbda..6d4a3c0fd9b5 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> @@ -13,6 +13,8 @@
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_mipi_dsi.h>
>  
> +#define SUN6I_DSI_TCON_DIV	4
> +
>  struct sun6i_dphy {
>  	struct clk		*bus_clk;
>  	struct clk		*mod_clk;
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
