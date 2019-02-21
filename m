Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD42C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:42:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63EF52086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mo9P66iV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCBmaNgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63EF52086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m85zw7izLUQAftJGObmQ7ZDKiHSBQ23J0e9p4aJCYOU=; b=Mo9P66iV4wyR6Q
	sYUpRmjaQ9MgeBLaDJdi7Ap4mo0bkXFb/b3vgOCINeq+RDAQeasm9FbosY0i8IsjJjtkuRtzg5VoW
	1XYDKAekBygbO+uhTIGXoiIQYwr4Xn0iqqryjf769xp99Mo0CGAEBH9QrTDhOOzy2JXwGzHXcBrcG
	GkpXPKeXVKt6xKIxa5wDtCdrgepOmJ9aJzcdIwwB+WNHe/+xZTqqJZhp+T0tGaYOJ1iTGwgzjgFBq
	4GEAEXBXnRscpCA4GLUjsdi+E2wL8IoYitRNpBwjIwB8CxYsNqNWtHu2U2ztCvF9mlkaQdTRVT6/x
	Kg4Ly/27pEpYEfJtJZTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwi3Z-00027o-Qb; Thu, 21 Feb 2019 06:42:05 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwi3V-000274-Nb
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 06:42:03 +0000
Received: by mail-ot1-x343.google.com with SMTP id n71so43988676ota.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 22:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oZLuHvi6dxMdxF6+YdcLqfkavwbkzPlDzObkV+DFtqk=;
 b=HCBmaNgq04mU+cXcHOxnBU0HIx16w6GXalyywTtRl3iVPk64Gk5J9urZBt0k/7oJwT
 G9vgqChwkMNY8cH4hQTpARACUTDZParNwjos8kRfkRcToJeeBOb97gkKMA45Akz6TUJV
 0aKCcYv3WfiCdqqBx9N62ta6QBluq0aYGhPOI3g/sWJbzRd3jwIdXSspY8EXTU7jVAf2
 vREkxbnZUj0ZEa7B+lMrtUJiRYd9sdGma/S/1/iNP2jovv9JAXoFp3tJXsBVpuIhuMFU
 4Cm4oaCS9qmjiQHIEDLhh146eyScfyBPTzJZtEn9GetDdu+4LcQ6jnhzhp50bUU7Y2Ch
 ut8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oZLuHvi6dxMdxF6+YdcLqfkavwbkzPlDzObkV+DFtqk=;
 b=dooNiKvBtKoZUJ6k06/C44igAb5LzctWC/YjAVolRooFCtlcLiu7tSlPIfMg4dILpz
 bRXqasxUV5hDJEeijpjFbAeG6erypxOuLqjq6hovB3sV3kUJq2UDGibdL4Sxe6Z49vsE
 J0m+KTEIAOzNKG0qaKrHXfmIOlx0FPism25vDPnBSeV/1YUNmMA7+Wt6yT54+1gnlETb
 tTtaRRu04rfT3kRd2P5Eyof/9GFgCoSXcfyxZrqddcHCvXvSaUkQwWw7oJ46nr1JD4MH
 aheLGrP9tvDaqGq7hToU7O0popwo9KzhqXWfs/7Dj+rtNL0CbO+CWAQIpZHhN7factNX
 oggg==
X-Gm-Message-State: AHQUAuZXOuxv0VjBBNo7VFT8BoRE639lQ6XBYcxQTOwh1JcSaw4w19Tf
 LosBjlG2Ce7WUwFsWgPEOKMPw2EZaSAZhuVR96U=
X-Google-Smtp-Source: AHgI3Ib1Qf8bXKwIzxbEKejrrUcTTDKLDYIvsE9L7re2iDVc5x9gl1WM2ZRG0QyNIN6s7FQWih2fNarbGRe+AJujrCY=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr22460681otn.111.1550731317759; 
 Wed, 20 Feb 2019 22:41:57 -0800 (PST)
MIME-Version: 1.0
References: <20190215050957.20755-1-anarsoul@gmail.com>
 <20190215050957.20755-7-anarsoul@gmail.com>
 <20190218182629.GA14714@bogus>
 <CA+E=qVfDfDvVmKQDeh2e0SA=tm6VpBMpu9MPKUqxFPObxYFXDg@mail.gmail.com>
 <20190219085626.7poutwvm3lrilnon@flea>
In-Reply-To: <20190219085626.7poutwvm3lrilnon@flea>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Wed, 20 Feb 2019 22:41:31 -0800
Message-ID: <CA+E=qVdnP5iN2u98VEgEYoSnfUQwHMaGmSYkNjhuwvsc+jK8Rw@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] drm/sun4i: rgb: Add DT property to disable
 strict clock rate check
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_224201_821280_1D5545C4 
X-CRM114-Status: GOOD (  44.46  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Archit Taneja <architt@codeaurora.org>,
 devicetree <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Andrzej Hajda <a.hajda@samsung.com>, Chen-Yu Tsai <wens@csie.org>,
 Thierry Reding <thierry.reding@gmail.com>, Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 12:56 AM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Mon, Feb 18, 2019 at 11:33:05AM -0800, Vasily Khoruzhick wrote:
> > On Mon, Feb 18, 2019 at 10:26 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Thu, Feb 14, 2019 at 09:09:52PM -0800, Vasily Khoruzhick wrote:
> > > > Clock rate check that was added in commit bb43d40d7c83 ("drm/sun4i: rgb:
> > > > Validate the clock rate") prevents some panel and bridges from working with
> > > > sun4i driver.
> > >
> > > Sounds lile a regression that should be reverted. The fix is not a
> > > backwards compatible change either.
> >
> > anx6345 driver isn't mainlined yet and I'm not sure if this change
> > breaks any mainlined boards. So likely there's not enough
> > justification to revert it.
> >
> > > > Unfortunately, dotclock frequency for some modes are not achievable on
> > > > sunxi hardware, and there's a slight deviation in rate returned by
> > > > clk_round_rate(), so they fail this check.
> > > >
> > > > Experiments show that panels and bridges work fine with this slight
> > > > deviation, e.g. Pinebook that uses ANX6345 bridge with 768p eDP panel
> > > > requests 73 MHz, gets 72.296MHz instead (0.96% difference) and works just
> > > > fine.
> > > >
> > > > This patch adds DT property to disable strict clock rate check
> > > >
> > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > ---
> > > >  .../devicetree/bindings/display/sunxi/sun4i-drm.txt          | 2 ++
> > > >  drivers/gpu/drm/sun4i/sun4i_rgb.c                            | 5 +++++
> > > >  drivers/gpu/drm/sun4i/sun4i_tcon.c                           | 3 +++
> > > >  drivers/gpu/drm/sun4i/sun4i_tcon.h                           | 1 +
> > > >  4 files changed, 11 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > > > index f426bdb42f18..18c8b053a28d 100644
> > > > --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > > > +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > > > @@ -63,6 +63,8 @@ Required properties:
> > > >      Documentation/devicetree/bindings/media/video-interfaces.txt. The
> > > >      first port should be the input endpoint. The second should be the
> > > >      output, usually to an HDMI connector.
> > > > +  - no-strict-clock-check: don't reject timings if exact dot clock can't be
> > > > +    reached.
> > >
> > > This should be the default IMO. Most panels are a single timing, so if
> > > we reject it the fallback no display?
> >
> > As far as I remember the change was introduced to reject some modes
> > for which dotclock can't be reached when driver is used with VGA
> > bridge. So if we make it default it'll break boards with VGA bridge
> > and old DT.
> >
> > > I thought we had some mechanism already to allow some range of
> > > frequencies. I think the chromeos guys needed something IIRC.
> >
> > You can specify frequency range for panels, but there's nothing for
> > bridges. In my case EDID doesn't specify clock tolerance.
>
> I gave it some more though, and came up with the following patch. The
> basic idea is to leave the boundary check for the bridges that will
> have EDID and we need to filter out the modes that have no chance of
> being supported. The tolerancy used is the one defined in VESA specs,
> but I added a module parameter if you wanted to tune that.
>
> And finally, since most of our panels are single timings without any
> tolerancy, we just try our best in this case and that's it, while
> leaving the door open to support display_timings and being able to do
> more once we have an idea of what the tolerancies are.
>
> If that works for you, I'll submit it.
>
> Maxime
>
> --- >8 ---
> diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> index f4a22689eb54..0460146aab75 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> @@ -43,6 +43,25 @@ drm_encoder_to_sun4i_rgb(struct drm_encoder *encoder)
>                             encoder);
>  }
>
> +static inline struct drm_connector *
> +sun4i_rgb_get_connector_from_encoder(const struct drm_encoder *encoder)
> +{
> +       struct drm_connector *connector = NULL, *tmp;
> +       struct drm_connector_list_iter iter;
> +
> +       drm_connector_list_iter_begin(encoder->dev, &iter);
> +       drm_for_each_connector_iter(tmp, &iter)
> +               if (tmp->encoder == encoder) {
> +                       connector = tmp;
> +                       goto out;
> +               }
> +
> +out:
> +       drm_connector_list_iter_end(&iter);
> +
> +       return connector;
> +}
> +
>  static int sun4i_rgb_get_modes(struct drm_connector *connector)
>  {
>         struct sun4i_rgb *rgb =
> @@ -52,11 +71,22 @@ static int sun4i_rgb_get_modes(struct drm_connector *connector)
>         return drm_panel_get_modes(tcon->panel);
>  }
>
> +/*
> + * VESA DMT defines a tolerancy of 0.5% on the pixel clock, while the
> + * CVT spec reuses that tolerancy in its examples, so it looks to be a
> + * good default tolerancy for the EDID-based modes.
> + */
> +static unsigned int clock_tolerancy = 5;
> +module_param(clock_tolerancy, uint, 0644);
> +MODULE_PARM_DESC(clock_tolerancy,
> +                "Tolerancy of the pixel clock in per mille");
> +
>  static enum drm_mode_status sun4i_rgb_mode_valid(struct drm_encoder *crtc,
>                                                  const struct drm_display_mode *mode)
>  {
>         struct sun4i_rgb *rgb = drm_encoder_to_sun4i_rgb(crtc);
>         struct sun4i_tcon *tcon = rgb->tcon;
> +       struct drm_connector *connector = sun4i_rgb_get_connector_from_encoder(crtc);
>         u32 hsync = mode->hsync_end - mode->hsync_start;
>         u32 vsync = mode->vsync_end - mode->vsync_start;
>         unsigned long rate = mode->clock * 1000;
> @@ -92,15 +122,27 @@ static enum drm_mode_status sun4i_rgb_mode_valid(struct drm_encoder *crtc,
>
>         DRM_DEBUG_DRIVER("Vertical parameters OK\n");
>
> +       /*
> +        * TODO: We should use the struct display_timing if available
> +        * and / or trying to stretch the timings within that
> +        * tolerancy to take care of panels that we wouldn't be able
> +        * to have a exact match for.
> +        */
> +       if (connector->connector_type == DRM_MODE_CONNECTOR_Unknown) {

I applied your patch onto 5.0-rc6 and connector is NULL for me on
Pinebook. I guess you need to check whether it's NULL before
dereferencing it.

> +               DRM_DEBUG_DRIVER("RGB panel used, skipping clock rate checks");
> +               goto out;
> +       }
> +
>         tcon->dclk_min_div = 6;
>         tcon->dclk_max_div = 127;
>         rounded_rate = clk_round_rate(tcon->dclk, rate);
> -       if (rounded_rate < rate)
> +       if (rounded_rate < (rate * (1000 - clock_tolerancy) / 1000))
>                 return MODE_CLOCK_LOW;
>
> -       if (rounded_rate > rate)
> +       if (rounded_rate > (rate * (1000 + clock_tolerancy) / 1000))
>                 return MODE_CLOCK_HIGH;
>
> +out:
>         DRM_DEBUG_DRIVER("Clock rate OK\n");
>
>         return MODE_OK;
> --- >8 ---
>
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
