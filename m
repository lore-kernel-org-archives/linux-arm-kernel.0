Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8DAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:24:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FDB320870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SCX+WVGn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Ynn9Dkfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FDB320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tq6AP7qcem3kxAb07QihOxLwErsXAdidu4CMyaYb34w=; b=SCX+WVGnYRR+A/
	/kg0SXvnIQzKyExZo6JNHWUy1JbcXZnQgzf9hcdUXKu0yqojfRkzHpwNlk7qS7aebBmHN99a89D2w
	x9JeFK06/2YHFeg6qQi1Xv3sAiiRfCYAp5ixFkT6oe5gTOWrRx0yxPnD3azBvz39EsQm8FIv4EaNa
	jpgjfRadLHlAvyxmiXy0UA4cL8lPOW7jYdPP1UB+rF7hm6Vg/cB4ILIdrbbZbU/fmBJmUQnzDead0
	T9cr0RpmbuTR9bCQrrDsnpUEujH6yqxyzQ6T/QSx4YyOtUw+9uO2n+bKfmPFSPGRiIsYymC1oUkPK
	576k+V/T0fw18Phcj8Ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghqF3-0000lr-9b; Fri, 11 Jan 2019 06:24:29 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghqEz-0000lS-O4
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 06:24:28 +0000
Received: by mail-it1-x143.google.com with SMTP id g85so790177ita.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 22:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gJBTxb4v6aNsxm5hBskEPEm+rc32O9+aL3CbfwpxPEU=;
 b=Ynn9DkfcKAi8Zk5VfFMybuwlQmrFGBLiBwJQnaH8J5aiMdsFKfm7e+S46C94vNsySy
 LyY90xkAts/ksoisAqfIqgo3EsngC5aBLXwyzSTKjDuiyoZ49hZEj0G61KhjlxQhCVnI
 KK5n5jXZyyz4eIRJzcuvm5pM+PRbXGOXfEdTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gJBTxb4v6aNsxm5hBskEPEm+rc32O9+aL3CbfwpxPEU=;
 b=S/mFglpRWRn5mE00LSO2F2gR5hDG+0Ebka5tbdNI5VkA0ixbqPnXhqqqqVGuxMt1k1
 TC0tavFLgVgmTm3nRQQeAyLYP69Ukqpir5BmfDaoNsfvuqEm3iZjO54rk9V0p7MWxKz8
 lY+Rn/VP8yFGO8TE4dHFr7sfrbNBi5krYt6S4YOlbRiOEaHDhxPgkqda7SSuCkZtj3VR
 J/PoYE3xywmEMRRHk6svQZ+NJe3UOwpdcFA/DaS3zaGGCxauU6IsPgUpoyK2gwWzEM7v
 09goteCdwUfKvttyOYLNheHuNS5YJ1LNHFPEF0CgzroY+Pgd/P6y9rOtA3AAFIb8VSGV
 J8tA==
X-Gm-Message-State: AJcUukeE98mPSJs07C6wyUiQrQgtzDuzfTpkqJ6lGNOZWtoto01BgszP
 VV/KSwtT/NmnOc2HhpEH6bGOv84NAflRnz3S87Pglg==
X-Google-Smtp-Source: ALg8bN4xGvW9WuaqHL4jsgC5EUJFgb4qMdSt2yA+7Mtwx18Hn6iFh4Gh7ASkgVR6Kzng1KlAWJ8uVZcLkQWiPDXWJRA=
X-Received: by 2002:a24:5411:: with SMTP id t17mr373581ita.32.1547187864692;
 Thu, 10 Jan 2019 22:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20181220125438.11700-1-jagan@amarulasolutions.com>
 <20181220125438.11700-3-jagan@amarulasolutions.com>
 <20181221130025.lbvw7yvy74brf3jn@flea>
 <CAMty3ZCG5cF3tP2mid5xyS=yhtxkY+TOcGkwRkv+vrZt1=0iQg@mail.gmail.com>
 <20190107132929.ksyajmzn2gzr6oep@flea>
In-Reply-To: <20190107132929.ksyajmzn2gzr6oep@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Fri, 11 Jan 2019 11:54:12 +0530
Message-ID: <CAMty3ZAx9MthB0M-eFmsZv9CxF3Z1BkFTU6Hw=ZT5wu6aJwjGQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] media: sun6i: Add mod_rate quirk
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_222426_248894_CB0F5038 
X-CRM114-Status: GOOD (  26.82  )
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

But this constraint is only set, for SoC's who need mod_rate change
not for whole SoCs.

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
(sorry same message sent accidentally)

>
> > > We discussed this in the previous iteration already.
> > >
> > > What we didn't discuss is the variant function that you introduce,
> > > while the previous approach was enough.
> >
> > We discussed about clk_rate_exclusive_put, and that even handle it in
> > .remove right? so I have variant to handle it in sun6i_csi_remove.
>
> We indeed discussed the clk_rate_exclusive_put. However, you chose to
> implement it using a variant structure which really isn't needed.

Because clk_rate_exclusive_put will also do it .remove so adding
driver variant with mod_rate can do this job easily. do you have any
suggestion?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
