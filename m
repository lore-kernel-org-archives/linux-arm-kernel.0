Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9625AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:05:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D26620675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jU0d2zkE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YJ26QTTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D26620675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ANqdbEUvcQdSc1uB6/onrd7e4xNB83sU9wbvMdOGTBE=; b=jU0d2zkEwfy+g7
	hfPdpVvT+/3ZvsEcN7UFEA0Bzvwm8KfFo4DR0Am4MBYgIizYxklt9sGBrDBWg89IZ94epaORGohBO
	KM+ENZ2KBbzSI4Cft2PNN0jithFVaf+kxViKoz9J6QNHL9eHV0d07JkSjqqj0bvXOO0AZcPoqDq5F
	ku/BpLQMQmDmU/OphzxOjAZLNGDhzXfICArvQaWdFclLCdXj00tNLy35f1G8xRDY1VV0y9EQF9DeJ
	taVKpiFWgtuF+qrHYSRTSkl5jL8N2/UWf/jw2t+1iTSf6ORk94GyTCP2TIXvQGyypytfVhAes/31c
	sSq7rAF5gBmInUs6WeyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghpwy-0002ML-KF; Fri, 11 Jan 2019 06:05:48 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghpwt-0002LW-7G
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 06:05:46 +0000
Received: by mail-io1-xd41.google.com with SMTP id b23so11340512ios.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 22:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GMfxBDBj51g4/LgB4KANuC0aezrsIPcZoBlXSsXh8CY=;
 b=YJ26QTTrBb0XvooQeIN7ACUccZBi5iSSXiBEWBE6w/1c+c7Kfw2zXAR2R0AYFUUZ/j
 rXSn1uDg650mfCe8G7UbFvqgB3ooOrJwr6041JGre2T8GU//qmicq8drCEr+GCMGGl2t
 Jd11J7FX6IC+cl0LP6zcYlQTx0Fi+nhVfrwg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GMfxBDBj51g4/LgB4KANuC0aezrsIPcZoBlXSsXh8CY=;
 b=SSraLl3f+rRKeXOqjWYO+T9w3U4p2qKNFMSIlJcTbTFFwaN1fF7svfYMP9TJkL5YI3
 rHYioGQmgmzNUDWQx/lU7PbMT4cVGJXoRwCdagEIlnLnG0YMFkLHwmfsIhbIVmE4z8tk
 SWQOQ1FSH3ProY908AvJB58EQM/TaWZm4X3ok4Po4ovRTgxq3P7IJHgvSyL9riEzh3sa
 LVwM4Q3VckK9JfBu1pGr0lVodYxXnO03JgGKaIT94zSPmOlF6RUeSukIgHSVtwW6A95T
 /AkQlZgxAHRzDN84E6mkC50nRYaD6GK66tT+C6u9eeo+ZaVvnTgZzrJ3axN9QxKOFv1P
 zutw==
X-Gm-Message-State: AJcUukfxaY6cjdjp946mG+g3hQznpRxWZocVjVgKK/2QzE2jVXLmB2OD
 +iqg0Fb5fMb6+FQrR+/RbDu7AUolsW7oatdWn909jg==
X-Google-Smtp-Source: ALg8bN7Z/2+9dpkuuf4RYz9izMExwXaxmaDc2H9xzT2OKgtyn1+UI1D3i4h7W2C6fe3xa/svc/uNAdobR67kWb7/9tg=
X-Received: by 2002:a6b:7a0a:: with SMTP id h10mr8233118iom.114.1547186741145; 
 Thu, 10 Jan 2019 22:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20181220125438.11700-1-jagan@amarulasolutions.com>
 <20181220125438.11700-3-jagan@amarulasolutions.com>
 <20181221130025.lbvw7yvy74brf3jn@flea>
 <CAMty3ZCG5cF3tP2mid5xyS=yhtxkY+TOcGkwRkv+vrZt1=0iQg@mail.gmail.com>
 <20190107132929.ksyajmzn2gzr6oep@flea>
In-Reply-To: <20190107132929.ksyajmzn2gzr6oep@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Fri, 11 Jan 2019 11:35:29 +0530
Message-ID: <CAMty3ZAAa0VEOt50prvEApdNi9tkPe_vFC4oKone0z6pVd_Ziw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] media: sun6i: Add mod_rate quirk
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_220544_539493_76054B9E 
X-CRM114-Status: GOOD (  23.82  )
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
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-amarula@amarulasolutions.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 7, 2019 at 6:59 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Dec 24, 2018 at 08:57:48PM +0530, Jagan Teki wrote:
> > On Fri, Dec 21, 2018 at 6:30 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Thu, Dec 20, 2018 at 06:24:34PM +0530, Jagan Teki wrote:
> > > > Unfortunately default CSI_SCLK rate cannot work properly to
> > > > drive the connected sensor interface, particularly on few
> > > > Allwinner SoC's like A64.
> > > >
> > > > So, add mod_rate quirk via driver data so-that the respective
> > > > SoC's which require to alter the default mod clock rate can assign
> > > > the operating clock rate.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 34 +++++++++++++++----
> > > >  1 file changed, 28 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > index ee882b66a5ea..fe002beae09c 100644
> > > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > @@ -15,6 +15,7 @@
> > > >  #include <linux/ioctl.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/of.h>
> > > > +#include <linux/of_device.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/pm_runtime.h>
> > > >  #include <linux/regmap.h>
> > > > @@ -28,8 +29,13 @@
> > > >
> > > >  #define MODULE_NAME  "sun6i-csi"
> > > >
> > > > +struct sun6i_csi_variant {
> > > > +     unsigned long                   mod_rate;
> > > > +};
> > > > +
> > > >  struct sun6i_csi_dev {
> > > >       struct sun6i_csi                csi;
> > > > +     const struct sun6i_csi_variant  *variant;
> > > >       struct device                   *dev;
> > > >
> > > >       struct regmap                   *regmap;
> > > > @@ -822,33 +828,43 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
> > > >               return PTR_ERR(sdev->clk_mod);
> > > >       }
> > > >
> > > > +     if (sdev->variant->mod_rate)
> > > > +             clk_set_rate_exclusive(sdev->clk_mod, sdev->variant->mod_rate);
> > > > +
> > >
> > > It still doesn't make any sense to do it in the probe function...
> >
> > I'm not sure we discussed about the context wrt probe, we discussed
> > about exclusive put clock.
>
> https://lkml.org/lkml/2018/12/18/584
>
> "Doing it here is not really optimal either, since you'll put a
> constraint on the system (maintaining that clock at 300MHz), while
> it's not in use."
>
> > Since clocks were enabling in set_power and clock rate can be set
> > during probe in single time instead of setting it in set_power for
> > every power enablement. anything wrong with that.
>
> See above.
>
> Plus, a clock running draws power. It doesn't really make sense to
> draw power for something that is unused.

True, but clock is enabled only on sun6i_csi_set_power so setting
clock frequency in probe will draw power?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
