Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCEEC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:05:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E24721104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ju38jMYk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="H762xqNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E24721104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xSETVOHxuYKvbDFN1rYIcJkldUKkkGDrcanPxr0YfgE=; b=Ju38jMYkiRs259
	T0jLSQbfi+qZWp+Eb7Oc0TX1UcCNnylqKBfRRJp6GBtdbOOUxn6a+xV4SA5ETZ6tVFHJDi65hxDu2
	pKwdYygnwvf+kwG6NzHEC0lV4/Nl2I/S8nZxRBOdGuUEqH5CF1NlKyTNOH0yCrc+FIGULEu4ULjKl
	FadpSZZSXp7XR3ybckN/t2UfwRaI1Eoyz44IdJfsS4aXypxmL0uJe7nS/30BkyRUl2Ag+YvYBM4iF
	OLTBj9RXOhd2UsXs3/VALPR4J8da2CEaA4zK3W6FnnJIkkqUhU8rS/NVR7n8b3CxUAc2Q2SGOiLfe
	1azupwCYv+GQOCJRwcKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXlHn-00057d-GJ; Fri, 14 Dec 2018 11:05:39 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXlHi-00056f-5J
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 11:05:37 +0000
Received: by mail-it1-x141.google.com with SMTP id g76so8332007itg.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 03:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cR96VzeuN4rR8v4u6PfTnlPa4PIqhZ3R3Gftq0PxSTQ=;
 b=H762xqNAtiHMFNpm8VTG+35lKhBIV9b7giISjUlCZgdACtPHYJLIKoqC2ZTo7Qk7bj
 w9FqBl3ArCU3cLWBv1PH379abPxOJr4HQ5CO9qYfbxA2uccKEK7iY3Ng72Wku8QLYzEC
 NbJ4n6C8r5OcdAGQxd7EQCK1wVEiR7j++Y6lI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cR96VzeuN4rR8v4u6PfTnlPa4PIqhZ3R3Gftq0PxSTQ=;
 b=tdmpMHo2Pl3F5xslpUEMKV/PVfuL8VvrNnOQAa6qMK0McAMszZ2LQ2Z2brtxdmrt3D
 8sOsTJHbI9k+tt7/LbD15hG4fq1cfnCdLnszRP76+XvIY6ZFP6WfMC9OyO2FTsPtEeuS
 Ae/rKlajWKXiEg7xwdR9Mtbvs54zZxr++YDsipclmugU9K6dwBd9DouFZb0fptGYbgoM
 8Po3MbSI6G17uMazXrjCpY2fje2My6SSMM1n56MQ+m6p/DoqHumOwplkMNro726dOwHH
 QNtxf3qVpjyrMPxwP1xJI7YmYo9F4esTourUv48ER68zE335BJ9tbGeXPERrVzs207Hp
 fXiA==
X-Gm-Message-State: AA+aEWb3lqZEcw7rq1f/eHMZrsVJU4xReT0Yhm/y1KPjUspmnJK6w9q5
 dijVidZFKzKVQX701Ob/KuIoMaGnJDBePF6AnR8lJsDATqNdhw==
X-Google-Smtp-Source: AFSGD/Wv/fLca5wnq91Ll6scd3pFAXJrzw20BhF5GCBFoMH5xu4QSuDaVblAn+Sj2D0/MvH+kcjF5/fKo9nBubwrjAs=
X-Received: by 2002:a02:104a:: with SMTP id 71mr1975084jay.103.1544785522760; 
 Fri, 14 Dec 2018 03:05:22 -0800 (PST)
MIME-Version: 1.0
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-12-jagan@amarulasolutions.com>
 <20181213150736.GL154160@art_vandelay>
 <CAMty3ZAv1dHCRCShXYbxqMm4wV9WGDpAKPji+3G21eWq34ODaA@mail.gmail.com>
 <20181213194804.GM154160@art_vandelay>
In-Reply-To: <20181213194804.GM154160@art_vandelay>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Fri, 14 Dec 2018 16:35:11 +0530
Message-ID: <CAMty3ZCkGudTL9NLnWjTPD8+xqEzY2d0oLN9x=64Hk8MzKTM5g@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI
 LCD panel
To: Sean Paul <sean@poorly.run>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_030536_236651_8E6B2E49 
X-CRM114-Status: GOOD (  26.31  )
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
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>, David Airlie <airlied@linux.ie>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, TL Lim <tllim@pine64.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 1:25 AM Sean Paul <sean@poorly.run> wrote:
>
> On Fri, Dec 14, 2018 at 12:56:03AM +0530, Jagan Teki wrote:
> > On Thu, Dec 13, 2018 at 8:37 PM Sean Paul <sean@poorly.run> wrote:
> > >
> > > On Fri, Nov 16, 2018 at 10:09:15PM +0530, Jagan Teki wrote:
> > > > Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.
> > > >
> > > > Add panel driver for it.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > >  MAINTAINERS                                   |   6 +
> > > >  drivers/gpu/drm/panel/Kconfig                 |   9 +
> > > >  drivers/gpu/drm/panel/Makefile                |   1 +
> > > >  .../drm/panel/panel-feiyang-fy07024di26a30d.c | 286 ++++++++++++++++++
> > > >  4 files changed, 302 insertions(+)
> > > >  create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > > >
>
> /snip
>
> > > > diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > > > new file mode 100644
> > > > index 000000000000..a4b46bd8fdbe
> > > > --- /dev/null
> > > > +++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
>
> /snip
>
> > > > +static int feiyang_prepare(struct drm_panel *panel)
> > > > +{
> > > > +     struct feiyang *ctx = panel_to_feiyang(panel);
> > > > +     struct mipi_dsi_device *dsi = ctx->dsi;
> > > > +     unsigned int i;
> > > > +     int ret;
> > > > +
> > > > +     ret = regulator_enable(ctx->dvdd);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     msleep(100);
> > >
> > > nit: You should do your best to correlate the sleeps with the timing parameters
> > > from the datasheet with a comment.
> > >
> > > ie:
> > >         /* T1: > 100ms */
> > >         msleep(100);
> >
> > Sorry, what does this mean?
>
> On page 9 of the datasheet you sent me [1], it has the delays required to safely
> power up the panel. This delay is the time between dvdd going high and avdd
> going high. On the figure in the datasheet, this would be T2 (T1 is dvdd rise

time between dvdd going high and avdd going high is T1 + T3 right?

T2 > 0ms
T3 > 20ms

In this case the delay can be msleep(20) ?

> time and should be handled in the regulator subsystem (iirc)). Also according to
> the datasheet, T2 just needs to be > 0, so you don't even need this delay. You
> could replace this with a comment like:
>
>         /* T1 (dvdd rise time) + T2 (dvdd->avdd) > 0 */
>
> So for all of the msleeps below you should get the delays from the datasheet and
> add a comment referencing them.

T5 and T6 are delay between avdd to reset enable it can be 10 + 10
=&gt; 20ms and finally T12 which is 200 after reset.

What about the delay between resets, I need to understand it a bit.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
