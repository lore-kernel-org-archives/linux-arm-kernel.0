Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB71FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:34:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AEB820657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fP3ZTvDM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KZFPWe/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AEB820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i8EEujrC3myIWf+1XWUSDSmtZOs2z6S5CMsr6ebpm5Y=; b=fP3ZTvDMd4FrZ3
	KW0+O8kf4eccTn9+VQB0e17xgtgAq8yQ5KuTUyLikBnnShtbetgBoZTmAkqOdnz9jvmMsjjjOH166
	ZxClmgbbkJ7bInDKr1l/ktMPAVNm4sg3IzMZwHwEtA1fqArcjvRcZIMRpifeeeX3nYkx7u4WpY0iD
	I2Xxf06hu5YtRr+8eHeDaTbRJdyQ184YDfMJ3/zrMg2EycH+UG8PL2w8Kbs1UhMnD4PfRKsPzhPGd
	LlZS4VtQCbygseQaIeu0eHS32dC3Y4uXQfz5+gYlMOMiMUbzZ++71BiFDjWqals9Tod8N6Ar3L32X
	CL82snKR1kyExtgRf+hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjzNn-0001UA-71; Thu, 17 Jan 2019 04:34:23 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjzNk-0001Tk-Iz
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 04:34:22 +0000
Received: by mail-it1-x141.google.com with SMTP id h65so6027976ith.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 20:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ncfqnoSxbMnH+Fh+JaP/u+vtHVJmV/Txi/tk5jsE1wU=;
 b=KZFPWe/iqDMTX1Z0rZuglCSYugvqmZAr8uYaIvWOq+aCivOr8RSzEAm9MACZm2SV7B
 oqiSM4j2jtsbo+jBocrC7Px31uIXaSmdXGV54ycyG/qaBU0kRt7nqwcyKcEnD4H9FzVt
 9SqzRQ5uOHSkOfL8XVsx+4P142FN14EZA3eb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ncfqnoSxbMnH+Fh+JaP/u+vtHVJmV/Txi/tk5jsE1wU=;
 b=jiHcIGAaYNyoHD+wjLW9oMyC5lvQDaw9VL6yshbuksn8LD+7qQFKfzyCpWNUImlexr
 f68WMnPuNf9xFP5pCN0UCyiJdCyqZ99jlxqSuz2Bw/eNCkm/dEkdUJpqMyiyz7teVOB/
 kZZqUxY6z5dUSvfNOAe8OJ0Fjq59wcKzOaC5dRON+x6fDiei3TGpDQDwJ5aDq93TwEDc
 AWz0sSEyWmwPixOCkae5ieTeVSFBc0HP2y4un8CmanCovoNDAK9XYARu/7+EjwtzCvQ6
 DO+LcJMlLHOJO/tWyK2/HWqqLjy9+uCPCmPXDftCfl2nA+c7fvFz7DcSwNP653FEDB7F
 AOfw==
X-Gm-Message-State: AJcUukeB3+ZXN2dJEAOT+KqkZt4xIc8d8iQk8gqLC0Ld9DESQOTV9xKL
 VIr5N/NP/4awrwyl5qh88WKJXJdn3doY7iRrXG4Eng==
X-Google-Smtp-Source: ALg8bN7PY+YyWWjnAskyUKb7H5PgEJxwvAQCMXiyFS7v4t4l7nbNcfqbkzzCuTUHsVmk+k7DWGxgb01bYWne72CtBwI=
X-Received: by 2002:a02:4d99:: with SMTP id t25mr7459772jad.58.1547699659321; 
 Wed, 16 Jan 2019 20:34:19 -0800 (PST)
MIME-Version: 1.0
References: <20181220125438.11700-1-jagan@amarulasolutions.com>
 <20181220125438.11700-3-jagan@amarulasolutions.com>
 <20181221130025.lbvw7yvy74brf3jn@flea>
 <CAMty3ZCG5cF3tP2mid5xyS=yhtxkY+TOcGkwRkv+vrZt1=0iQg@mail.gmail.com>
 <20190107132929.ksyajmzn2gzr6oep@flea>
 <CAMty3ZAx9MthB0M-eFmsZv9CxF3Z1BkFTU6Hw=ZT5wu6aJwjGQ@mail.gmail.com>
 <20190116111109.dkc4zgsz6lcjlzs5@flea>
In-Reply-To: <20190116111109.dkc4zgsz6lcjlzs5@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 17 Jan 2019 10:04:08 +0530
Message-ID: <CAMty3ZDVMW_BRmBgqjHWbkQF7P7T81Z5q3er9mBiJeeEVBZWXQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] media: sun6i: Add mod_rate quirk
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_203420_627023_D81CFE04 
X-CRM114-Status: GOOD (  25.04  )
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

On Thu, Jan 17, 2019 at 12:48 AM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Fri, Jan 11, 2019 at 11:54:12AM +0530, Jagan Teki wrote:
> > On Mon, Jan 7, 2019 at 6:59 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > On Mon, Dec 24, 2018 at 08:57:48PM +0530, Jagan Teki wrote:
> > > > On Fri, Dec 21, 2018 at 6:30 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > >
> > > > > On Thu, Dec 20, 2018 at 06:24:34PM +0530, Jagan Teki wrote:
> > > > > > Unfortunately default CSI_SCLK rate cannot work properly to
> > > > > > drive the connected sensor interface, particularly on few
> > > > > > Allwinner SoC's like A64.
> > > > > >
> > > > > > So, add mod_rate quirk via driver data so-that the respective
> > > > > > SoC's which require to alter the default mod clock rate can assign
> > > > > > the operating clock rate.
> > > > > >
> > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > ---
> > > > > >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 34 +++++++++++++++----
> > > > > >  1 file changed, 28 insertions(+), 6 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > > > index ee882b66a5ea..fe002beae09c 100644
> > > > > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > > > @@ -15,6 +15,7 @@
> > > > > >  #include <linux/ioctl.h>
> > > > > >  #include <linux/module.h>
> > > > > >  #include <linux/of.h>
> > > > > > +#include <linux/of_device.h>
> > > > > >  #include <linux/platform_device.h>
> > > > > >  #include <linux/pm_runtime.h>
> > > > > >  #include <linux/regmap.h>
> > > > > > @@ -28,8 +29,13 @@
> > > > > >
> > > > > >  #define MODULE_NAME  "sun6i-csi"
> > > > > >
> > > > > > +struct sun6i_csi_variant {
> > > > > > +     unsigned long                   mod_rate;
> > > > > > +};
> > > > > > +
> > > > > >  struct sun6i_csi_dev {
> > > > > >       struct sun6i_csi                csi;
> > > > > > +     const struct sun6i_csi_variant  *variant;
> > > > > >       struct device                   *dev;
> > > > > >
> > > > > >       struct regmap                   *regmap;
> > > > > > @@ -822,33 +828,43 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
> > > > > >               return PTR_ERR(sdev->clk_mod);
> > > > > >       }
> > > > > >
> > > > > > +     if (sdev->variant->mod_rate)
> > > > > > +             clk_set_rate_exclusive(sdev->clk_mod, sdev->variant->mod_rate);
> > > > > > +
> > > > >
> > > > > It still doesn't make any sense to do it in the probe function...
> > > >
> > > > I'm not sure we discussed about the context wrt probe, we discussed
> > > > about exclusive put clock.
> > >
> > > https://lkml.org/lkml/2018/12/18/584
> > >
> > > "Doing it here is not really optimal either, since you'll put a
> > > constraint on the system (maintaining that clock at 300MHz), while
> > > it's not in use."
> >
> > But this constraint is only set, for SoC's who need mod_rate change
> > not for whole SoCs.
>
> Still, that constraint is there for the whole system on affected
> SoCs. Whether it applies to one SoC or not is not really relevant.

OK, please see this code change and let me know the comments.

https://gist.github.com/openedev/518b9e141f53814bb3adfac6f2bfd78c

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
