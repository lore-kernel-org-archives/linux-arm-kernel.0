Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4181C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:49:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9DE321B26
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Js3Amv4A";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/g7RmCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DE321B26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Uu+mTo1lX0iQvwm7aOsz4wDJk2FLbjpQCPGZw6pnjNY=; b=Js3Amv4AULX2OP
	uKGiTCH7OoGWBIOy85AGuTgKSvUSJSxPeE2DxqANQYGW6Y0YTkzmmEUn+YlJVCUymWGPv5NRIVXeE
	EKD/lhZieDS0aRMv8XJHyfWfR1KGEzq+d76teU8NjscrFBsnVSlShsrmk5atp4754Tq0KIXqYSoTb
	3bEEvwt1lklbEN3Nyk1vQwaQCqJy/aboXNK4OODcqBHgu7ZKLo5UEcfUT29DmrRJNcYr7K4t++y5t
	IKubN4jqp7vjsPziRIhEC7vTIF3iI7nRPazORhgLrOqjr9WisawJYSP+wU2CbyEJgbE4di81JLdkO
	L7MeIpjmvSoJwMvg0rpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gv6tZ-0008ES-Hn; Sat, 16 Feb 2019 20:49:09 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gv6tX-0008E3-1B
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 20:49:08 +0000
Received: by mail-ot1-x342.google.com with SMTP id n71so22269002ota.10
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 16 Feb 2019 12:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YMmQ03+dXddxGDg9ETm4Op8AJX8eyXOLPBQLceLux0w=;
 b=M/g7RmCEcfBZgMHi82WvNoz90q6lqPPd5cOrFjH5tS6iagfjLaraQ9DO3h+KHWv3X5
 r7Z6Zh1u9NEtuGED7y92m+17UycEeZlcA5M2CfTPu0Z7Sah1dRPXDnDqZFTJ/e5+BCfi
 9yjpELGcqSRqWsYsgj+1DrfOP272tGlOP67SiFjZz0ZHClyavEp8fEPfwrI9auu+k7a0
 EtD9kWfaWbogNilBoLPs28fruXQqOCa7RSTxHraCDoDKKQAEIeZU7oCmgVCjUJvzFbIK
 MzG85WImq3TkImGkXvYq+yH37jEyoioeyb3AAWk6SFJOtqXmTPcSOfLs5dynVmVcehfe
 0ALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YMmQ03+dXddxGDg9ETm4Op8AJX8eyXOLPBQLceLux0w=;
 b=tTuyU3SDv8B7860drGSGr62SaOgomXVEeRL4Rv1JstrmxefgblcZHaMWKB7LqHKS+4
 uRjBdwReQesq5GokqNgXw8rEo2wD8Lm7ACx0Fn3NrveGblKUGJWj1jhAOTUS/6hm01/3
 IR6Vnrouv8WOJy9Qkj8VdBGR3Y8/Ylj2wIT/lqNWRuyGbBIBYJvNW7vRMrZvfKQ4fFPO
 VlFbFrxCWl2EaArk1BCOMf3NxZ/6+Odrl+pBe8A/xajWisNb6EBbdTIZ1RgtsPdebbpx
 GwVwoWCgOiEDnTh0UrmkOZTlwxgNzTwBmbwVNxaIrVXO6LZSN6uSir7EyPHKnkxERnRC
 LbxQ==
X-Gm-Message-State: AHQUAuYmOcDawDezjCfkaXxOcGpvD4YgR85dVPSrj9+bbLkYvkqZSLCv
 vUfhQTV/+qwG2PNId2Vm2o1rsLJ//cJpj4cYg34=
X-Google-Smtp-Source: AHgI3IYgzEsuQzvH6dc2DoraxDM8oGBy7z42HMhXISwot50qzJopFtH5pepH5YmLuB6peCXhpm/y5OuZnaTTwEyBHRk=
X-Received: by 2002:aca:550f:: with SMTP id j15mr9224180oib.145.1550350145660; 
 Sat, 16 Feb 2019 12:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20190215050957.20755-1-anarsoul@gmail.com>
 <20190215050957.20755-9-anarsoul@gmail.com>
 <20190216204327.GB22791@ravnborg.org>
In-Reply-To: <20190216204327.GB22791@ravnborg.org>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Sat, 16 Feb 2019 12:48:39 -0800
Message-ID: <CA+E=qVdtSsYd3YadDT3Biie4mDDLp3gi9yC4i+wf=RCVjMdbKQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] drm/panel: simple: Add BOE HB140WX1-501 panel
 support
To: Sam Ravnborg <sam@ravnborg.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_124907_076045_DC492E26 
X-CRM114-Status: GOOD (  26.55  )
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
 Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-sunxi <linux-sunxi@googlegroups.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <seanpaul@chromium.org>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 16, 2019 at 12:43 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Vasily.

Hi Sam,

> On Thu, Feb 14, 2019 at 09:09:54PM -0800, Vasily Khoruzhick via dri-devel wrote:
> > This commit adds support for the BOE HB140WX1-501 14" WXGA TFT LCD
> > panel.
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  .../display/panel/boe,hb140wx1-501.txt        |  7 +++++
> >  drivers/gpu/drm/panel/panel-simple.c          | 26 +++++++++++++++++++
> >  2 files changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/boe,hb140wx1-501.txt
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/boe,hb140wx1-501.txt b/Documentation/devicetree/bindings/display/panel/boe,hb140wx1-501.txt
> > new file mode 100644
> > index 000000000000..fc6f085eb8d1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/boe,hb140wx1-501.txt
> > @@ -0,0 +1,7 @@
> > +BOE HB140WX1-501 14" WXGA (1366x768) TFT LCD panel
> > +
> > +Required properties:
> > +- compatible: should be "boe,hb140wx1-501"
> > +
> > +This binding is compatible with the simple-panel binding, which is specified
> > +in simple-panel.txt in this directory.
>
> boe must be added to vendor-prefixes.txt
> (It is not present in the file I checked, but I may have been added later)

It's been there for quite a while, it's added in 27d23b30a561b which
was included
in 4.5.

> It is usual practice to split the patch in a dt-bindings: patch and a driver patch.
> And for the dt-bindings patch follow the submission rules laid out
> in Documentation/devicetree/bindings/submitting-patches.txt

I checked git log for drivers/gpu/drm/panel/panel-simple.c and looks
like recent commits
for this file added binding and timings in a single commit. I can
split it into separate file
if maintainers insist though.

> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index 9c69e739a524..9a4c9dd02c6c 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -828,6 +828,29 @@ static const struct panel_desc bananapi_s070wv20_ct16 = {
> >       },
> >  };
> >
> > +static const struct drm_display_mode boe_hb140wx1_mode = {
> > +     .clock = 72300,
> > +     .hdisplay = 1366,
> > +     .hsync_start = 1366 + 48,
> > +     .hsync_end = 1366 + 48 + 32,
> > +     .htotal = 1366 + 48 + 32 + 80,
> > +     .vdisplay = 768,
> > +     .vsync_start = 768 + 3,
> > +     .vsync_end = 768 + 3 + 6,
> > +     .vtotal = 768 + 3 + 6 + 13,
> > +     .vrefresh = 60,
> > +     .flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC,
>
> +1 for specifying .flags.
>
> > +};
> > +
> > +static const struct panel_desc boe_hb140wx1 = {
> > +     .modes = &boe_hb140wx1_mode,
> > +     .num_modes = 1,
> > +     .size = {
> > +             .width = 310,
> > +             .height = 170,
> > +     },
> > +};
> No .bus_format and no .bus_flags specified.
> Are they not used by this panel or are you lucky and the default works?

This is eDP panel, it doesn't need bus_format or bus_flags.

> > +
> >  static const struct drm_display_mode boe_hv070wsa_mode = {
> >       .clock = 42105,
> >       .hdisplay = 1024,
> > @@ -2541,6 +2564,9 @@ static const struct of_device_id platform_of_match[] = {
> >       }, {
> >               .compatible = "bananapi,s070wv20-ct16",
> >               .data = &bananapi_s070wv20_ct16,
> > +     }, {
> > +             .compatible = "boe,hb140wx1-501",
> > +             .data = &boe_hb140wx1
> It is common practice to end the line with a "," so one do not need to modify
> this line if an extra line is required.

OK, will do.

>
> With the comments addressed you can add my:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
