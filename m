From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 09 May 2014 16:55:36 +0100
Subject: [PATCH 1/4] mmc: sdhci: add a driver for Berlin SoCs
In-Reply-To: <1397652011-21284-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397652011-21284-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <536CFA78.9050609@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/04/14 13:40, Antoine T?nart wrote:
> Add a Driver to support the SDHCI controller of the Marvell Berlin SoCs.
> This controller supports 3 sockets.

[snip]

> +
> +static struct sdhci_ops sdhci_berlin_ops = {
> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +};
> +
> +static struct sdhci_pltfm_data sdhci_berlin2_pdata = {
> +	.quirks	= SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_BROKEN_ADMA |
> +		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +	.ops = &sdhci_berlin_ops,
> +};
> +
> +static struct sdhci_pltfm_data sdhci_berlin2q_pdata = {
> +	.quirks	= SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
> +		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +	.ops = &sdhci_berlin_ops,
> +};
> +
> +static const struct of_device_id sdhci_berlin_of_match_table[] = {
> +	{
> +		.compatible = "marvell,berlin2-sdhci",
> +		.data = &sdhci_berlin2_pdata,
> +	},
> +	{
> +		.compatible = "marvell,berlin2cd-sdhci",
> +		.data = &sdhci_berlin2_pdata,
> +	},
> +	{
> +		.compatible = "marvell,berlin2q-sdhci",
> +		.data = &sdhci_berlin2q_pdata,
> +	},
> +	{}

I think the hardware names should be used instead of the
quirks the hardware has (broken wp / broken adma)



-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
