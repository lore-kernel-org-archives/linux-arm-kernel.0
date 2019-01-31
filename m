Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B467CC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:09:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85EF820881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I8n7Ylgt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EF820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3TAgHTmtI02fA6Vo3boiu6KXJcHOik2K8+cV8f7Q7Gs=; b=I8n7YlgtHB2QuE
	ccUDH+n85k+/GhZz8Ic3BklP/pACnDoAKzW0VAFbN3qafseN32xW+YGg6vpISsZGxHLi7/IqMOa2O
	CwKA3W7my4ueQHy2RLK8DtBxex9JwvVwlIB8y52YRttpBNe44XO/ZjfRhTB6INt1aTSOAZdOJ10WF
	edcTzXwSUyv3A8kV9k2Dpx3c7VPKjXdnnaaTMzq4luIV+bW3pKE/up4xsnbuh0YwZmDNFfX1WFb1j
	fSyBVdQOEdY4o//awJP0v6dEe+x6kiHJ7VQRB2RHGcDIYC6vgvzh7QssKXLLt/NDzsfPafozYpdd8
	4BxYhihiRunnTko8NFsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpC64-0006Y7-Dy; Thu, 31 Jan 2019 13:09:36 +0000
Received: from protonic.xs4all.nl ([83.163.252.89] helo=protonic.nl)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpC60-0006Xg-Hb
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:09:34 +0000
Received: from erd987 (erd987.prtnl [192.168.237.3])
 by sparta (Postfix) with ESMTP id CF06144A0058;
 Thu, 31 Jan 2019 14:10:45 +0100 (CET)
Date: Thu, 31 Jan 2019 14:09:30 +0100
From: Robin van der Gracht <robin@protonic.nl>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4] mmc: mxs-mmc: Introduce regulator support
Message-ID: <20190131140930.05c5b6a5@erd987>
In-Reply-To: <CAPDyKFr=kcoGK0C2A8JH-nhfgUgoRVa-E=6KPRjFO51QQxjJLA@mail.gmail.com>
References: <20190128144119.10092-1-martink@posteo.de>
 <CAPDyKFo7949rcxEX5U2QUS0c2xhC_z+JGeOiF2HC6+QukVpEaQ@mail.gmail.com>
 <20190131092006.363d1dd4@erd987>
 <CAPDyKFr=kcoGK0C2A8JH-nhfgUgoRVa-E=6KPRjFO51QQxjJLA@mail.gmail.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_050932_894066_DEAA9A99 
X-CRM114-Status: GOOD (  29.58  )
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

On Thu, 31 Jan 2019 13:17:23 +0100
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On Thu, 31 Jan 2019 at 09:20, Robin van der Gracht <robin@protonic.nl> wrote:
> >
> > On Mon, 28 Jan 2019 22:15:23 +0100
> > Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >  
> > > On Mon, 28 Jan 2019 at 15:41, Martin Kepplinger <martink@posteo.de> wrote:  
> > > >
> > > > From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> > > >
> > > > This adds support for explicitly switching the mmc's power on and off
> > > > which is needed for example for WL1837 WL1271 wifi controllers on imx28.
> > > >
> > > > While the wifi's vmmc-supply regulator can be configured in devicetree,
> > > > "ip link set wlan0 down" doesn't turn off the VMMC regulator which leads
> > > > to hangs when loading firmware, for example.
> > > >
> > > > Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> > > > ---
> > > >
> > > >
> > > > revision history
> > > > ----------------
> > > > v4: re-added forgotten regulator_enable() during probe
> > > > v3: improve API usage as suggested by Ulf
> > > > v2: tested patch with changes suggested by Robin
> > > > v1: question, why https://patchwork.kernel.org/patch/4365751/ didn't get in
> > > >
> > > >
> > > >  drivers/mmc/host/mxs-mmc.c | 34 +++++++++++++++++++++++++---------
> > > >  1 file changed, 25 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> > > > index add1e70195ea..23d275269d61 100644
> > > > --- a/drivers/mmc/host/mxs-mmc.c
> > > > +++ b/drivers/mmc/host/mxs-mmc.c
> > > > @@ -517,6 +517,22 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > > >         else
> > > >                 host->bus_width = 0;
> > > >
> > > > +       switch (ios->power_mode) {
> > > > +       case MMC_POWER_OFF:
> > > > +               if (!IS_ERR(host->mmc->supply.vmmc))
> > > > +                       mmc_regulator_set_ocr(host->mmc,
> > > > +                                             host->mmc->supply.vmmc, 0);
> > > > +               break;
> > > > +       case MMC_POWER_UP:
> > > > +               if (!IS_ERR(host->mmc->supply.vmmc))
> > > > +                       mmc_regulator_set_ocr(host->mmc,
> > > > +                                             host->mmc->supply.vmmc,
> > > > +                                             ios->vdd);
> > > > +               break;
> > > > +       default:
> > > > +               break;
> > > > +       }
> > > > +
> > > >         if (ios->clock)
> > > >                 mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
> > > >  }
> > > > @@ -588,7 +604,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
> > > >         struct mmc_host *mmc;
> > > >         struct resource *iores;
> > > >         int ret = 0, irq_err;
> > > > -       struct regulator *reg_vmmc;
> > > >         struct mxs_ssp *ssp;
> > > >
> > > >         irq_err = platform_get_irq(pdev, 0);
> > > > @@ -614,14 +629,15 @@ static int mxs_mmc_probe(struct platform_device *pdev)
> > > >         host->mmc = mmc;
> > > >         host->sdio_irq_en = 0;
> > > >
> > > > -       reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");
> > > > -       if (!IS_ERR(reg_vmmc)) {
> > > > -               ret = regulator_enable(reg_vmmc);
> > > > -               if (ret) {
> > > > -                       dev_err(&pdev->dev,
> > > > -                               "Failed to enable vmmc regulator: %d\n", ret);
> > > > -                       goto out_mmc_free;
> > > > -               }
> > > > +       ret = mmc_regulator_get_supply(mmc);
> > > > +       if (ret == -EPROBE_DEFER)
> > > > +               goto out_mmc_free;
> > > > +
> > > > +       ret = regulator_enable(mmc->supply.vmmc);  
> > >
> > > This is wrong, as it may cause the regulator usage count to become
> > > wrongly balanced.
> > >
> > > Instead, via ->set_ios() when calling mmc_regulator_set_ocr(), it will
> > > take care of enabling and disabling the regulator depending of the
> > > requested vdd voltage level.
> > >  
> > > > +       if (ret) {
> > > > +               dev_err(&pdev->dev,
> > > > +                       "Failed to enable vmmc regulator: %d\n", ret);
> > > > +               goto out_mmc_free;
> > > >         }
> > > >
> > > >         ssp->clk = devm_clk_get(&pdev->dev, NULL);
> > > > --
> > > > 2.20.1
> > > >  
> > >
> > > BTW, you didn't really answer my earlier question about the TI WiFi
> > > chip. Doesn't you need a special clock for WiFi chip as well? How do
> > > you intend to manage that?  
> >
> > I used an external 32K oscillator (SLOW_CLK) for my wl1271. Other
> > clocks ware generated on the module.  
> 
> Right. How do you control that clock? Did you model it as clock via
> the common clock framework?

No I didn't. The slow clock (sleep clock) was always 'on'.

> 
> >
> > I had to supply a 'vmmc-supply' in your wl1271 devicetree node,
> > which will be used to power on/off the wlan module. The supply should
> > be a (delayed) GPIO controlled 'fixed-regulator' attached to the
> > wlan_en pin on the module.  
> 
> Right, thanks for explaining.
> 
> >
> > 1: Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt
> >  
> 
> This sounds like a good fit for mmc pwrseq simple. There are already
> similar users for it.
> 
> Have a look at: /drivers/mmc/core/pwrseq*
> If the mmc host driver calls mmc_of_parse() during ->probe(), a pwrseq
> instance will be hooked up to it. Once the mmc core tries to power up
> the card it will make use of the attached pwrseq for the mmc host in
> question.
> 
> In this way, you can control the clock and GPIO line, in more exact
> ways that is needed by the WiFi chip.

Ack. Makes more sense than using a regulator (even without specifying
'clocks').

> 
> Here is a DT example (look for "mmc-pwrseq-simple"):
> arch/arm/boot/dts/imx6qdl-sr-som-ti.dtsi
> 
> This should do the trick for you. On the other hand, I don't mind that
> you still add regulator support to the driver, along the lines of what
> $subject patch does, however it may not be exactly what you need for
> the WiFi case.

@Martin; What do you think? Will you work this out with Ulf?
Since I can't test this.

Regards,
Robin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
