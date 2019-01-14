Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4445CC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:44:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F502086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t3A+dmDC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VzxQLsz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F502086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z6qFR4/1kyR0HZL1aXAX2A2LW683Y5eZoIalzRVRI3Y=; b=t3A+dmDCZfSA9s
	qgqkalI/7OXjauf8endPJEIZWuhBzLfxI8BRScwBmAGl6n0mTKkt49PR9+pbB6FiUlitZkESycXI6
	WNn4XqOoUUPuA1OeEVdUoga6GdZa91LfJt2/+MuRNjtYmc99yC2KusIk/eZB0oKhgzOCC7jH1hQm1
	ToAeqrfpS0ZrpMuX2amcXW/aLe2hELJ5kyFv2siD8k/YVCf6W0FvY6Z+twR3KZbPcRaewyYdH9YK3
	NWyds1dDjtoCc2qXzmFnTz3vVeiCPsUaQn55pN8SFUQFbCRQOr7FOt1FOT4qVqwIcCxeDtFSP6y+o
	XWSNmw+ReEA5TXhmIU6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj0ff-0002SI-52; Mon, 14 Jan 2019 11:44:47 +0000
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj0fT-0002DQ-5t
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 11:44:40 +0000
Received: by mail-vs1-xe44.google.com with SMTP id n13so13426559vsk.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 03:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GTaXIYcIE7dPU22lPFpb1iwMicjDhqwFgegE9vrOM+U=;
 b=VzxQLsz8+Mt0dYyiGcQLq9zZSE7R/JMtHQnR1Xq2XsP4/lXAWXz7rhD1NiPxtRS5VA
 uCw/p9I761EQiOSzI4JhP81LwYvemTAL7i7RDPxmZH3zzISvmUD2+Bm4Px6f1ylJVWbg
 pD36OdKsafveupDCOJgAHjV8B341rt1WEiLt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GTaXIYcIE7dPU22lPFpb1iwMicjDhqwFgegE9vrOM+U=;
 b=iGdYy1sYW24V2samxVWB66w9cYHi5ZtTLNdYK/rMJG+iWqWNpc2hq6H0r8HEHHhdD8
 jD6GzeEoVvI9K09JNaV9mWOHvSiqljA+L/6YQSFqHhkGEAaO+TMr3b9iKkXe/5RZWJsH
 Kyx/wcvPUMPO7lXOlJEEgSBTvMJLyxFDHV8mLu5yH196BD0witCYPORyFM/1cpW4Y77Z
 M4hNXeV59+J2h7HONFVmoSgLTuMGrf6evePKGSCWIxyvfi6R+9FMI6IMjG23L7jiTm4X
 NpkavaksCkrkFNXnXMyLqiim07qWwVAdWlfUaVM9rupHqGTc/wW0mApZw4JyOgWd0exY
 +38Q==
X-Gm-Message-State: AJcUukfHGfLVZAIqoOLA9KtK9R+7zyEr9wcznm/jbwAIBa23mKF+Z0fC
 pj1FtX6SKwQeV5+ySCCJNvsjaaf9o/GOxVcEnV0j4w==
X-Google-Smtp-Source: ALg8bN7VOR2a17pWgWT4I+vXDUuBvMrouuZaTyvDDWDKv/ZqfkWTI9tM8RrvYunSsz19o0nx3ouxBS/4WsugvluPVj0=
X-Received: by 2002:a67:74c2:: with SMTP id p185mr3841272vsc.34.1547466274336; 
 Mon, 14 Jan 2019 03:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20181228033323.32308-1-haibo.chen@nxp.com>
 <20181228033323.32308-2-haibo.chen@nxp.com>
In-Reply-To: <20181228033323.32308-2-haibo.chen@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 14 Jan 2019 12:43:58 +0100
Message-ID: <CAPDyKFpM3O=Ye6K2cG4b0=E6EXt7HhUYs6HNhomf=azayRL0FA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: sdhci-esdhc-imx: add SD clock limitation for
 imx6ull
To: BOUGH CHEN <haibo.chen@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_034435_533805_81A2A3DA 
X-CRM114-Status: GOOD (  17.89  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 28 Dec 2018 at 04:26, BOUGH CHEN <haibo.chen@nxp.com> wrote:
>
> i.MX6ULL has errata ERR010450, point out that due to SOC I/O
> timing limitation, for eMMC HS200 and SD/SDIO 3.0 SDR104, the
> clock rate can't exceed 150MHz. And for eMMC DDR52 and SD/SDIO
> DDR50 mode, the clock rate can't exceed 45MHz.
>
> This patch add this limit for imx6ull.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next (I amended the patch by fixing a trivial conflict and
made the struct "const").

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 7cfcc8618e45..e1d9b2985979 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -138,7 +138,11 @@
>  #define ESDHC_FLAG_HS200               BIT(8)
>  /* The IP supports HS400 mode */
>  #define ESDHC_FLAG_HS400               BIT(9)
> -
> +/* The IP has errata ERR010450
> + * uSDHC: Due to the I/O timing limit, for SDR mode, SD card clock can't
> + * exceed 150MHz, for DDR mode, SD card clock can't exceed 45MHz.
> + */
> +#define ESDHC_FLAG_ERR010450           BIT(10)
>  /* A clock frequency higher than this rate requires strobe dll control */
>  #define ESDHC_STROBE_DLL_CLK_FREQ      100000000
>
> @@ -177,6 +181,12 @@ static struct esdhc_soc_data usdhc_imx6sx_data = {
>                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
>  };
>
> +static struct esdhc_soc_data usdhc_imx6ull_data = {
> +       .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> +                       | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> +                       | ESDHC_FLAG_ERR010450,
> +};
> +
>  static struct esdhc_soc_data usdhc_imx7d_data = {
>         .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> @@ -227,6 +237,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
>         { .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
>         { .compatible = "fsl,imx6sl-usdhc", .data = &usdhc_imx6sl_data, },
>         { .compatible = "fsl,imx6q-usdhc", .data = &usdhc_imx6q_data, },
> +       { .compatible = "fsl,imx6ull-usdhc", .data = &usdhc_imx6ull_data, },
>         { .compatible = "fsl,imx7d-usdhc", .data = &usdhc_imx7d_data, },
>         { /* sentinel */ }
>  };
> @@ -733,6 +744,14 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>                 | ESDHC_CLOCK_MASK);
>         sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
>
> +       if (imx_data->socdata->flags & ESDHC_FLAG_ERR010450) {
> +               unsigned int max_clock;
> +
> +               max_clock = imx_data->is_ddr ? 45000000 : 150000000;
> +
> +               clock = min(clock, max_clock);
> +       }
> +
>         while (host_clock / (16 * pre_div * ddr_pre_div) > clock &&
>                         pre_div < 256)
>                 pre_div *= 2;
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
