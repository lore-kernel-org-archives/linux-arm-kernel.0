Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E44C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:23:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C62412175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s4k/vpXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62412175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6+KSpzAzpy5k9W0zCyAd74Cz2mEtqb2bVKXiOdGltqQ=; b=s4k/vpXnKZsdGv
	l0JRxQVNuSDwmmbaaouSAna9l8WHFdi8PjqPK/tjEF4u1Hz1TiOXEMX5CKOfOCtYTzeu4DemOVRtL
	uNCkSvwAFuNpevulJAQMpyA1Wzk49MAatqgi+lcjnn699h8o9fzDHenejAsIBrOG4rDNYmCFaJ9q8
	OdikdEJ3QDLy7yq7tVxIV98JYo41tTo+VEMAmw6CBquqqGBAA+IxtL74ZuIO/4CtFPLZGkF+zuAiZ
	SVxpXa9gyXMigYhy2cGFAin372KtOR6W0l0cDplsSzhdAGF1PAiIgdt1jm4fkGcvJm9j50oOlYdWP
	xktnhUbPiaiB7j9yBVxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gogTY-0002VM-Mi; Wed, 30 Jan 2019 03:23:44 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gogTU-0002Uf-Ev
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 03:23:42 +0000
Received: by mail-ed1-f68.google.com with SMTP id g22so17807582edr.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 19:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mqbuc0K8afwcN4dzKlN0hjGw1R83LAgmMAbuN1jvrfM=;
 b=qW/Tg0XhnolbPYWFg48N4g30ItXYfjepcGVY+lA0niCtBWxUWPxNDo68YvEvtp5jkA
 f+z8uajLBitv+U0yxNt63JBN/O5+VGE40R2FuQzCBwOJ2ZHN5E1TUVF+RWzZxS0Spt+a
 zyxOpIxGIDs1JpLIguhmR2zCB/lAe81ypnZBp9bhtRt6p9gqIxjjvVQWGZX9qZZyOtcd
 /ryagJwiPlphKReEqCtaYen0FMAOuC0e04V5CR+ypHq4pEv5JQ2RjIkEYG8mltcxkzhL
 F6o5GkcJkuNHiK9azRA9KHDE4EtRqDaE78/RuZ0v/4LF7roZxWpeB9wmgYr248VLx/rg
 C4UQ==
X-Gm-Message-State: AJcUukf1izmkB1eESZGSvaFwgbRUM6DzpnZ6HDPvNXyPQTEmZ/GWoSfk
 JN6H1jXlYqB3pkc6dq6OiY9/BBFVZ5w=
X-Google-Smtp-Source: ALg8bN4i9eSrELU+7A2KewUkM6m8EbsScr+cW3Cv3vcvYv8FxPpzitu11beBzGq/5LNiUyJrQvi45g==
X-Received: by 2002:a50:95b4:: with SMTP id w49mr27529568eda.186.1548818617870; 
 Tue, 29 Jan 2019 19:23:37 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com.
 [209.85.128.54])
 by smtp.gmail.com with ESMTPSA id j4sm166944edh.69.2019.01.29.19.23.36
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 19:23:37 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id y139so19914776wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 19:23:36 -0800 (PST)
X-Received: by 2002:a1c:f605:: with SMTP id w5mr24508140wmc.116.1548818616523; 
 Tue, 29 Jan 2019 19:23:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.f7a136448029ab87c498d68164670712639748e7.1548236066.git-series.maxime.ripard@bootlin.com>
 <624512bb9665e0b15244c2bdf230bcfada3a3b98.1548236066.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <624512bb9665e0b15244c2bdf230bcfada3a3b98.1548236066.git-series.maxime.ripard@bootlin.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 30 Jan 2019 11:23:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v6702pRt-=SrOLqfxO5CBQT+bxFgQ6fugA=4SP_vWdqcBw@mail.gmail.com>
Message-ID: <CAGb2v6702pRt-=SrOLqfxO5CBQT+bxFgQ6fugA=4SP_vWdqcBw@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/sun4i: dsi: Change the start delay calculation
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_192340_493974_F6065D76 
X-CRM114-Status: GOOD (  24.94  )
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
Cc: bbrezillon@kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Sean Paul <seanpaul@chromium.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 23, 2019 at 11:54 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> The current calculation for the video start delay in the current DSI driver
> is that it is the total vertical size, minus the backporch and sync length,
> plus 1.
>
> However, the Allwinner code has it as the active vertical size, plus the
> back porch and the sync length. This doesn't make any difference on the
> only panel it has been tested with so far, since in that particular case
> the front porch is equal to the sum of the back porch and sync length.
>
> This is not the case for all panels, obviously, so we need to fix it. Since
> the Allwinner code has a bunch of extra code to deal with out of bounds
> values, so let's add them as well.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 380fc527a707..e3e4ba90c059 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -357,7 +357,12 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
>  static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
>                                            struct drm_display_mode *mode)
>  {
> -       return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;

According to the diagram in include/drm/drm_modes.h ,
This is active region plus back porch plus 1, as

    sync_end - display = length of front porch and sync

> +       u16 delay = (mode->vsync_end + 1) % mode->vtotal;

And this actually means

    (length of active region and front porch and sync pulse plus 1) %
total length

So I don't really understand what's happening here. And the modulus
is unexplained.

> +
> +       if (!delay)
> +               delay = 1;

Same comment as Paul.

ChenYu

> +
> +       return delay;
>  }
>
>  static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
> --
> git-series 0.9.1
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
