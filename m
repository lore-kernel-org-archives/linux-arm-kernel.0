From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Fri, 14 Feb 2014 07:33:17 +0000
Subject: [PATCH v4 1/2] spi:fsl-dspi:convert to use regmap and
 big-endian supports
In-Reply-To: <1392190146-18852-1-git-send-email-b44548@freescale.com>
References: <1392190146-18852-1-git-send-email-b44548@freescale.com>
Message-ID: <065acacc2f4f461cbd310eb54737a32e@DM2PR03MB509.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> @@ -435,12 +441,20 @@ static const struct dev_pm_ops dspi_pm = {
>  	SET_SYSTEM_SLEEP_PM_OPS(dspi_suspend, dspi_resume)
>  };
> 
> +static struct regmap_config dspi_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = 0x88,
> +};
> +


If needed, you should add the callbacks like:
	.readable_reg,
	.writeable_reg,
	.volatile_reg,

Otherwise, it looks fine to me, for both patches:
Reviewed-by: Xiubo Li <Li.Xiubo@freescale.com>
