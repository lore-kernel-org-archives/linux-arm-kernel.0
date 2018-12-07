Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A9DC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:34:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73EBC20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t/LEb69J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73EBC20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GDBYgBkqxaptWBVSkQYaUiAuUI89EnNmvDHXVTcVIbE=; b=t/LEb69Ja7xYfG
	oZv2lFHUBLHgMb+gDC4oeQ95SLhuBd+HNiujNVPOuLKXgyf5ZCe3BaEwYXbaasW+Y+800YhiMkSBw
	QLZtDWfR+r4bDw+wNBgk2rDYbViJKsEt9dqXHWaY/OkFKzwC5YCwV2sYl9oSDiJI4lTPiOq2d3ePN
	cI0UZtX/6qS6mbWQ+jYmBbokjlNa8rsIgMv3lPixQxJSW4UzIeli5+eYGNq6OMw9OTv9O/uH6Gfdi
	ak+32F/RjxhYV2BwtU1jN9sxz1vs70gZviMdLgwgaY4jAoOEpawvL3sCOqyQVEdmOmdZcfY/XXMEF
	bdYdR2ZxWbdOwiRDViyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVGGT-00042g-BG; Fri, 07 Dec 2018 13:33:57 +0000
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVGGQ-00041J-5d
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 13:33:55 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Dec 2018 05:33:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,326,1539673200"; d="scan'208";a="108101122"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130])
 ([10.237.72.130])
 by orsmga003.jf.intel.com with ESMTP; 07 Dec 2018 05:33:39 -0800
Subject: Re: [PATCH 3/3] mmc: sdhci_am654: Add Initial Support for AM654 SDHCI
 driver
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20181129161513.31734-1-faiz_abbas@ti.com>
 <20181129161513.31734-4-faiz_abbas@ti.com>
 <2618ec91-09d1-26f3-361e-34a073b1e5ea@intel.com>
 <dfe6c97a-6383-c697-88e5-279f6ca8136e@ti.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <970c3531-5d7d-fe94-55c1-13603735b43a@intel.com>
Date: Fri, 7 Dec 2018 15:32:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <dfe6c97a-6383-c697-88e5-279f6ca8136e@ti.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_053354_222228_BA3E90F5 
X-CRM114-Status: GOOD (  18.96  )
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

On 5/12/18 5:07 PM, Faiz Abbas wrote:
> Hi Adrian,
> 
> On 05/12/18 7:12 PM, Adrian Hunter wrote:
>> On 29/11/18 6:15 PM, Faiz Abbas wrote:
>>> The host controllers on TI's AM654 SOCs are not compatible with
>>> the phy and consumer model of the sdhci-of-arasan driver. It turns out
>>> that for optimal operation at higher speeds, a special tuning procedure
>>> needs to be implemented which involves configuration of platform
>>> specific phy registers.
>>>
>>> Therefore, branch out to a new sdhci_am654 driver and add the phy
>>> register space with all phy configurations to it. Populate AM654
>>> specific callbacks to sdhci_ops and add SDHCI_QUIRKS wherever
>>> applicable.
>>>
>>> Only add support for upto High Speed for SD card and upto DDR52 speed
>>> mode for eMMC. Higher speeds will be added in subsequent patches.
>>>
> ...
>>> +		sdhci_am654->dll_on = true;
>>> +	}
>>> +}
>>> +
>>> +
>>
>> Double blank line
> 
> Will fix.
> 
>>
>>> +static void sdhci_am654_set_power(struct sdhci_host *host, unsigned char mode,
>>> +				  unsigned short vdd)
>>> +{
>>> +	if (!IS_ERR(host->mmc->supply.vmmc)) {
>>> +		struct mmc_host *mmc = host->mmc;
>>> +
>>> +		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>>> +	}
>>> +	sdhci_set_power_noreg(host, mode, vdd);
>>> +}
>>> +
>>> +struct sdhci_ops sdhci_am654_ops = {
>>> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>>> +	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
>>> +	.set_uhs_signaling = sdhci_set_uhs_signaling,
>>> +	.set_bus_width = sdhci_set_bus_width,
>>> +	.set_power = sdhci_am654_set_power,
>>> +	.set_clock = sdhci_am654_set_clock,
>>> +	.reset = sdhci_reset,
>>> +};
>>> +
>>> +static const struct sdhci_pltfm_data sdhci_am654_pdata = {
>>> +	.ops = &sdhci_am654_ops,
>>> +	.quirks = SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
>>> +		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
>>> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>>> +};
>>> +
>>> +static int sdhci_am654_init(struct sdhci_host *host)
>>> +{
>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>>> +	u32 ctl_cfg_2 = 0;
>>> +	u32 val;
>>> +	int ret;
>>> +
>>> +	regmap_read(sdhci_am654->base, PHY_STAT1, &val);
>>> +	if (~val & CALDONE_MASK) {
>>> +		/* Calibrate IO lines */
>>> +		regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
>>> +				   PDB_MASK, PDB_MASK);
>>> +		ret = regmap_read_poll_timeout(sdhci_am654->base, PHY_STAT1,
>>> +					       val, val & CALDONE_MASK, 1, 20);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>> +	/* Enable pins by setting IO mux to 0 */
>>> +	regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
>>> +			   IOMUX_ENABLE_MASK, 0);
>>> +
>>> +	/* Set slot type based on SD or eMMC */
>>> +	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
>>> +		ctl_cfg_2 = SLOTTYPE_EMBEDDED;
>>> +
>>> +	regmap_update_bits(sdhci_am654->base, CTL_CFG_2,
>>> +			   ctl_cfg_2, SLOTTYPE_MASK);
>>> +
>>> +	return sdhci_add_host(host);
>>> +}
>>> +
>>> +static int sdhci_am654_get_of_property(struct platform_device *pdev,
>>> +					struct sdhci_am654_data *sdhci_am654)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	int drv_strength;
>>> +	int ret;
>>> +
>>> +	ret = device_property_read_u32(dev, "ti,trm-icp",
>>> +				       &sdhci_am654->trm_icp);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = device_property_read_u32(dev, "ti,otap-del-sel",
>>> +				       &sdhci_am654->otap_del_sel);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = device_property_read_u32(dev, "ti,driver-strength-ohm",
>>> +				       &drv_strength);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	switch (drv_strength) {
>>> +	case 50:
>>> +		sdhci_am654->drv_strength = DRIVER_STRENGTH_50_OHM;
>>> +		break;
>>> +	case 33:
>>> +		sdhci_am654->drv_strength = DRIVER_STRENGTH_33_OHM;
>>> +		break;
>>> +	case 66:
>>> +		sdhci_am654->drv_strength = DRIVER_STRENGTH_66_OHM;
>>> +		break;
>>> +	case 100:
>>> +		sdhci_am654->drv_strength = DRIVER_STRENGTH_100_OHM;
>>> +		break;
>>> +	case 40:
>>> +		sdhci_am654->drv_strength = DRIVER_STRENGTH_40_OHM;
>>> +		break;
>>> +	default:
>>> +		dev_err(dev, "Invalid driver strength\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	sdhci_get_of_property(pdev);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int sdhci_am654_probe(struct platform_device *pdev)
>>> +{
>>> +	struct sdhci_pltfm_host *pltfm_host;
>>> +	struct sdhci_am654_data *sdhci_am654;
>>> +	struct sdhci_host *host;
>>> +	struct resource *res;
>>> +	struct clk *clk_xin;
>>> +	struct device *dev = &pdev->dev;
>>> +	void __iomem *base;
>>> +	int ret;
>>> +
>>> +	host = sdhci_pltfm_init(pdev, &sdhci_am654_pdata, sizeof(*sdhci_am654));
>>> +	if (IS_ERR(host))
>>> +		return PTR_ERR(host);
>>> +
>>> +	pltfm_host = sdhci_priv(host);
>>> +	sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>>> +
>>> +	clk_xin = devm_clk_get(dev, "clk_xin");
>>> +	if (IS_ERR(clk_xin)) {
>>> +		dev_err(dev, "clk_xin clock not found.\n");
>>> +		ret = PTR_ERR(clk_xin);
>>> +		goto err_pltfm_free;
>>> +	}
>>> +
>>> +	sdhci_am654->clk_ahb = devm_clk_get(dev, "clk_ahb");
>>> +	if (IS_ERR(sdhci_am654->clk_ahb)) {
>>> +		dev_err(dev, "clk_ahb clock not found.\n");
>>> +		ret = PTR_ERR(sdhci_am654->clk_ahb);
>>> +		goto err_pltfm_free;
>>> +	}
>>
>> Did you intend not to enable clks?
> 
> Yes. Clocks get enabled as a part of pm_runtime calls.

Ok, but that could use an explanatory comment.  Also why get a reference to
clk_ahb if that reference is never used?

>>
>>> +
>>> +	pltfm_host->clk = clk_xin;
>>> +
>>> +	pm_runtime_enable(dev);
>>> +	ret = pm_runtime_get_sync(dev);
>>> +	if (ret > 0) {
>>
>> Did you intend 'ret > 0'?
> 
> Sorry. That was intended to be < 0.
> 
> Thanks,
> Faiz
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
