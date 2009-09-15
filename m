From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 Sep 2009 11:59:33 +0100
Subject: [PATCH 07/10] S3C64XX I2S: Added third I2S Controller.
In-Reply-To: <1253008959-10633-1-git-send-email-jassi.brar@samsung.com>
References: <1253008959-10633-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090915105933.GH22878@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:02:39PM +0900, Jassi wrote:

> +	[2] = {
> +		.channel	= DMACH_HSI_I2SV40_TX,
> +		.client		= &s3c64xx_dma_client_out,
> +		.dma_addr	= S3C64XX_PA_IISV4 + S3C2412_IISTXD,
> +		.dma_size	= 4,
> +	},

With your previous patch to define S3C64XX_PA_IISV4 conditionally based
on S3C6410 this also needs to be conditionally built otherwise it'll
error out on S3C6400.
