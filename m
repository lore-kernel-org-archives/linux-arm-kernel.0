Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A0CC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:16:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B242171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="id/ViO6i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQp+v2CJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B242171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tWpTPU26uswerwYx0W5DYrPNKutCLHynH3jlaubYYP0=; b=id/ViO6ivrqtE1
	pEuRGrUBt0iVeCHY2rA9gkwAT8jQr1Qszi0df+0oYYjXm2PerOKLMKbzl+RDoO/NPeU03ogaM1IUV
	VhDkqKDHMGy5tiLeK+75peWG7bz56xrJuiQ7s1uRpSyfJO0qcjYDu8vrxSbUaE3LJKyMIujy+uunh
	G6DDcl/toJy00rvh2i+l5N+P9v2KMjFAvi1BNLW8ZJ3Ksf9wnl/MjAuew8y6XzCX2OhwJTPgP3a7b
	SvBVXeCCPznAKtKmaZFk8+gA3Hi2BO/u7oZJ1aLTXMZnco4whZ4OjpQVQO6lHPj93eSHk/JL2Zpa2
	fbRLR+lQLNPLLKgnt0gQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goEGE-0000mk-N9; Mon, 28 Jan 2019 21:16:06 +0000
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goEGA-0000lu-8x
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 21:16:04 +0000
Received: by mail-vs1-xe42.google.com with SMTP id p74so10696997vsc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 13:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HOWZi8WDscFORR5TiqTg0jfh/8SxjXI1RRBYhheUJAk=;
 b=AQp+v2CJPS3M86L/8dh/3LpqF/uoJMIxcIKq7qfdJl57sv69oP4C3Dl17mr2s0VLIW
 jfHdpmiAtB0KPssie1IzhOKAWBZsoQOQnrGqv8cn6WALbYmQkvGySlcMmr8FyGdxu+pn
 wtNkbDVwEcEO4255bLtJ3FqKOeFYMesR+sZog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HOWZi8WDscFORR5TiqTg0jfh/8SxjXI1RRBYhheUJAk=;
 b=Ra50/s5hpvNcXCgpuiNGRqX3pameqA8aIoTRAhAVTwi4eRD5ujoSbNhYYBUi89gmJE
 nsq2IV9yZ6yK4Ljg50EKQk5ttIShmf2oFaOFUm31u0/1nZytPXERpf1j4bVl3GVB1r/c
 CixG3bE+ROtVu7sn+hMJEJnB10Z3VM5VMQzWUludn/gcd7PL9GUvWS80xC1XkfnD3iIJ
 Pan2es4fIl+4pgYK2QWSUwNGyVsikxtkCA54dddHxu+FsRiwS09LFCJ04pmdjx/6kskO
 LafhUVGymhNXE8m6GyG4VW6mEl7C7nPvghs+xCLIjMRZ167LH4V6/QbppnZVofAAFysq
 hgDQ==
X-Gm-Message-State: AJcUukcCoO3mooNx2ctkE5295493rr0T+POTxQ3N4a8Mbr4U7PffKarf
 LNRTlYVoahjddNsltJzPeAdKUFv0YtPkF5hBmwU9vg==
X-Google-Smtp-Source: ALg8bN4EU+x/ol6qZ8nv5c7gzwZQPGD8aPEroafnbqlFDu4IAQzxlTOWIC/ZOSGAkZKHVlcIRgcjsBGyo9QaOWPu8a0=
X-Received: by 2002:a67:d00f:: with SMTP id r15mr9631601vsi.191.1548710159707; 
 Mon, 28 Jan 2019 13:15:59 -0800 (PST)
MIME-Version: 1.0
References: <20190128144119.10092-1-martink@posteo.de>
In-Reply-To: <20190128144119.10092-1-martink@posteo.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Jan 2019 22:15:23 +0100
Message-ID: <CAPDyKFo7949rcxEX5U2QUS0c2xhC_z+JGeOiF2HC6+QukVpEaQ@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: mxs-mmc: Introduce regulator support
To: Martin Kepplinger <martink@posteo.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_131602_358573_820EB923 
X-CRM114-Status: GOOD (  19.65  )
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
Cc: Robin van der Gracht <robin@protonic.nl>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Martin Kepplinger <martin.kepplinger@ginzinger.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 28 Jan 2019 at 15:41, Martin Kepplinger <martink@posteo.de> wrote:
>
> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
>
> This adds support for explicitly switching the mmc's power on and off
> which is needed for example for WL1837 WL1271 wifi controllers on imx28.
>
> While the wifi's vmmc-supply regulator can be configured in devicetree,
> "ip link set wlan0 down" doesn't turn off the VMMC regulator which leads
> to hangs when loading firmware, for example.
>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
>
>
> revision history
> ----------------
> v4: re-added forgotten regulator_enable() during probe
> v3: improve API usage as suggested by Ulf
> v2: tested patch with changes suggested by Robin
> v1: question, why https://patchwork.kernel.org/patch/4365751/ didn't get in
>
>
>  drivers/mmc/host/mxs-mmc.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index add1e70195ea..23d275269d61 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -517,6 +517,22 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         else
>                 host->bus_width = 0;
>
> +       switch (ios->power_mode) {
> +       case MMC_POWER_OFF:
> +               if (!IS_ERR(host->mmc->supply.vmmc))
> +                       mmc_regulator_set_ocr(host->mmc,
> +                                             host->mmc->supply.vmmc, 0);
> +               break;
> +       case MMC_POWER_UP:
> +               if (!IS_ERR(host->mmc->supply.vmmc))
> +                       mmc_regulator_set_ocr(host->mmc,
> +                                             host->mmc->supply.vmmc,
> +                                             ios->vdd);
> +               break;
> +       default:
> +               break;
> +       }
> +
>         if (ios->clock)
>                 mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
>  }
> @@ -588,7 +604,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>         struct mmc_host *mmc;
>         struct resource *iores;
>         int ret = 0, irq_err;
> -       struct regulator *reg_vmmc;
>         struct mxs_ssp *ssp;
>
>         irq_err = platform_get_irq(pdev, 0);
> @@ -614,14 +629,15 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>         host->mmc = mmc;
>         host->sdio_irq_en = 0;
>
> -       reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");
> -       if (!IS_ERR(reg_vmmc)) {
> -               ret = regulator_enable(reg_vmmc);
> -               if (ret) {
> -                       dev_err(&pdev->dev,
> -                               "Failed to enable vmmc regulator: %d\n", ret);
> -                       goto out_mmc_free;
> -               }
> +       ret = mmc_regulator_get_supply(mmc);
> +       if (ret == -EPROBE_DEFER)
> +               goto out_mmc_free;
> +
> +       ret = regulator_enable(mmc->supply.vmmc);

This is wrong, as it may cause the regulator usage count to become
wrongly balanced.

Instead, via ->set_ios() when calling mmc_regulator_set_ocr(), it will
take care of enabling and disabling the regulator depending of the
requested vdd voltage level.

> +       if (ret) {
> +               dev_err(&pdev->dev,
> +                       "Failed to enable vmmc regulator: %d\n", ret);
> +               goto out_mmc_free;
>         }
>
>         ssp->clk = devm_clk_get(&pdev->dev, NULL);
> --
> 2.20.1
>

BTW, you didn't really answer my earlier question about the TI WiFi
chip. Doesn't you need a special clock for WiFi chip as well? How do
you intend to manage that?

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
