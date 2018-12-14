Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4C3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:16:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA206206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U+9uFLR5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="ICwF57aN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA206206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ozBlWOHIeFvJ0QJsdJN7FUbTZoXncYlkNbj5ifN9MWw=; b=U+9uFLR5jagntn
	J5x/s6GnNjhNDwK9wmgXQboILJS0lutffH6EMY+Yr8roQ1MkJZI7U6zcWnNFkGK52K2GpgdrPp9++
	jDxTipBRSJtCsjfQ7UKQkPg9dofKfp0nV3bOXwZ+XSp+FM6C/2nUq8AXBiPijBF+otG+3I4xGCEaZ
	y/fwjCUpssF8zvDgCKe6QHPhQ5up0yAh9TVy3IQoDJ4NC94bwClzZ/m5WD6o4Mw0V/IxwiBgloCfL
	JZbh7JZXb2BWvtcgGrYhCbdvDp8X1jmKJULSo6OFxvk/aXrMWmWP94265t8LkIcCiJSdsqsL+Mq0k
	TmA41gT5v655UxQTpNAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXoFv-00089u-FP; Fri, 14 Dec 2018 14:15:55 +0000
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXoFs-00089A-D2
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 14:15:54 +0000
Received: by mail-yw1-xc41.google.com with SMTP id r130so2323879ywg.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 06:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poorly.run; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=QGILX5ZO5eZc/l5EQU1PR2qLPMBe3eqixLTUZdadH/k=;
 b=ICwF57aNe2VbdRONM2zz7YqgFA4eLVjHyw5W8mG80Q0Kmy/ofC81ra7vaLiB4837HA
 w4g41KH5V736OkbIxnIxmPKsjCEVudzZ32mlvLbai4HESWlwTJoy0WMB13tJQds7JNy2
 zBE3Wy5y5va3SDrr96LZCv8fqEiotOqtcPAhHscdsIv76PlpvGuG7ivT/1q23GBm9o7+
 g4k2Yj5UcbHIdR1hZH3Q5SOH0pdEZ1GyoCtkvnNQ9a6jBZ1loJjhR9SLR/Tsf1GC0M5G
 9eaQDSbtaF9pTU5ej6O+ktKMcm8ojI/7xxQQn41RoQjJsge1jyvf0sWDPPtWofVlNwSH
 3CWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QGILX5ZO5eZc/l5EQU1PR2qLPMBe3eqixLTUZdadH/k=;
 b=GSvDHhIHlHwaQmzo5S4vQXgkOhWPi8SRl+MDOEmh19gE3A8Bk+W+iRkjkbh2K7X7gX
 OOKaIbtyvcmNdNaexWap+wARTBC4lyi2/xoUzHca4dWtCGooYamHagYdMNW8CJXH0Z2G
 aFswr1VWijl4ibFlTFxNGLBUIv4sZD/OHlssxfbRJ0fBQ0/32456Q4TZRodjFWHww5FY
 ivTlXwFJFALuRnwebsMSOhBHz9VO+SPRSW68OTvtbO80EFNGtrvekiETJ0Gu6OrOd8xS
 VJSZNW21+EXGt+bQde56ldlQyyVfPNPRJ7tXAFqau/lK1jZ0WKCUeco1BwO2dCPbMxr3
 m9CQ==
X-Gm-Message-State: AA+aEWYQSyIjMaAPr1BF3V9fvp7IaGDuguZ8/mN5gfn6UIIP12ZhcMEL
 bUHea1XaxA9r3mOh1XlPmVX5qA==
X-Google-Smtp-Source: AFSGD/WPMHi4sx0LCASWAZa4KCSVJGgKlSQU+XCbWcBhaE5soDKWSJ6L7iTBk1nkyFT3YlOrXZH2jw==
X-Received: by 2002:a81:7c04:: with SMTP id x4mr3146142ywc.264.1544796941192; 
 Fri, 14 Dec 2018 06:15:41 -0800 (PST)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
 by smtp.gmail.com with ESMTPSA id a65sm460127ywa.84.2018.12.14.06.15.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 14 Dec 2018 06:15:40 -0800 (PST)
Date: Fri, 14 Dec 2018 09:15:39 -0500
From: Sean Paul <sean@poorly.run>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v2 11/12] drm/panel: Add Feiyang FY07024DI26A30-D
 MIPI-DSI LCD panel
Message-ID: <20181214141539.GN154160@art_vandelay>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-12-jagan@amarulasolutions.com>
 <20181213150736.GL154160@art_vandelay>
 <CAMty3ZAv1dHCRCShXYbxqMm4wV9WGDpAKPji+3G21eWq34ODaA@mail.gmail.com>
 <20181213194804.GM154160@art_vandelay>
 <CAMty3ZCkGudTL9NLnWjTPD8+xqEzY2d0oLN9x=64Hk8MzKTM5g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMty3ZCkGudTL9NLnWjTPD8+xqEzY2d0oLN9x=64Hk8MzKTM5g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_061552_490626_E1006FF7 
X-CRM114-Status: GOOD (  30.33  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-amarula@amarulasolutions.com,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>, David Airlie <airlied@linux.ie>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, TL Lim <tllim@pine64.org>,
 Michael Trimarchi <michael@amarulasolutions.com>, Sean Paul <sean@poorly.run>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 04:35:11PM +0530, Jagan Teki wrote:
> On Fri, Dec 14, 2018 at 1:25 AM Sean Paul <sean@poorly.run> wrote:
> >
> > On Fri, Dec 14, 2018 at 12:56:03AM +0530, Jagan Teki wrote:
> > > On Thu, Dec 13, 2018 at 8:37 PM Sean Paul <sean@poorly.run> wrote:
> > > >
> > > > On Fri, Nov 16, 2018 at 10:09:15PM +0530, Jagan Teki wrote:
> > > > > Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.
> > > > >
> > > > > Add panel driver for it.
> > > > >
> > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > ---
> > > > >  MAINTAINERS                                   |   6 +
> > > > >  drivers/gpu/drm/panel/Kconfig                 |   9 +
> > > > >  drivers/gpu/drm/panel/Makefile                |   1 +
> > > > >  .../drm/panel/panel-feiyang-fy07024di26a30d.c | 286 ++++++++++++++++++
> > > > >  4 files changed, 302 insertions(+)
> > > > >  create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > > > >
> >
> > /snip
> >
> > > > > diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > > > > new file mode 100644
> > > > > index 000000000000..a4b46bd8fdbe
> > > > > --- /dev/null
> > > > > +++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> >
> > /snip
> >
> > > > > +static int feiyang_prepare(struct drm_panel *panel)
> > > > > +{
> > > > > +     struct feiyang *ctx = panel_to_feiyang(panel);
> > > > > +     struct mipi_dsi_device *dsi = ctx->dsi;
> > > > > +     unsigned int i;
> > > > > +     int ret;
> > > > > +
> > > > > +     ret = regulator_enable(ctx->dvdd);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     msleep(100);
> > > >
> > > > nit: You should do your best to correlate the sleeps with the timing parameters
> > > > from the datasheet with a comment.
> > > >
> > > > ie:
> > > >         /* T1: > 100ms */
> > > >         msleep(100);
> > >
> > > Sorry, what does this mean?
> >
> > On page 9 of the datasheet you sent me [1], it has the delays required to safely
> > power up the panel. This delay is the time between dvdd going high and avdd
> > going high. On the figure in the datasheet, this would be T2 (T1 is dvdd rise
> 
> time between dvdd going high and avdd going high is T1 + T3 right?
> 
> T2 > 0ms
> T3 > 20ms
> 
> In this case the delay can be msleep(20) ?

Hmm, yeah, I didn't notice that T3 was > 20ms, that's kind of confusing. So I
think you're right, this should be T2 + T3 > 20ms (T1 is covered in the
regulator_enable of dvdd).

> 
> > time and should be handled in the regulator subsystem (iirc)). Also according to
> > the datasheet, T2 just needs to be > 0, so you don't even need this delay. You
> > could replace this with a comment like:
> >
> >         /* T1 (dvdd rise time) + T2 (dvdd->avdd) > 0 */
> >
> > So for all of the msleeps below you should get the delays from the datasheet and
> > add a comment referencing them.
> 
> T5 and T6 are delay between avdd to reset enable it can be 10 + 10
> =&gt; 20ms and finally T12 which is 200 after reset.
> 
> What about the delay between resets, I need to understand it a bit.

These are usually accounted for at the end of disable. Take a look at the sleep
parameters in panel-simple for an example.

Sean

-- 
Sean Paul, Software Engineer, Google / Chromium OS

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
