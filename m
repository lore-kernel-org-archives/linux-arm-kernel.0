Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AC4C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:28:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C3602084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WnIhbfpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3602084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1KvC3nxXwHsJ3lIFYHQbJicyHF9GRK42AFVT/FKXaEA=; b=WnIhbfpec9qQjw
	jmX8NYJDnT2rZqv3Qt8DEoPZhKWW4P1RhEBwBymcTxcjApAMAeQcrLM+DrogY/QzUmgGXxxzu+IqE
	Hcut97I7eKgAsAZ3NUrj/63BQVKQn3eevRsuJdjGYLHUMCqv23vHyyJCkkC/RBXKpu4nwWQAQ0UnR
	lPsqLRU+M8hkgiIlXr/kGt+38nb/I34hrJDuJhPAth1f7g9k0zRvGQFYeuigrB6KWVJHDdYQiFxzj
	NSZK2L+ED/pvNyEManpqfSb7ibPi1w9rhxpyiJqkEV4RTBwziwN5DBboA0Wac0GtWk6k9+pZnzfUV
	/lsLiSQ3ZjjGzJF/S9Aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtZzB-0006Wg-Hl; Tue, 12 Feb 2019 15:28:37 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtZyx-0006H6-Ig
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 15:28:30 +0000
Received: from aptenodytes (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: paul.kocialkowski@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id ED302200018;
 Tue, 12 Feb 2019 15:28:13 +0000 (UTC)
Message-ID: <0f3247c920d1f5ce67cc7e024125c3a4d3ca0c81.camel@bootlin.com>
Subject: Re: [PATCH v3 2/8] drm/sun4i: dsi: Change the start delay calculation
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Sean Paul <seanpaul@chromium.org>
Date: Tue, 12 Feb 2019 16:28:13 +0100
In-Reply-To: <6e5f72e68f47ca0223877464bf12f0c3f3978de8.1549896081.git-series.maxime.ripard@bootlin.com>
References: <cover.f28d9994585553a089a519392616b0d26ed54af1.1549896081.git-series.maxime.ripard@bootlin.com>
 <6e5f72e68f47ca0223877464bf12f0c3f3978de8.1549896081.git-series.maxime.ripard@bootlin.com>
Organization: Bootlin
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_072824_300111_ABE54302 
X-CRM114-Status: GOOD (  21.66  )
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

On Mon, 2019-02-11 at 15:41 +0100, Maxime Ripard wrote:
> The current calculation for the video start delay in the current DSI driver
> is that it is the total vertical size, minus the front porch and sync length,
> plus 1. This equals to the active vertical size plus the back porch plus 1.
> 
> That 1 is coming in the Allwinner BSP from an variable that is set to 1.
> However, if we look at the Allwinner BSP more closely, and especially in
> the "legacy" code for the display (in drivers/video/sunxi/legacy/), we can
> see that this variable is actually computed from the porches and the sync
> minus 10, clamped between 8 and 100.

For future reference, it look like there is a version of the BSP where
this is clamped between 8 and 31 in the legacy ebios code:
https://github.com/Icenowy/linux-kernel-lichee-a33/blob/master/drivers/video/sunxi/legacy/disp/de_bsp/de/ebios/de_dsi.c#L687

As well as in the A23 code:
https://github.com/Icenowy/linux-kernel-lichee-a33/blob/master/drivers/video/sunxi/disp/de/lowlevel_sun8iw3/de_dsi.c#L686

> This fixes the start delay symptom we've seen on some panels (vblank
> timeouts with vertical white stripes at the bottom of the panel).
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 380fc527a707..9471fa695ec7 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -357,7 +357,9 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
>  static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
>  					   struct drm_display_mode *mode)
>  {
> -	return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
> +	u16 start = clamp(mode->vtotal - mode->vdisplay - 10, 8, 100);
> +
> +	return mode->vtotal - (mode->vsync_end - mode->vdisplay) + start;

Looking at the formula from the BSP, I get a different result from
yours.

From what I can see, the BSP formula is:
start_delay = vtotal - vfp + start
vfp = vtotal - y - vbp

With vbp counting the back porch and sync length.
So the final value can be simplified:
start_delay = vbp + y + start

Translated to DRM:
start_delay = vtotal - vsync_start + vdisplay + start

Which differs from your formula by the sync length.

Does this also work out for your hardware? I guess it's best to stick
close to the BSP if we can.

Cheers,

Paul

>  }
>  
>  static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
