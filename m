From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Nov 2011 11:27:36 +0000
Subject: [PATCH 11/17] ASoC: Tegra I2S: Add device tree binding
In-Reply-To: <1322011285-4002-12-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
 <1322011285-4002-12-git-send-email-swarren@nvidia.com>
Message-ID: <20111123112736.GJ21073@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 06:21:19PM -0700, Stephen Warren wrote:

> +		/*
> +		 * FIXME: Perhaps there should be a standard binding for this
> +		 * that ends up creating the IORESOURCE_DMA resource for us.
> +		 */
> +		if (of_property_read_u32(pdev->dev.of_node,
> +					 "nvidia,dma-channels",
> +					 &dma_ch) < 0) {
> +			dev_err(&pdev->dev, "No DMA resource\n");
> +			ret = -ENODEV;
> +			goto err_clk_put;
> +		}

I'll hold off on this patch for discussion of this FIXME.
