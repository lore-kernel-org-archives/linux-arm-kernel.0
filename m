Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAA4C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:48:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60CB32084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gN/yZ0Op"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CB32084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3AhTupqxnwxtUYQJDaAKqotktOgTLqGAorIo6U/k1nc=; b=gN/yZ0OpvBUxY4
	brl8cCf6Qh7zre58xbmlrgsdGa+RTFNFe354jvZF9jbNztOEkCg1xlVLrf2d3vMs7f5zi/R2KIJGA
	NIM6h/Mw4PJ24+R3TPc3tWFyexjNw6V+8+UXuK+CTTYC4O67MD/tZBHG/ml85whXOfPux9//LQu9U
	obGlKHAM6E+CorvjNEzxR9bqaSx1LIagfbziMR4bGATF70q9BwSHxJ2inZc4A1E56TY21GkzzxDm2
	FgRaDo8tmOn+O9xjYsEhOPdyzMBzOXEFt9VUc6gz2rdH53MI9bsXT1UJWDxsYrnrROYTYQYv0NR0+
	tJ3+4ZQ3PSa0dCCZGKAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWcmL-00034L-2t; Tue, 11 Dec 2018 07:48:29 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWcmF-00032d-Rb
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 07:48:27 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Dec 2018 23:48:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,341,1539673200"; d="scan'208";a="109405707"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130])
 ([10.237.72.130])
 by orsmga003.jf.intel.com with ESMTP; 10 Dec 2018 23:48:06 -0800
Subject: Re: [PATCH v3 3/3] mmc: sdhci_am654: Add Initial Support for AM654
 SDHCI driver
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20181210183507.9617-1-faiz_abbas@ti.com>
 <20181210183507.9617-4-faiz_abbas@ti.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c34a6800-044d-0e61-e7cb-50a8221327f9@intel.com>
Date: Tue, 11 Dec 2018 09:46:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181210183507.9617-4-faiz_abbas@ti.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_234824_540392_BAD317EC 
X-CRM114-Status: GOOD (  33.00  )
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
Cc: mark.rutland@arm.com, ulf.hansson@linaro.org, robh+dt@kernel.org,
 michal.simek@xilinx.com, kishon@ti.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 10/12/18 8:35 PM, Faiz Abbas wrote:
> The host controllers on TI's AM654 SOCs are not compatible with
> the phy and consumer model of the sdhci-of-arasan driver. It turns out
> that for optimal operation at higher speeds, a special tuning procedure
> needs to be implemented which involves configuration of platform
> specific phy registers.
> 
> Therefore, branch out to a new sdhci_am654 driver and add the phy
> register space with all phy configurations to it. Populate AM654
> specific callbacks to sdhci_ops and add SDHCI_QUIRKS wherever
> applicable.
> 
> Only add support for upto High Speed for SD card and upto DDR52 speed
> mode for eMMC. Higher speeds will be added in subsequent patches.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/Kconfig           |  12 +
>  drivers/mmc/host/Makefile          |   1 +
>  drivers/mmc/host/sdhci-of-arasan.c |  46 ----
>  drivers/mmc/host/sdhci_am654.c     | 374 +++++++++++++++++++++++++++++
>  4 files changed, 387 insertions(+), 46 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci_am654.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 1b58739d9744..cfb2eb1a2c32 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -977,3 +977,15 @@ config MMC_SDHCI_OMAP
>  	  If you have a controller with this interface, say Y or M here.
>  
>  	  If unsure, say N.
> +
> +config MMC_SDHCI_AM654
> +	tristate "Support for the SDHCI Controller in TI's AM654 SOCs"
> +	depends on MMC_SDHCI_PLTFM && OF
> +	help
> +	  This selects the Secure Digital Host Controller Interface (SDHCI)
> +	  support present in TI's AM654 SOCs. The controller supports
> +	  SD/MMC/SDIO devices.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 720d37777098..5c7770edc431 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
>  obj-$(CONFIG_MMC_SDHCI_SIRF)   	+= sdhci-sirf.o
>  obj-$(CONFIG_MMC_SDHCI_F_SDH30)	+= sdhci_f_sdh30.o
>  obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
> +obj-$(CONFIG_MMC_SDHCI_AM654)	+= sdhci_am654.o
>  obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
>  obj-$(CONFIG_MMC_AU1X)		+= au1xmmc.o
>  obj-$(CONFIG_MMC_MTK)		+= mtk-sd.o
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 142c4b802f31..c9e3e050ccc8 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -231,25 +231,6 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
>  	}
>  }
>  
> -static void sdhci_arasan_am654_set_clock(struct sdhci_host *host,
> -					 unsigned int clock)
> -{
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> -
> -	if (sdhci_arasan->is_phy_on) {
> -		phy_power_off(sdhci_arasan->phy);
> -		sdhci_arasan->is_phy_on = false;
> -	}
> -
> -	sdhci_set_clock(host, clock);
> -
> -	if (clock > PHY_CLK_TOO_SLOW_HZ) {
> -		phy_power_on(sdhci_arasan->phy);
> -		sdhci_arasan->is_phy_on = true;
> -	}
> -}
> -
>  static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
>  					struct mmc_ios *ios)
>  {
> @@ -335,29 +316,6 @@ static struct sdhci_arasan_of_data sdhci_arasan_data = {
>  	.pdata = &sdhci_arasan_pdata,
>  };
>  
> -static const struct sdhci_ops sdhci_arasan_am654_ops = {
> -	.set_clock = sdhci_arasan_am654_set_clock,
> -	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> -	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> -	.set_bus_width = sdhci_set_bus_width,
> -	.reset = sdhci_arasan_reset,
> -	.set_uhs_signaling = sdhci_set_uhs_signaling,
> -};
> -
> -static const struct sdhci_pltfm_data sdhci_arasan_am654_pdata = {
> -	.ops = &sdhci_arasan_am654_ops,
> -	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN  |
> -		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
> -		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
> -		   SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400,
> -};
> -
> -static const struct sdhci_arasan_of_data sdhci_arasan_am654_data = {
> -	.pdata = &sdhci_arasan_am654_pdata,
> -};
> -
>  static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
>  {
>  	int cmd_error = 0;
> @@ -520,10 +478,6 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
>  		.compatible = "rockchip,rk3399-sdhci-5.1",
>  		.data = &sdhci_arasan_rk3399_data,
>  	},
> -	{
> -		.compatible = "ti,am654-sdhci-5.1",
> -		.data = &sdhci_arasan_am654_data,
> -	},
>  	/* Generic compatible below here */
>  	{
>  		.compatible = "arasan,sdhci-8.9a",
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> new file mode 100644
> index 000000000000..8c05879850a0
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -0,0 +1,374 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * sdhci_am654.c - SDHCI driver for TI's AM654 SOCs
> + *
> + * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com
> + *
> + */
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +#include "sdhci-pltfm.h"
> +
> +/* CTL_CFG Registers */
> +#define CTL_CFG_2		0x14
> +
> +#define SLOTTYPE_MASK		GENMASK(31, 30)
> +#define SLOTTYPE_EMBEDDED	BIT(30)
> +
> +/* PHY Registers */
> +#define PHY_CTRL1	0x100
> +#define PHY_CTRL2	0x104
> +#define PHY_CTRL3	0x108
> +#define PHY_CTRL4	0x10C
> +#define PHY_CTRL5	0x110
> +#define PHY_CTRL6	0x114
> +#define PHY_STAT1	0x130
> +#define PHY_STAT2	0x134
> +
> +#define IOMUX_ENABLE_SHIFT	31
> +#define IOMUX_ENABLE_MASK	BIT(IOMUX_ENABLE_SHIFT)
> +#define OTAPDLYENA_SHIFT	20
> +#define OTAPDLYENA_MASK		BIT(OTAPDLYENA_SHIFT)
> +#define OTAPDLYSEL_SHIFT	12
> +#define OTAPDLYSEL_MASK		GENMASK(15, 12)
> +#define STRBSEL_SHIFT		24
> +#define STRBSEL_MASK		GENMASK(27, 24)
> +#define SEL50_SHIFT		8
> +#define SEL50_MASK		BIT(SEL50_SHIFT)
> +#define SEL100_SHIFT		9
> +#define SEL100_MASK		BIT(SEL100_SHIFT)
> +#define DLL_TRIM_ICP_SHIFT	4
> +#define DLL_TRIM_ICP_MASK	GENMASK(7, 4)
> +#define DR_TY_SHIFT		20
> +#define DR_TY_MASK		GENMASK(22, 20)
> +#define ENDLL_SHIFT		1
> +#define ENDLL_MASK		BIT(ENDLL_SHIFT)
> +#define DLLRDY_SHIFT		0
> +#define DLLRDY_MASK		BIT(DLLRDY_SHIFT)
> +#define PDB_SHIFT		0
> +#define PDB_MASK		BIT(PDB_SHIFT)
> +#define CALDONE_SHIFT		1
> +#define CALDONE_MASK		BIT(CALDONE_SHIFT)
> +#define RETRIM_SHIFT		17
> +#define RETRIM_MASK		BIT(RETRIM_SHIFT)
> +
> +#define DRIVER_STRENGTH_50_OHM	0x0
> +#define DRIVER_STRENGTH_33_OHM	0x1
> +#define DRIVER_STRENGTH_66_OHM	0x2
> +#define DRIVER_STRENGTH_100_OHM	0x3
> +#define DRIVER_STRENGTH_40_OHM	0x4
> +
> +#define CLOCK_TOO_SLOW_HZ	400000
> +
> +static struct regmap_config sdhci_am654_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.fast_io = true,
> +};
> +
> +struct sdhci_am654_data {
> +	struct regmap *base;
> +	int otap_del_sel;
> +	int trm_icp;
> +	int drv_strength;
> +	bool dll_on;
> +};
> +
> +static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> +	int sel50, sel100;
> +	u32 mask, val;
> +	int ret;
> +
> +	if (sdhci_am654->dll_on) {
> +		regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
> +				   ENDLL_MASK, 0);
> +
> +		sdhci_am654->dll_on = false;
> +	}
> +
> +	sdhci_set_clock(host, clock);
> +
> +	if (clock > CLOCK_TOO_SLOW_HZ) {
> +		/* Setup DLL Output TAP delay */
> +		mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
> +		val = (1 << OTAPDLYENA_SHIFT) |
> +		      (sdhci_am654->otap_del_sel << OTAPDLYSEL_SHIFT);
> +		regmap_update_bits(sdhci_am654->base, PHY_CTRL4,
> +				   mask, val);
> +		switch (clock) {
> +		case 200000000:
> +			sel50 = 0;
> +			sel100 = 0;
> +			break;
> +		case 100000000:
> +			sel50 = 0;
> +			sel100 = 1;
> +			break;
> +		default:
> +			sel50 = 1;
> +			sel100 = 0;
> +		}
> +
> +		/* Configure PHY DLL frequency */
> +		mask = SEL50_MASK | SEL100_MASK;
> +		val = (sel50 << SEL50_SHIFT) | (sel100 << SEL100_SHIFT);
> +		regmap_update_bits(sdhci_am654->base, PHY_CTRL5,
> +				   mask, val);
> +		/* Configure DLL TRIM */
> +		mask = DLL_TRIM_ICP_MASK;
> +		val = sdhci_am654->trm_icp << DLL_TRIM_ICP_SHIFT;
> +
> +		/* Configure DLL driver strength */
> +		mask |= DR_TY_MASK;
> +		val |= sdhci_am654->drv_strength << DR_TY_SHIFT;
> +		regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
> +				   mask, val);
> +		/* Enable DLL */
> +		regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
> +				   ENDLL_MASK, 0x1 << ENDLL_SHIFT);
> +		/*
> +		 * Poll for DLL ready. Use a one second timeout.
> +		 * Works in all experiments done so far
> +		 */
> +		ret = regmap_read_poll_timeout(sdhci_am654->base,
> +					 PHY_STAT1, val,
> +					 val & DLLRDY_MASK,
> +					 1000, 1000000);
> +
> +		sdhci_am654->dll_on = true;
> +	}
> +}
> +
> +static void sdhci_am654_set_power(struct sdhci_host *host, unsigned char mode,
> +				  unsigned short vdd)
> +{
> +	if (!IS_ERR(host->mmc->supply.vmmc)) {
> +		struct mmc_host *mmc = host->mmc;
> +
> +		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> +	}
> +	sdhci_set_power_noreg(host, mode, vdd);
> +}
> +
> +struct sdhci_ops sdhci_am654_ops = {
> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> +	.set_uhs_signaling = sdhci_set_uhs_signaling,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.set_power = sdhci_am654_set_power,
> +	.set_clock = sdhci_am654_set_clock,
> +	.reset = sdhci_reset,
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_am654_pdata = {
> +	.ops = &sdhci_am654_ops,
> +	.quirks = SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
> +		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +};
> +
> +static int sdhci_am654_init(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> +	u32 ctl_cfg_2 = 0;
> +	u32 mask;
> +	u32 val;
> +	int ret;
> +
> +	/* Reset OTAP to default value */
> +	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
> +	regmap_update_bits(sdhci_am654->base, PHY_CTRL4,
> +				   mask, 0x0);
> +
> +	regmap_read(sdhci_am654->base, PHY_STAT1, &val);
> +	if (~val & CALDONE_MASK) {
> +		/* Calibrate IO lines */
> +		regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
> +				   PDB_MASK, PDB_MASK);
> +		ret = regmap_read_poll_timeout(sdhci_am654->base, PHY_STAT1,
> +					       val, val & CALDONE_MASK, 1, 20);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Enable pins by setting IO mux to 0 */
> +	regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
> +			   IOMUX_ENABLE_MASK, 0);
> +
> +	/* Set slot type based on SD or eMMC */
> +	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
> +		ctl_cfg_2 = SLOTTYPE_EMBEDDED;
> +
> +	regmap_update_bits(sdhci_am654->base, CTL_CFG_2,
> +			   ctl_cfg_2, SLOTTYPE_MASK);
> +
> +	return sdhci_add_host(host);
> +}
> +
> +static int sdhci_am654_get_of_property(struct platform_device *pdev,
> +					struct sdhci_am654_data *sdhci_am654)
> +{
> +	struct device *dev = &pdev->dev;
> +	int drv_strength;
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, "ti,trm-icp",
> +				       &sdhci_am654->trm_icp);
> +	if (ret)
> +		return ret;
> +
> +	ret = device_property_read_u32(dev, "ti,otap-del-sel",
> +				       &sdhci_am654->otap_del_sel);
> +	if (ret)
> +		return ret;
> +
> +	ret = device_property_read_u32(dev, "ti,driver-strength-ohm",
> +				       &drv_strength);
> +	if (ret)
> +		return ret;
> +
> +	switch (drv_strength) {
> +	case 50:
> +		sdhci_am654->drv_strength = DRIVER_STRENGTH_50_OHM;
> +		break;
> +	case 33:
> +		sdhci_am654->drv_strength = DRIVER_STRENGTH_33_OHM;
> +		break;
> +	case 66:
> +		sdhci_am654->drv_strength = DRIVER_STRENGTH_66_OHM;
> +		break;
> +	case 100:
> +		sdhci_am654->drv_strength = DRIVER_STRENGTH_100_OHM;
> +		break;
> +	case 40:
> +		sdhci_am654->drv_strength = DRIVER_STRENGTH_40_OHM;
> +		break;
> +	default:
> +		dev_err(dev, "Invalid driver strength\n");
> +		return -EINVAL;
> +	}
> +
> +	sdhci_get_of_property(pdev);
> +
> +	return 0;
> +}
> +
> +static int sdhci_am654_probe(struct platform_device *pdev)
> +{
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct sdhci_am654_data *sdhci_am654;
> +	struct sdhci_host *host;
> +	struct resource *res;
> +	struct clk *clk_xin;
> +	struct device *dev = &pdev->dev;
> +	void __iomem *base;
> +	int ret;
> +
> +	host = sdhci_pltfm_init(pdev, &sdhci_am654_pdata, sizeof(*sdhci_am654));
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	pltfm_host = sdhci_priv(host);
> +	sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> +
> +	clk_xin = devm_clk_get(dev, "clk_xin");
> +	if (IS_ERR(clk_xin)) {
> +		dev_err(dev, "clk_xin clock not found.\n");
> +		ret = PTR_ERR(clk_xin);
> +		goto err_pltfm_free;
> +	}
> +
> +	pltfm_host->clk = clk_xin;
> +
> +	/* Clocks are enabled using pm_runtime */
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(dev);
> +		goto pm_runtime_disable;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base)) {
> +		ret = PTR_ERR(base);
> +		goto pm_runtime_put;
> +	}
> +
> +	sdhci_am654->base = devm_regmap_init_mmio(dev, base,
> +						  &sdhci_am654_regmap_config);
> +	if (IS_ERR(sdhci_am654->base)) {
> +		dev_err(dev, "Failed to initialize regmap\n");
> +		ret = PTR_ERR(sdhci_am654->base);
> +		goto pm_runtime_put;
> +	}
> +
> +	ret = sdhci_am654_get_of_property(pdev, sdhci_am654);
> +	if (ret)
> +		goto pm_runtime_put;
> +
> +	ret = mmc_of_parse(host->mmc);
> +	if (ret) {
> +		dev_err(dev, "parsing dt failed (%d)\n", ret);
> +		goto pm_runtime_put;
> +	}
> +
> +	ret = sdhci_am654_init(host);
> +	if (ret)
> +		goto pm_runtime_put;
> +
> +	return 0;
> +
> +pm_runtime_put:
> +	pm_runtime_put_sync(dev);
> +pm_runtime_disable:
> +	pm_runtime_disable(dev);
> +err_pltfm_free:
> +	sdhci_pltfm_free(pdev);
> +	return ret;
> +}
> +
> +static int sdhci_am654_remove(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	sdhci_remove_host(host, true);
> +	ret = pm_runtime_put_sync(&pdev->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	pm_runtime_disable(&pdev->dev);
> +	sdhci_pltfm_free(pdev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sdhci_am654_of_match[] = {
> +	{ .compatible = "ti,am654-sdhci-5.1" },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver sdhci_am654_driver = {
> +	.driver = {
> +		.name = "sdhci-am654",
> +		.of_match_table = sdhci_am654_of_match,
> +	},
> +	.probe = sdhci_am654_probe,
> +	.remove = sdhci_am654_remove,
> +};
> +
> +module_platform_driver(sdhci_am654_driver);
> +
> +MODULE_DESCRIPTION("Driver for SDHCI Controller on TI's AM654 devices");
> +MODULE_AUTHOR("Faiz Abbas <faiz_abbas@ti.com>");
> +MODULE_LICENSE("GPL");
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
