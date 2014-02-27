From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Thu, 27 Feb 2014 02:08:45 +0000
Subject: [PATCH 01/15] ASoC: fsl-ssi: Use regmap
In-Reply-To: <1393430538-32333-2-git-send-email-mpa@pengutronix.de>
References: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
 <1393430538-32333-2-git-send-email-mpa@pengutronix.de>
Message-ID: <6dc5873dcdf54e13aecbf7c6be03f8bf@BY2PR03MB505.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> @@ -134,6 +115,15 @@ struct fsl_ssi_rxtx_reg_val {
>  	struct fsl_ssi_reg_val rx;
>  	struct fsl_ssi_reg_val tx;
>  };
> +static const struct regmap_config fsl_ssi_regconfig = {
> +	.max_register = CCSR_SSI_SACCDIS,
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +#ifdef PPC
> +	.val_format_endian = REGMAP_ENDIAN_BIG,
> +#endif

Is this really needed for your PPC platforms?

If so, I think this should depend on one specified platform, which
the CPU is in LE mode while the SSI is in BE mode...


Thanks,

--
Best Regards,
Xiubo
