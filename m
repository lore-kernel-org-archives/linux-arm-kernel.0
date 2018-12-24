Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF834C64E79
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:28:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAEA821850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eU53q21m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SkxsVMh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAEA821850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7no6kKYMPTrtxWs2SlQl5WbfLfM3P9eFmKXkpikWRb0=; b=eU53q21mB0t0Gs
	t2Y1sfuwLpuZPe/1rQOyUUSFSVRnuEMvXcGXdQHeYDrWtSnQdIishoAq9mO3DB3XYQUD9r7q9NtbC
	9dz/rTfJPf5wca9okVBGMNQzatjLS6gsCnCzgUzJNFMNKf7Fj7/AO3spnXlfs9wjeAUNgU99zslU2
	F+z+0+FMT3k2mn6WGE19XdXH+kNIUSZsIG/zx+Xfmvl9IXVaZl6LDxltHsx3YBycLP1XN3uUHVTej
	SVgZVsJE8FsmhIWc2U8nfQVMiPOIPROrqtfyoaU/6vMg5C40KdcdxMCh510hFyDdprZez/IJjkrU6
	MgO9PIhT3/CxPCRRNSkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbS9P-00047B-Hq; Mon, 24 Dec 2018 15:28:15 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbS9L-00045Q-Pv
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 15:28:13 +0000
Received: by mail-it1-x144.google.com with SMTP id c9so15589206itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 07:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o8tFLUInbXHibbCYw7eDlsLhwmt/Wjuw9trTBiCH0us=;
 b=SkxsVMh2n0xaPgUae+EG2EPNwW2ZaMW5ulQze3TDyehvL360dWxdg+NT2TVoZwSsqE
 rNcKiRkKJZYeM3ymFzwgD5786lzl7ijniL3/NAl2W+7MmBSwMF4l85pHREdFfXhIc1vu
 7RJ2Eb9kpBdce1ajD5iWzwsZoJ5WSTxIzfpyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o8tFLUInbXHibbCYw7eDlsLhwmt/Wjuw9trTBiCH0us=;
 b=mYmA7j9+8FrGb0oM70QyVP4UHE/XJlINEyM0wHYiNk1XUNgZHyNkyjSdc67jkB4543
 8AmDERg2WW7ZXx1aJzbq0B9zIkLdbidnW7ao3uAkb/BOa2aatHmagdLGzMQC/lAjT7+7
 KCFWvN5TB9/5kYgresa9PpqXSBgvcNXyajmnYNhtrGt12j6mPSiUacEXHTbKWmoDegMH
 MTUPYQVL9xNKuCHf2nsiIfUUIDCkcfmDkAwQg1tQADY/M/JM1HLEcX2Qg3T7A7+Gz64T
 xyUp1V9F8Jm8bO3hgKciE/e53khlmy7vF5vDrjnuBXmLXPD1NJVZuLksAdx2YTvBM0qR
 IL6w==
X-Gm-Message-State: AA+aEWYwcP3T8xXtmLfYP6SDdvgVy95xTcFvBq1UpButbrcxx3x5X3CN
 Ubb3rmLLr1eJxaQY0jrlvVXzilqskjE/6/qSfLCquezCDY6f5g==
X-Google-Smtp-Source: AFSGD/WO3CnPpXDVvviza+jO+lm2xfrOpdhPRJD2vY90UqIGUSBspwdwDs2S3DEvSVR9umJh3hGAo1J99AcemiDjly0=
X-Received: by 2002:a02:104a:: with SMTP id 71mr8065981jay.103.1545665280114; 
 Mon, 24 Dec 2018 07:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20181220125438.11700-1-jagan@amarulasolutions.com>
 <20181220125438.11700-3-jagan@amarulasolutions.com>
 <20181221130025.lbvw7yvy74brf3jn@flea>
In-Reply-To: <20181221130025.lbvw7yvy74brf3jn@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 24 Dec 2018 20:57:48 +0530
Message-ID: <CAMty3ZCG5cF3tP2mid5xyS=yhtxkY+TOcGkwRkv+vrZt1=0iQg@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] media: sun6i: Add mod_rate quirk
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_072811_897156_B520856F 
X-CRM114-Status: GOOD (  20.43  )
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

On Fri, Dec 21, 2018 at 6:30 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Dec 20, 2018 at 06:24:34PM +0530, Jagan Teki wrote:
> > Unfortunately default CSI_SCLK rate cannot work properly to
> > drive the connected sensor interface, particularly on few
> > Allwinner SoC's like A64.
> >
> > So, add mod_rate quirk via driver data so-that the respective
> > SoC's which require to alter the default mod clock rate can assign
> > the operating clock rate.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 34 +++++++++++++++----
> >  1 file changed, 28 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > index ee882b66a5ea..fe002beae09c 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/ioctl.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/regmap.h>
> > @@ -28,8 +29,13 @@
> >
> >  #define MODULE_NAME  "sun6i-csi"
> >
> > +struct sun6i_csi_variant {
> > +     unsigned long                   mod_rate;
> > +};
> > +
> >  struct sun6i_csi_dev {
> >       struct sun6i_csi                csi;
> > +     const struct sun6i_csi_variant  *variant;
> >       struct device                   *dev;
> >
> >       struct regmap                   *regmap;
> > @@ -822,33 +828,43 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
> >               return PTR_ERR(sdev->clk_mod);
> >       }
> >
> > +     if (sdev->variant->mod_rate)
> > +             clk_set_rate_exclusive(sdev->clk_mod, sdev->variant->mod_rate);
> > +
>
> It still doesn't make any sense to do it in the probe function...

I'm not sure we discussed about the context wrt probe, we discussed
about exclusive put clock. Since clocks were enabling in set_power and
clock rate can be set during probe in single time instead of setting
it in set_power for every power enablement. anything wrong with that.

>
> We discussed this in the previous iteration already.
>
> What we didn't discuss is the variant function that you introduce,
> while the previous approach was enough.

We discussed about clk_rate_exclusive_put, and that even handle it in
.remove right? so I have variant to handle it in sun6i_csi_remove.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
