From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 18 Nov 2013 09:38:49 +0800
Subject: [RFC 4/9] ASoC: fsl-ssi: Add imx50-ssi and of_device_id matching
In-Reply-To: <1384530584-31273-5-git-send-email-mpa@pengutronix.de>
References: <1384530584-31273-1-git-send-email-mpa@pengutronix.de>
 <1384530584-31273-5-git-send-email-mpa@pengutronix.de>
Message-ID: <20131118013848.GM11014@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 04:49:39PM +0100, Markus Pargmann wrote:
> @@ -190,6 +190,20 @@ struct fsl_ssi_private {
>  	char name[1];
>  };
>  
> +enum fsl_ssi_type {
> +	FSL_SSI_MCP8610,
> +	FSL_SSI_MX21,
> +	FSL_SSI_MX50,
> +};
> +
> +static const struct of_device_id fsl_ssi_ids[] = {
> +	{ .compatible = "fsl,mpc8610-ssi", .data = (void *) FSL_SSI_MCP8610},
> +	{ .compatible = "fsl,imx21-ssi", .data = (void *) FSL_SSI_MX21},
> +	{ .compatible = "fsl,imx50-ssi", .data = (void *) FSL_SSI_MX50},

As a good practice, please sort it from the specific to the generic.
That said, "fsl,imx50-ssi" should be put before "fsl,imx21-ssi".

Shawn

> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
