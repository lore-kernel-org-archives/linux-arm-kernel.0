Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF10C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:55:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DDAD20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F26aqmL8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="XL04eIu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDAD20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DkNnYv+JCr40a+Iiz58AxMz2f4H8/LATDmpC6aItckA=; b=F26aqmL8m1jJv+
	nYTbicuFk98Y03iH0BZoaglf22m4yVivydQJolPveC1JqA5FbkzJcCIHRYStgQkSPr/GSRnU6RiCe
	TKTOwqXOVm1AOF+TfLu/9jq8JG2lKKrrKgJAqkL2XWKwDmZh3BCMpag20JUI0Akn6gckdzh8rBwDm
	HcMPXQFVTqQb99YDdZIsaTj9Yqf3/xgGHPnkHq9ZfehqShULPisP2VSUfy+tB5WLtG0Uqi47q0JKN
	dWZgaRpSt5Bl13U2GIMAvY4On0N6GFigMDG34eburO6tmGZpDb1DoYX5tJgFlV5ySIPsDfdqnn/Tf
	Bl8QY0ODR0uyRraQ3P9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXX4u-0001Yc-9A; Thu, 13 Dec 2018 19:55:24 +0000
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXX4p-0000Ux-2D
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 19:55:21 +0000
Received: by mail-yw1-xc41.google.com with SMTP id r130so1321290ywg.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 11:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poorly.run; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=94iF7LkuxJObcikGEQB4tq+75E7LrVuG+cW9WkhdMDo=;
 b=XL04eIu8AI2POrKcGoM8eB4Dy45hospI1o11mx68sB1nAOJxGIIFag16ayGHRN/yqQ
 yYcnoSUES9gOnsrlExzsMclXvenO8GTus/2ua/F06Ko6I+Z9hOFrBN9eWf3Y2EMd6Eme
 UUz50tiM9im4RaMFT2epAAZLIh8uDsQzD8jJXGCmMa3RONa9mwdpqhSga2dKu3qq8Pdw
 Z/yWyu50n0V+PYcFLMH7Bkr/lJEIxFkaQoWlTsZonRezlnQ15KLplFsPiEtMw/rarDsc
 oIx6h6tqO9OiwzGV88gsiHthALkphzHkhrQcY5VWo2knsedkRybkH8NB8A8IX7o3yBTe
 1PSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=94iF7LkuxJObcikGEQB4tq+75E7LrVuG+cW9WkhdMDo=;
 b=EQmScqoE4OxqPRFzPCcJmFEU7WsuzVXEp6h1+eoegLAbEKK8m681ddU7b7NMOvBCnT
 v3scnvKijJjJwmS2HIN6oTIGbOUjPU9cWHwXcKOvP/GtbR8LUo5sb1Cgv0jcjZYcQXqa
 72ZCx7iJXfg5gZxvnukYXD46rshNG2CyL1OXTgK2/x8f9EF278QYztIw+/QENV4I7s4B
 o1fMuflgjitUrmf+9Odpn+ILuIh/XcacWvvlfM6jTiuKgrURms3ormrdhtK7/d0cXC06
 XpD7s7/6DTJNxc10J1E0GHsSqMYt5semhhvo3h4LKiBjWxXYC494loLARV41Yi5H0cZw
 xm4g==
X-Gm-Message-State: AA+aEWZAW+qSVGiiycPqvhrpoVJJQvuuTtQGwIwByrS1XQtBryWaXZKh
 BbH/kpzaVWSdlUeNYOR5VCmhBQ==
X-Google-Smtp-Source: AFSGD/XdMfN3GVM5Mb9RNKWgCS88185qYfZS8frAmLJfUBgYuZ9vtbSa82HXcSJGdvZpS0X+iXW9Fw==
X-Received: by 2002:a81:2209:: with SMTP id i9mr196812ywi.2.1544730907829;
 Thu, 13 Dec 2018 11:55:07 -0800 (PST)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
 by smtp.gmail.com with ESMTPSA id x82sm937250ywb.34.2018.12.13.11.55.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Dec 2018 11:55:07 -0800 (PST)
Date: Thu, 13 Dec 2018 14:55:06 -0500
From: Sean Paul <sean@poorly.run>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v2 11/12] drm/panel: Add Feiyang FY07024DI26A30-D
 MIPI-DSI LCD panel
Message-ID: <20181213194804.GM154160@art_vandelay>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-12-jagan@amarulasolutions.com>
 <20181213150736.GL154160@art_vandelay>
 <CAMty3ZAv1dHCRCShXYbxqMm4wV9WGDpAKPji+3G21eWq34ODaA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMty3ZAv1dHCRCShXYbxqMm4wV9WGDpAKPji+3G21eWq34ODaA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_115519_362384_DAC51FA0 
X-CRM114-Status: GOOD (  31.24  )
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

On Fri, Dec 14, 2018 at 12:56:03AM +0530, Jagan Teki wrote:
> On Thu, Dec 13, 2018 at 8:37 PM Sean Paul <sean@poorly.run> wrote:
> >
> > On Fri, Nov 16, 2018 at 10:09:15PM +0530, Jagan Teki wrote:
> > > Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.
> > >
> > > Add panel driver for it.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  MAINTAINERS                                   |   6 +
> > >  drivers/gpu/drm/panel/Kconfig                 |   9 +
> > >  drivers/gpu/drm/panel/Makefile                |   1 +
> > >  .../drm/panel/panel-feiyang-fy07024di26a30d.c | 286 ++++++++++++++++++
> > >  4 files changed, 302 insertions(+)
> > >  create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > >

/snip

> > > diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > > new file mode 100644
> > > index 000000000000..a4b46bd8fdbe
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c

/snip

> > > +static int feiyang_prepare(struct drm_panel *panel)
> > > +{
> > > +     struct feiyang *ctx = panel_to_feiyang(panel);
> > > +     struct mipi_dsi_device *dsi = ctx->dsi;
> > > +     unsigned int i;
> > > +     int ret;
> > > +
> > > +     ret = regulator_enable(ctx->dvdd);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     msleep(100);
> >
> > nit: You should do your best to correlate the sleeps with the timing parameters
> > from the datasheet with a comment.
> >
> > ie:
> >         /* T1: > 100ms */
> >         msleep(100);
> 
> Sorry, what does this mean?

On page 9 of the datasheet you sent me [1], it has the delays required to safely
power up the panel. This delay is the time between dvdd going high and avdd
going high. On the figure in the datasheet, this would be T2 (T1 is dvdd rise
time and should be handled in the regulator subsystem (iirc)). Also according to
the datasheet, T2 just needs to be > 0, so you don't even need this delay. You
could replace this with a comment like:

        /* T1 (dvdd rise time) + T2 (dvdd->avdd) > 0 */

So for all of the msleeps below you should get the delays from the datasheet and
add a comment referencing them.

Sean

[1] - http://files.pine64.org/doc/datasheet/pine64/FY07024DI26A30-D_feiyang_LCD_panel.pdf

> 
> >
> > > +
> > > +     ret = regulator_enable(ctx->avdd);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     msleep(20);
> > > +
> > > +     gpiod_set_value(ctx->reset, 1);
> > > +     msleep(50);
> > > +
> > > +     gpiod_set_value(ctx->reset, 0);
> > > +     msleep(20);
> > > +
> > > +     gpiod_set_value(ctx->reset, 1);
> > > +     msleep(200);
> > > +
> > > +     for (i = 0; i < ARRAY_SIZE(feiyang_init_cmds); i++) {
> > > +             const struct feiyang_init_cmd *cmd =
> > > +                                             &feiyang_init_cmds[i];
> > > +
> > > +             ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data, cmd->len);
> >
> >                 ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data,
> >                                                 FEIYANG_INIT_CMD_LEN);
> >
> > > +             if (ret < 0)
> > > +                     return ret;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int feiyang_enable(struct drm_panel *panel)
> > > +{
> > > +     struct feiyang *ctx = panel_to_feiyang(panel);
> > > +
> > > +     msleep(120);
> > > +
> > > +     mipi_dsi_dcs_set_display_on(ctx->dsi);
> > > +     backlight_enable(ctx->backlight);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int feiyang_disable(struct drm_panel *panel)
> > > +{
> > > +     struct feiyang *ctx = panel_to_feiyang(panel);
> > > +
> > > +     backlight_disable(ctx->backlight);
> > > +     return mipi_dsi_dcs_set_display_on(ctx->dsi);
> >
> > set_display_on? You probably want set_display_off here :)
> >
> > > +}
> > > +
> > > +static int feiyang_unprepare(struct drm_panel *panel)
> > > +{
> > > +     struct feiyang *ctx = panel_to_feiyang(panel);
> > > +     int ret;
> > > +
> > > +     ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
> > > +     if (ret < 0)
> > > +             DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
> > > +                           ret);
> > > +
> > > +     ret = mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
> > > +     if (ret < 0)
> > > +             DRM_DEV_ERROR(panel->dev, "failed to enter sleep mode: %d\n",
> > > +                           ret);
> > > +
> > > +     msleep(100);
> > > +
> > > +     regulator_disable(ctx->avdd);
> > > +
> > > +     regulator_disable(ctx->dvdd);
> > > +
> > > +     gpiod_set_value(ctx->reset, 0);
> > > +
> > > +     gpiod_set_value(ctx->reset, 1);
> > > +
> > > +     gpiod_set_value(ctx->reset, 0);
> >
> > Presumably this reset line toggle isn't needed since the rails are already
> > disabled?
> 
> Yes, rails need to reset and turn off. will swap.
> 
> >
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct drm_display_mode feiyang_default_mode = {
> > > +     .clock = 55000,
> > > +     .vrefresh = 60,
> >
> > This doesn't add up correctly. The pixel clock should be equal to:
> >
> >         (htotal * vtotal * vrefresh) / 1000
> >
> > For this reason, we usually don't specify the refresh rate since it can be
> > misleading. Your actual refresh rate with the pixel clock you specified is
> > actually going to be 56.2Hz instead of the 60 you want.
> 
> The actual BSP do work 55MHz[1], I do specify refresh rate unnecessarily.

Well, the BSP has a bug in it then :) You either want the refresh rate to be
60Hz or you want the pixel clock to be 55MHz, you can't have both with the
timing you have now. You'll need to alter the pixel clock or porches to get
60Hz.

Sean

> 
> [1] https://gitlab.com/pine64-android/tools/blob/01b3d9388439106bdd9985cf738c1b876bd617d3/pack/chips/sun50iw1p1/configs/db1000_lcd/sys_config_rgmii.fex#L483

-- 
Sean Paul, Software Engineer, Google / Chromium OS

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
