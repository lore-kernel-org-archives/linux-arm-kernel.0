From: h-kanigeri2@ti.com (Kanigeri, Hari)
Date: Wed, 22 Sep 2010 14:49:17 -0500
Subject: [PATCH v3 1/4] omap4 hsmmc: Adding card detect support for MMC1
In-Reply-To: <14833.10.24.255.18.1285173812.squirrel@dbdmail.itg.ti.com>
References: <14833.10.24.255.18.1285173812.squirrel@dbdmail.itg.ti.com>
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E5F57C548@dlee03.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kishore,

> +int twl6030_mmc_card_detect(struct device *dev, int slot)
> +{
> +	int ret = -EIO;
> +	u8 read_reg = 0;
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	switch (pdev->id) {
> +	case 0:
> +		/*
> +		 * BIT0 of REG_MMC_CTRL
> +		 * 0 - Card not present ,1 - Card present
> +		 */
> +		ret = twl_i2c_read_u8(TWL6030_MODULE_ID0, &read_reg,
> +							TWL6030_MMCCTRL);
> +		if (ret >= 0)
> +			ret = read_reg & STS_MMC;
> +		break;

nitpick: may be you don't need a switch statement for only one case.

> +	default:
> +		pr_err("Unkown MMC controller %d in %s\n", pdev->id,
> __func__);


Thank you,
Best regards,
Hari
