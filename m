Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4739BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:18:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA23218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="akpJ6iB3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gFD87IvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA23218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3mlU+hXXMnvLFnX0tI1lnWJm33P5ReKid3S4CvoWvqA=; b=akpJ6iB3yu3pvO
	Y5ikXOFENbwK+NJoGYWTSZVk/X+IUXno77IPSIpo/ODDVSn/sBBbPU5d5Zb/frKGdYQhsMxR8CVuv
	0owldW4ze3BbhahNofPQYAoGyr9VWfDvx6TBbDsiBj4av/OvJb+6GwuVFZ/fAZJ7g0KNkxnseH7Kz
	9/CVmVpQRtuM3EUStOXqlUmHrw9oRQmWtGuf6BxFhR+BHz46PzvsNr1JRqhs7a/lcpO3JvhbyNLyJ
	HkgJdJfo7eF+l3X9Thg3mEVL9kwbkijx/Q7PBF6ROPpW2tpXnL+JcoXyEXnfkhXLcZGxnAtc1F4Xu
	8bzkTlDZ3mIhy+aqbUfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpBID-00072O-EM; Thu, 31 Jan 2019 12:18:05 +0000
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpBI9-00071n-IQ
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 12:18:03 +0000
Received: by mail-ua1-x943.google.com with SMTP id d21so935857uap.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 04:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rMkf0gd68B0VNf8LFPErOfYHBzTvWTZG+O/rTFihV4I=;
 b=gFD87IvTWMiYTaX30KLruBsENu70SjUoCtKw7J911orOOt5Ddm9wDSyGsu1pVrMfHX
 y/O4khowAnb+sz2/xFi9VudhcqfKlOXfD3vQU92jqLcJwmOjRlCgYwN3fA6/nJDbjspr
 nGO9f+MyuxEniJsWS+nnG/DLp6MtBSrNaP1uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rMkf0gd68B0VNf8LFPErOfYHBzTvWTZG+O/rTFihV4I=;
 b=D6xDDG4G0cEZLFXG1qbEaQBxA3Qh1UFubVtSoJ02w79hxdnXxt3onYj2XKU0WNd1Pj
 ScrWgkKoxHz5bcdQaJiDZuIfzfdYRyMsCDITyVbFgBaubyxwHXwDQeTqC2HwbzDdyi5F
 jRJp9O1vIpEI7BWh1v45uV3osOj9+/JVwe0DSQrIwvvIlyWOvFdvYegOdkGl3SuApm0D
 dggpwPWqHFHfruPoRJ6vWdv1nLy7445BaSvELxmYMv6HmQZQfB5Gv/XsxwKNMzrmNy/y
 aEr4SR92ZAMWCwfGyNTYT6LyBVvYXOINDN3iyYfitIKDY5aXEiWXeEpctL8UnK58Oiog
 7euw==
X-Gm-Message-State: AJcUukdwQEUQ7MggdjeUfJpKwL3WNkfrPeLCcqNURNL3EHxzGgoIBy1Y
 Rn2yrlrbEPNzOky4XVq1NgMc8SoutitOguxzrIGQbQ==
X-Google-Smtp-Source: ALg8bN7ktqEXXIqjs7dcG1Y5IfwWm3F6nAamftV06uNn09EaLKy7ATV1Khoz1PWYVxgTRgaGBfqQgHkmoLD4xBww2dc=
X-Received: by 2002:ab0:31d5:: with SMTP id e21mr14563931uan.107.1548937079489; 
 Thu, 31 Jan 2019 04:17:59 -0800 (PST)
MIME-Version: 1.0
References: <20190128144119.10092-1-martink@posteo.de>
 <CAPDyKFo7949rcxEX5U2QUS0c2xhC_z+JGeOiF2HC6+QukVpEaQ@mail.gmail.com>
 <20190131092006.363d1dd4@erd987>
In-Reply-To: <20190131092006.363d1dd4@erd987>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 31 Jan 2019 13:17:23 +0100
Message-ID: <CAPDyKFr=kcoGK0C2A8JH-nhfgUgoRVa-E=6KPRjFO51QQxjJLA@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: mxs-mmc: Introduce regulator support
To: Robin van der Gracht <robin@protonic.nl>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_041801_612327_30A01084 
X-CRM114-Status: GOOD (  27.78  )
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Martin Kepplinger <martin.kepplinger@ginzinger.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Martin Kepplinger <martink@posteo.de>,
 Shawn Guo <shawnguo@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 31 Jan 2019 at 09:20, Robin van der Gracht <robin@protonic.nl> wrote:
>
> On Mon, 28 Jan 2019 22:15:23 +0100
> Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > On Mon, 28 Jan 2019 at 15:41, Martin Kepplinger <martink@posteo.de> wrote:
> > >
> > > From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> > >
> > > This adds support for explicitly switching the mmc's power on and off
> > > which is needed for example for WL1837 WL1271 wifi controllers on imx28.
> > >
> > > While the wifi's vmmc-supply regulator can be configured in devicetree,
> > > "ip link set wlan0 down" doesn't turn off the VMMC regulator which leads
> > > to hangs when loading firmware, for example.
> > >
> > > Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> > > ---
> > >
> > >
> > > revision history
> > > ----------------
> > > v4: re-added forgotten regulator_enable() during probe
> > > v3: improve API usage as suggested by Ulf
> > > v2: tested patch with changes suggested by Robin
> > > v1: question, why https://patchwork.kernel.org/patch/4365751/ didn't get in
> > >
> > >
> > >  drivers/mmc/host/mxs-mmc.c | 34 +++++++++++++++++++++++++---------
> > >  1 file changed, 25 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> > > index add1e70195ea..23d275269d61 100644
> > > --- a/drivers/mmc/host/mxs-mmc.c
> > > +++ b/drivers/mmc/host/mxs-mmc.c
> > > @@ -517,6 +517,22 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > >         else
> > >                 host->bus_width = 0;
> > >
> > > +       switch (ios->power_mode) {
> > > +       case MMC_POWER_OFF:
> > > +               if (!IS_ERR(host->mmc->supply.vmmc))
> > > +                       mmc_regulator_set_ocr(host->mmc,
> > > +                                             host->mmc->supply.vmmc, 0);
> > > +               break;
> > > +       case MMC_POWER_UP:
> > > +               if (!IS_ERR(host->mmc->supply.vmmc))
> > > +                       mmc_regulator_set_ocr(host->mmc,
> > > +                                             host->mmc->supply.vmmc,
> > > +                                             ios->vdd);
> > > +               break;
> > > +       default:
> > > +               break;
> > > +       }
> > > +
> > >         if (ios->clock)
> > >                 mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
> > >  }
> > > @@ -588,7 +604,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
> > >         struct mmc_host *mmc;
> > >         struct resource *iores;
> > >         int ret = 0, irq_err;
> > > -       struct regulator *reg_vmmc;
> > >         struct mxs_ssp *ssp;
> > >
> > >         irq_err = platform_get_irq(pdev, 0);
> > > @@ -614,14 +629,15 @@ static int mxs_mmc_probe(struct platform_device *pdev)
> > >         host->mmc = mmc;
> > >         host->sdio_irq_en = 0;
> > >
> > > -       reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");
> > > -       if (!IS_ERR(reg_vmmc)) {
> > > -               ret = regulator_enable(reg_vmmc);
> > > -               if (ret) {
> > > -                       dev_err(&pdev->dev,
> > > -                               "Failed to enable vmmc regulator: %d\n", ret);
> > > -                       goto out_mmc_free;
> > > -               }
> > > +       ret = mmc_regulator_get_supply(mmc);
> > > +       if (ret == -EPROBE_DEFER)
> > > +               goto out_mmc_free;
> > > +
> > > +       ret = regulator_enable(mmc->supply.vmmc);
> >
> > This is wrong, as it may cause the regulator usage count to become
> > wrongly balanced.
> >
> > Instead, via ->set_ios() when calling mmc_regulator_set_ocr(), it will
> > take care of enabling and disabling the regulator depending of the
> > requested vdd voltage level.
> >
> > > +       if (ret) {
> > > +               dev_err(&pdev->dev,
> > > +                       "Failed to enable vmmc regulator: %d\n", ret);
> > > +               goto out_mmc_free;
> > >         }
> > >
> > >         ssp->clk = devm_clk_get(&pdev->dev, NULL);
> > > --
> > > 2.20.1
> > >
> >
> > BTW, you didn't really answer my earlier question about the TI WiFi
> > chip. Doesn't you need a special clock for WiFi chip as well? How do
> > you intend to manage that?
>
> I used an external 32K oscillator (SLOW_CLK) for my wl1271. Other
> clocks ware generated on the module.

Right. How do you control that clock? Did you model it as clock via
the common clock framework?

>
> I had to supply a 'vmmc-supply' in your wl1271 devicetree node,
> which will be used to power on/off the wlan module. The supply should
> be a (delayed) GPIO controlled 'fixed-regulator' attached to the
> wlan_en pin on the module.

Right, thanks for explaining.

>
> 1: Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt
>

This sounds like a good fit for mmc pwrseq simple. There are already
similar users for it.

Have a look at: /drivers/mmc/core/pwrseq*
If the mmc host driver calls mmc_of_parse() during ->probe(), a pwrseq
instance will be hooked up to it. Once the mmc core tries to power up
the card it will make use of the attached pwrseq for the mmc host in
question.

In this way, you can control the clock and GPIO line, in more exact
ways that is needed by the WiFi chip.

Here is a DT example (look for "mmc-pwrseq-simple"):
arch/arm/boot/dts/imx6qdl-sr-som-ti.dtsi

This should do the trick for you. On the other hand, I don't mind that
you still add regulator support to the driver, along the lines of what
$subject patch does, however it may not be exactly what you need for
the WiFi case.

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
