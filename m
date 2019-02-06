Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEA3C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:33:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EEFB217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uTGLNK65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EEFB217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d3mqvE4EQkXCM4KIXEQ22vA4CCXQzyS1SKTkWdlknhE=; b=uTGLNK65CBryAv
	r+4xxdO347FkZHG+gdZHjzjkpnZy8DtUaNti9ouwC7ugFJKHX41YQ7CWRsv1IrkazAHkbGu5WTyKS
	x4fEW+7ULdomMuittPbM3vc+h06DfegSALk+Z2NtgnNAIXnTqfNh3uiNhr1IvipNR2LVUoDvi9ylt
	3UwGW2nWpEIZ3vmDjKO5rjdcGxHIsRlzjna3CAxhZ95e97AnCBMq6KR3PgXdTp6/dz1oSX3OF8C+Q
	Nx85aVDALzcAB/zRyjkqsSoXmiJwUT5lpDB3tR6e0x8Plkz0BMlFxvDwegKk/vz255nrwI+I7Yu5s
	bd6r589ye31kZ3F3oSkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grOGN-00053Q-Oz; Wed, 06 Feb 2019 14:33:19 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grOGK-000531-Tu
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 14:33:18 +0000
Received: by mail-ed1-f67.google.com with SMTP id b3so6095754ede.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 06:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nN6InIre/0Ut06P7m83xMDQv6DT19lGhu9I5wCEhGnc=;
 b=mJ3tIXxs442nS0NteTd0QVQUl/LiO1gVoISGr2XW3gJZJ7LH0LQ5MV6vJijzb3X1Iq
 Xf1cFFAM53D2qwSFsMBeFp6V0pb6VkrwIa6ExiVDPHvoag7KgCZsYOFjOLw9Kzs4CQPf
 bHpu53bXPyDS0Ri8V3cYbyUdgr3f3mb6wbEon5M929DG2xY6bzIv9d+ee/2ohi4yUcoP
 q0E66qnYVYspNKit25GOHyEW5SsauTRIsh5JLeAVEGbKVnS6CmNIcuNyKSAZfpRCMHOG
 9y3LehhWhcuxVX524hL0x4jR3DfhlNGsLzhvPccSIw04GxdGh73CT6NtYnf72+rnYz/K
 sKqg==
X-Gm-Message-State: AHQUAuYAy0B6JrglVnfhBDbgdQRQ40KSPDxdgFlrrt0vnvuA7dELGMwY
 E1gesEiowRnMFOEUdF0aW9n0zKJ2Ci8=
X-Google-Smtp-Source: AHgI3IYqJHTHN7noANg0fssfJ+5s4+Mw+/UT0OsJ6N5lRvWjF1iEj3EPlwSGexprxaG3R3haRsJuwQ==
X-Received: by 2002:a17:906:7f95:: with SMTP id
 f21mr7750529ejr.131.1549463594565; 
 Wed, 06 Feb 2019 06:33:14 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com.
 [209.85.128.43])
 by smtp.gmail.com with ESMTPSA id x58sm5972298edm.10.2019.02.06.06.33.13
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Feb 2019 06:33:14 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id y8so2956262wmi.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 06:33:13 -0800 (PST)
X-Received: by 2002:a1c:494:: with SMTP id 142mr3422692wme.111.1549463593169; 
 Wed, 06 Feb 2019 06:33:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.f7a136448029ab87c498d68164670712639748e7.1548236066.git-series.maxime.ripard@bootlin.com>
 <624512bb9665e0b15244c2bdf230bcfada3a3b98.1548236066.git-series.maxime.ripard@bootlin.com>
 <CAGb2v6702pRt-=SrOLqfxO5CBQT+bxFgQ6fugA=4SP_vWdqcBw@mail.gmail.com>
 <CAGb2v66h67zmGB9jZ4QxUN1mU-pZy4kPRzvSxu1ECOi4SqETUA@mail.gmail.com>
 <20190206141230.k3sngyad2k5rdmrx@flea>
In-Reply-To: <20190206141230.k3sngyad2k5rdmrx@flea>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 6 Feb 2019 22:32:57 +0800
X-Gmail-Original-Message-ID: <CAGb2v66XtKTir-NJ8Auyos9dq1McyW0fG47y=zrmUfTPVN_8VA@mail.gmail.com>
Message-ID: <CAGb2v66XtKTir-NJ8Auyos9dq1McyW0fG47y=zrmUfTPVN_8VA@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/sun4i: dsi: Change the start delay calculation
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_063316_960629_BCB9E411 
X-CRM114-Status: GOOD (  36.88  )
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

On Wed, Feb 6, 2019 at 10:12 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi Chen-Yu,
>
> On Wed, Feb 06, 2019 at 12:48:21AM +0800, Chen-Yu Tsai wrote:
> > On Wed, Jan 30, 2019 at 11:23 AM Chen-Yu Tsai <wens@csie.org> wrote:
> > >
> > > On Wed, Jan 23, 2019 at 11:54 PM Maxime Ripard
> > > <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > The current calculation for the video start delay in the current DSI driver
> > > > is that it is the total vertical size, minus the backporch and sync length,
> > > > plus 1.
> > > >
> > > > However, the Allwinner code has it as the active vertical size, plus the
> > > > back porch and the sync length. This doesn't make any difference on the
> > > > only panel it has been tested with so far, since in that particular case
> > > > the front porch is equal to the sum of the back porch and sync length.
> > > >
> > > > This is not the case for all panels, obviously, so we need to fix it. Since
> > > > the Allwinner code has a bunch of extra code to deal with out of bounds
> > > > values, so let's add them as well.
> > > >
> > > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > > ---
> > > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > index 380fc527a707..e3e4ba90c059 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > @@ -357,7 +357,12 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
> > > >  static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
> > > >                                            struct drm_display_mode *mode)
> > > >  {
> > > > -       return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
> > >
> > > According to the diagram in include/drm/drm_modes.h ,
> > > This is active region plus back porch plus 1, as
> > >
> > >     sync_end - display = length of front porch and sync
> > >
> > > > +       u16 delay = (mode->vsync_end + 1) % mode->vtotal;
> > >
> > > And this actually means
> > >
> > >     (length of active region and front porch and sync pulse plus 1) %
> > > total length
> > >
> > > So I don't really understand what's happening here. And the modulus
> > > is unexplained.
> >
> > Attempting to make sense of this.
>
> Sorry for dragging you into this
>
> > Allwinner's A64 BSP the following which uses their definitions for
> > y, vbp, vt:
> >
> >     s32 start_delay = panel->lcd_vt - panel->lcd_y -10;
> >     u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> >     u32 dsi_start_delay;
> >
> >     /* put start_delay to tcon. set ready sync early to dramfreq, so
> > set start_delay 1 */
> >     start_delay = 1;
> >
> >     dsi_start_delay = panel->lcd_vt - vfp + start_delay;
> >     if (dsi_start_delay > panel->lcd_vt)
> >            dsi_start_delay -= panel->lcd_vt;
> >     if (dsi_start_delay==0)
> >            dsi_start_delay = 1;
> >
> > This can be converted to
> >
> >     dsi_start_delay = max(1, (mode->vtotal - (mode->vtotal -
> > mode->vdisplay - (mode->vtotal - mode->vsync_start)) + 1) %
> > mode->vtotal)
> >
> > and simplified to
> >
> >     dsi_start_delay = max(1, (mode->vtotal + mode->vdisplay -
> > mode->vsync_start) + 1) % mode->vtotal)
> >
> > and reordered to the following
> >
> >     dsi_start_delay = max(1, (mode->vtotal - (mode->vsync_start -
> > mode->vdisplay) + 1) % mode->vtotal)
>
> Where did you find that Allwinner's back porch is including the sync
> length?

I believe that was the case with the TCON? And since Allwinner's code
take the values from the FEX files directly for both TCON and DSI,
it should be the same.

There's also some dead code in the BSP that alludes to it, such as the
function tcon1_cfg_ex() in drivers/video/de/lowlevel_sun50iw1/de_lcd.c
from the A64 BSP.

> If we treat the bp as vtotal - vsync_end as we should (and yet I often
> fail to), then we end up with (leaving out the modulo for now):
>
> dsi_start_delay = max(1, mode->vtotal - (mode->vtotal - mode->vdisplay -
>                                          (mode->vtotal - mode->vsync_end)) + 1)
>
> which equals (if we remove the first mode->vtotal - mode->vtotal)
>
> dsi_start_delay = max(1, mode->vdisplay + (mode->vtotal - mode->vsync_end) + 1)
>
> Otherwise,
>
> Then yeah, I end up with the same results than you, and on the Rondo
> display I have, the start delay difference is of one between the
> formula in this patch and the one you came up with, so I think we're
> good.
>
> The BPI-M2M display timings would need to be adjusted as well, since
> the timings were created from the FEX file and the BP was assumed to
> be only the BP. We don't have the datasheet for this one though, so
> it's difficult to check.

Let's just see if it still behaves correctly.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
