Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC71C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:23:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 260B920881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f5cdVjwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260B920881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PiJyR8JDn1Huy9IB6i5oF68tRmcjj9S+jkoTjiNfAJM=; b=f5cdVjwTNjqeKp
	Rj0YmFqIAcf4hAHeM1QObpBVk2xcZdHobfBQnUXyM5IQ5MmdkVkuXyeloAHulNHOYs9Kg/seSHqfu
	5OCSdzAsc23s6754R28n2XX+AaGrV9jjfJARAajXmdY7JvuLXh6easj5DflAJ9oe1Q+msz0oqdCux
	XM6NIMcW5GecifJsZiTxn3vUDKlF4s1FbBB5CSglNyar8Ow7eGBOIoz03iu021nemj+VpK3nB3Uat
	vAinkGpioNRgcfGYPYgmdZb23Lt9zR5S0APov9t1gQSSarYT+9dm5K+ZcrtCXJS1mSGnDPr/6xtRz
	Z8S6GorN2TmRGQmhKNCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp7cs-0003E4-7g; Thu, 31 Jan 2019 08:23:10 +0000
Received: from protonic.xs4all.nl ([83.163.252.89] helo=protonic.nl)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp7a0-0007c4-SS
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 08:20:36 +0000
Received: from erd987 (unknown [192.168.2.69])
 by sparta (Postfix) with ESMTP id AB3D244A0058;
 Thu, 31 Jan 2019 09:21:21 +0100 (CET)
Date: Thu, 31 Jan 2019 09:20:06 +0100
From: Robin van der Gracht <robin@protonic.nl>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4] mmc: mxs-mmc: Introduce regulator support
Message-ID: <20190131092006.363d1dd4@erd987>
In-Reply-To: <CAPDyKFo7949rcxEX5U2QUS0c2xhC_z+JGeOiF2HC6+QukVpEaQ@mail.gmail.com>
References: <20190128144119.10092-1-martink@posteo.de>
 <CAPDyKFo7949rcxEX5U2QUS0c2xhC_z+JGeOiF2HC6+QukVpEaQ@mail.gmail.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_002013_690415_5217B73E 
X-CRM114-Status: GOOD (  21.65  )
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

On Mon, 28 Jan 2019 22:15:23 +0100
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On Mon, 28 Jan 2019 at 15:41, Martin Kepplinger <martink@posteo.de> wrote:
> >
> > From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> >
> > This adds support for explicitly switching the mmc's power on and off
> > which is needed for example for WL1837 WL1271 wifi controllers on imx28.
> >
> > While the wifi's vmmc-supply regulator can be configured in devicetree,
> > "ip link set wlan0 down" doesn't turn off the VMMC regulator which leads
> > to hangs when loading firmware, for example.
> >
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> > ---
> >
> >
> > revision history
> > ----------------
> > v4: re-added forgotten regulator_enable() during probe
> > v3: improve API usage as suggested by Ulf
> > v2: tested patch with changes suggested by Robin
> > v1: question, why https://patchwork.kernel.org/patch/4365751/ didn't get in
> >
> >
> >  drivers/mmc/host/mxs-mmc.c | 34 +++++++++++++++++++++++++---------
> >  1 file changed, 25 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> > index add1e70195ea..23d275269d61 100644
> > --- a/drivers/mmc/host/mxs-mmc.c
> > +++ b/drivers/mmc/host/mxs-mmc.c
> > @@ -517,6 +517,22 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >         else
> >                 host->bus_width = 0;
> >
> > +       switch (ios->power_mode) {
> > +       case MMC_POWER_OFF:
> > +               if (!IS_ERR(host->mmc->supply.vmmc))
> > +                       mmc_regulator_set_ocr(host->mmc,
> > +                                             host->mmc->supply.vmmc, 0);
> > +               break;
> > +       case MMC_POWER_UP:
> > +               if (!IS_ERR(host->mmc->supply.vmmc))
> > +                       mmc_regulator_set_ocr(host->mmc,
> > +                                             host->mmc->supply.vmmc,
> > +                                             ios->vdd);
> > +               break;
> > +       default:
> > +               break;
> > +       }
> > +
> >         if (ios->clock)
> >                 mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
> >  }
> > @@ -588,7 +604,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
> >         struct mmc_host *mmc;
> >         struct resource *iores;
> >         int ret = 0, irq_err;
> > -       struct regulator *reg_vmmc;
> >         struct mxs_ssp *ssp;
> >
> >         irq_err = platform_get_irq(pdev, 0);
> > @@ -614,14 +629,15 @@ static int mxs_mmc_probe(struct platform_device *pdev)
> >         host->mmc = mmc;
> >         host->sdio_irq_en = 0;
> >
> > -       reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");
> > -       if (!IS_ERR(reg_vmmc)) {
> > -               ret = regulator_enable(reg_vmmc);
> > -               if (ret) {
> > -                       dev_err(&pdev->dev,
> > -                               "Failed to enable vmmc regulator: %d\n", ret);
> > -                       goto out_mmc_free;
> > -               }
> > +       ret = mmc_regulator_get_supply(mmc);
> > +       if (ret == -EPROBE_DEFER)
> > +               goto out_mmc_free;
> > +
> > +       ret = regulator_enable(mmc->supply.vmmc);  
> 
> This is wrong, as it may cause the regulator usage count to become
> wrongly balanced.
> 
> Instead, via ->set_ios() when calling mmc_regulator_set_ocr(), it will
> take care of enabling and disabling the regulator depending of the
> requested vdd voltage level.
> 
> > +       if (ret) {
> > +               dev_err(&pdev->dev,
> > +                       "Failed to enable vmmc regulator: %d\n", ret);
> > +               goto out_mmc_free;
> >         }
> >
> >         ssp->clk = devm_clk_get(&pdev->dev, NULL);
> > --
> > 2.20.1
> >  
> 
> BTW, you didn't really answer my earlier question about the TI WiFi
> chip. Doesn't you need a special clock for WiFi chip as well? How do
> you intend to manage that?

I used an external 32K oscillator (SLOW_CLK) for my wl1271. Other
clocks ware generated on the module.

I had to supply a 'vmmc-supply' in your wl1271 devicetree node,
which will be used to power on/off the wlan module. The supply should
be a (delayed) GPIO controlled 'fixed-regulator' attached to the
wlan_en pin on the module.

1: Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt

Kind regards,

-- 
Robin van der Gracht
Protonic Holland
tel.: +31 (0) 229 212928
fax.: +31 (0) 229 210930
Factorij 36 / 1689 AL Zwaag

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
