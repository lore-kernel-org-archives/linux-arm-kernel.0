Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B7CC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:48:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B9A22080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DzROHslw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9A22080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=24ruR5I9xSX4iSVjwpATZxKfx0yGJPgsxvYyq72Cxs0=; b=DzROHslwRPn145
	Lv+c544y3FTYQBqw6r2Y1auPqjYYbBzwsg+9fYDEC9f3cqKFFSRzXy5CYXDIVC8JcPjNoSnUoe8cp
	vrU0KCjza1/GQG549JEgtxlFD0fGRTvdZ7bwCh7qcQiuUaP5TnTMMcVFVaQcUhrIXS0GmPzcqoJfz
	/1Megn/ZZzy3kdLtURE/gQ3q/fnBN4UL9rCJa8t2SxuzV33UVJthSaxPcVt3PkhQ5jdbXnpm3vBZs
	tKcxN1XW9HVaaFfLYaCxdwqUVTxxNfPMBx+M5ky01Ma2qWEFHjsIbW0MhYpxRdzGYdpvq1Zg55mvn
	w8Ao8UloQgIzZqApPa8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr3tq-0003ZC-8V; Tue, 05 Feb 2019 16:48:42 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr3tm-0003Ys-6a
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 16:48:40 +0000
Received: by mail-ed1-f67.google.com with SMTP id o10so3381468edt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 08:48:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DjdOsJcV5AkbRiOCkbN5HDGNBdWxBwEz3rrOfCwE3Rw=;
 b=q+DvZUE7UMnVqZm2i/CSO706KYi3AC5vEK8UV+ePe6IBrBIB/AfmcnY9Zt9Z2LH1QX
 bEHJ+zhceFX5MLCPUvr/x0LpBYkmLXAiLSPu5ZKkkxD688LzIWTQkaYO/uv2MsWEuuAr
 RaKs91MRnzKD8lUGVWeJQfwoaFDXwGw5DQ6Kk84cFghMGXe5EkAb2pY88A77xBROpRqo
 S6Vp/3aoF8mQKgYezof6PaL/1W0tAksWQ6CZLjqvjE0Pca5nBQXE36iFmhjuEujAQeyo
 Tio9mMUHIzsFqM9v55+yB26IkljUvP9gNH8FU/OL1tMhYniR+0D+34h/Jo1hFCChJdft
 Rk6Q==
X-Gm-Message-State: AHQUAuYQRvHsypu8wA+rIi8xEVw5nbJIPMooD1v09cXYQB4S9C2s2o0T
 ao+hQQhY8vSKSjCUa4FADzfGhAGfjak=
X-Google-Smtp-Source: AHgI3IbbXLdx+efIy27LNpMqnqLNxFmVR3qpzuJIiF30hvlr9xWAYTVKpqxXO/dnabg6YVM6TbZfvg==
X-Received: by 2002:a17:906:24da:: with SMTP id
 f26mr4311182ejb.136.1549385315643; 
 Tue, 05 Feb 2019 08:48:35 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com.
 [209.85.128.44])
 by smtp.gmail.com with ESMTPSA id f34sm499994eda.22.2019.02.05.08.48.34
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 08:48:35 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id g67so4426183wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 08:48:34 -0800 (PST)
X-Received: by 2002:a1c:c008:: with SMTP id q8mr4060725wmf.99.1549385314525;
 Tue, 05 Feb 2019 08:48:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.f7a136448029ab87c498d68164670712639748e7.1548236066.git-series.maxime.ripard@bootlin.com>
 <624512bb9665e0b15244c2bdf230bcfada3a3b98.1548236066.git-series.maxime.ripard@bootlin.com>
 <CAGb2v6702pRt-=SrOLqfxO5CBQT+bxFgQ6fugA=4SP_vWdqcBw@mail.gmail.com>
In-Reply-To: <CAGb2v6702pRt-=SrOLqfxO5CBQT+bxFgQ6fugA=4SP_vWdqcBw@mail.gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 6 Feb 2019 00:48:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v66h67zmGB9jZ4QxUN1mU-pZy4kPRzvSxu1ECOi4SqETUA@mail.gmail.com>
Message-ID: <CAGb2v66h67zmGB9jZ4QxUN1mU-pZy4kPRzvSxu1ECOi4SqETUA@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/sun4i: dsi: Change the start delay calculation
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_084838_254506_6B095F99 
X-CRM114-Status: GOOD (  29.08  )
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

On Wed, Jan 30, 2019 at 11:23 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Wed, Jan 23, 2019 at 11:54 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > The current calculation for the video start delay in the current DSI driver
> > is that it is the total vertical size, minus the backporch and sync length,
> > plus 1.
> >
> > However, the Allwinner code has it as the active vertical size, plus the
> > back porch and the sync length. This doesn't make any difference on the
> > only panel it has been tested with so far, since in that particular case
> > the front porch is equal to the sum of the back porch and sync length.
> >
> > This is not the case for all panels, obviously, so we need to fix it. Since
> > the Allwinner code has a bunch of extra code to deal with out of bounds
> > values, so let's add them as well.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index 380fc527a707..e3e4ba90c059 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -357,7 +357,12 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
> >  static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
> >                                            struct drm_display_mode *mode)
> >  {
> > -       return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
>
> According to the diagram in include/drm/drm_modes.h ,
> This is active region plus back porch plus 1, as
>
>     sync_end - display = length of front porch and sync
>
> > +       u16 delay = (mode->vsync_end + 1) % mode->vtotal;
>
> And this actually means
>
>     (length of active region and front porch and sync pulse plus 1) %
> total length
>
> So I don't really understand what's happening here. And the modulus
> is unexplained.

Attempting to make sense of this. Allwinner's A64 BSP the following
which uses their definitions for y, vbp, vt:

    s32 start_delay = panel->lcd_vt - panel->lcd_y -10;
    u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
    u32 dsi_start_delay;

    /* put start_delay to tcon. set ready sync early to dramfreq, so
set start_delay 1 */
    start_delay = 1;

    dsi_start_delay = panel->lcd_vt - vfp + start_delay;
    if (dsi_start_delay > panel->lcd_vt)
           dsi_start_delay -= panel->lcd_vt;
    if (dsi_start_delay==0)
           dsi_start_delay = 1;

This can be converted to

    dsi_start_delay = max(1, (mode->vtotal - (mode->vtotal -
mode->vdisplay - (mode->vtotal - mode->vsync_start)) + 1) %
mode->vtotal)

and simplified to

    dsi_start_delay = max(1, (mode->vtotal + mode->vdisplay -
mode->vsync_start) + 1) % mode->vtotal)

and reordered to the following

    dsi_start_delay = max(1, (mode->vtotal - (mode->vsync_start -
mode->vdisplay) + 1) % mode->vtotal)

which means total length minus front porch, or length of active
portion plus back porch plus sync.
Based on your commit message, the last derivation is what you want.

ChenYu

> > +
> > +       if (!delay)
> > +               delay = 1;
>
> Same comment as Paul.
>
> ChenYu
>
> > +
> > +       return delay;
> >  }
> >
> >  static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
> > --
> > git-series 0.9.1
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
