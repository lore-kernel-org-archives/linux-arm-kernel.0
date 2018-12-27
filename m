Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEC4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:03:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A6421741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XwNKEUUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A6421741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wcQ2c1MAnPuMAHAgtXaizcPBFkKOnsquRraL47aFyKI=; b=XwNKEUUl9hS7oE
	L/JiTTiXkDtVOWH4lelP6ECXUJA0TqQWo/NiwFa0seTB2AXM/GIWspx1K9L+lcv7vc0u06Mc3pUx4
	T9Ls4UA1ru6CJSLJzRH8FSEOjF29lcKiE5MUb3o/fcqBEZlRzcd28njq3FLL7JmxabEqDw74LytTm
	6ZUd6aNAZxBvAAU/HX2NhxCjxHQm/cytaeoJDxaWalVGv20noUECIw1ynxILBsE4kPcZZTqAGDUUm
	5gLcXuy8TjG/npZgk7fT+kPspKK2XCAlaDQpCUuw9Gj0Ll62FZsaiG34KIuINZzsKY2M6i8vpoNB9
	iyzt57uPJyuiADf39bhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcQdW-0001as-Og; Thu, 27 Dec 2018 08:03:22 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcQdP-0001PG-OG
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 08:03:20 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Dec 2018 00:03:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,404,1539673200"; d="scan'208";a="110241330"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56])
 ([10.237.72.56])
 by fmsmga007.fm.intel.com with ESMTP; 27 Dec 2018 00:02:55 -0800
Subject: Re: [PATCH 2/3] mmc: sdhci-esdhc-imx: add SD clock limitation for
 imx6ull
To: BOUGH CHEN <haibo.chen@nxp.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>
References: <1545292612-14471-1-git-send-email-haibo.chen@nxp.com>
 <1545292612-14471-2-git-send-email-haibo.chen@nxp.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <cff15a85-3f72-a8ea-2e5f-731963175fde@intel.com>
Date: Thu, 27 Dec 2018 10:01:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1545292612-14471-2-git-send-email-haibo.chen@nxp.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_000315_899129_AB70F57A 
X-CRM114-Status: GOOD (  21.67  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 20/12/18 9:49 AM, BOUGH CHEN wrote:
> i.MX6ULL has errata ERR010450, point out that due to SOC I/O
> timing limitation, for eMMC HS200 and SD/SDIO 3.0 SDR104, the
> clock rate can't exceed 150MHz. And for eMMC DDR52 and SD/SDIO
> DDR50 mode, the clock rate can't exceed 45MHz.
> 
> This patch add this limit for imx6ull.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Apart from the kbuild test robot complaints (do they need to be fixed?):

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index d0d3193..75a2484 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -138,7 +138,11 @@
>  #define ESDHC_FLAG_HS200		BIT(8)
>  /* The IP supports HS400 mode */
>  #define ESDHC_FLAG_HS400		BIT(9)
> -
> +/* The IP has errata ERR010450
> + * uSDHC: Due to the I/O timing limit, for SDR mode, SD card clock can't
> + * exceed 150MHz, for DDR mode, SD card clock can't exceed 45MHz.
> + */
> +#define ESDHC_FLAG_ERR010450           BIT(10)
>  /* A clock frequency higher than this rate requires strobe dll control */
>  #define ESDHC_STROBE_DLL_CLK_FREQ	100000000
>  
> @@ -177,6 +181,12 @@ struct esdhc_soc_data {
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
>  };
>  
> +static struct esdhc_soc_data usdhc_imx6ull_data = {
> +	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> +			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> +			| ESDHC_FLAG_ERR010450,
> +};
> +
>  static struct esdhc_soc_data usdhc_imx7d_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> @@ -227,6 +237,7 @@ struct pltfm_imx_data {
>  	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
>  	{ .compatible = "fsl,imx6sl-usdhc", .data = &usdhc_imx6sl_data, },
>  	{ .compatible = "fsl,imx6q-usdhc", .data = &usdhc_imx6q_data, },
> +	{ .compatible = "fsl,imx6ull-usdhc", .data = &usdhc_imx6ull_data, },
>  	{ .compatible = "fsl,imx7d-usdhc", .data = &usdhc_imx7d_data, },
>  	{ /* sentinel */ }
>  };
> @@ -733,6 +744,12 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>  		| ESDHC_CLOCK_MASK);
>  	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
>  
> +	if (imx_data->socdata->flags & ESDHC_FLAG_ERR010450) {
> +		if (imx_data->is_ddr)
> +			clock = clock > 45000000 ? 45000000 : clock;
> +		else
> +			clock = clock > 150000000 ? 150000000 : clock;
> +
>  	while (host_clock / (16 * pre_div * ddr_pre_div) > clock &&
>  			pre_div < 256)
>  		pre_div *= 2;
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
