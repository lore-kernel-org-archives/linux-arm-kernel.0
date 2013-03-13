From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Mar 2013 14:02:41 -0600
Subject: [PATCH V3 3/5] ARM: tegra:add aliases and DMA requestor for serial
 nodes of Tegra114
In-Reply-To: <1363204194-19487-4-git-send-email-ldewangan@nvidia.com>
References: <1363204194-19487-1-git-send-email-ldewangan@nvidia.com>
 <1363204194-19487-4-git-send-email-ldewangan@nvidia.com>
Message-ID: <5140DB61.3090809@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2013 01:49 PM, Laxman Dewangan wrote:
> Add APB DMA requestor and serial aliases for serial controller.
> There will be two serial driver i.e. 8250 based simple serial driver
> and APB DMA based serial driver for higher baudrate and performace.
> 
> The simple serial driver get enabled with compatible "nvidia,tegra114-uart",
> "nvidia,tegra20-uart" and APB DMA based driver will get enabled with
> compatible "nvidia,tegra114-hsuart", "nvidia,tegra30-hsuart".

> +	/*
> +	 * There are two serial driver i.e. 8250 based simple serial
> +	 * driver and APB DMA based serial driver for higher baudrate
> +	 * and performace. To enable the 8250 based driver, the compatible
> +	 * is "nvidia,tegra114-uart", "nvidia,tegra20-uart" and to enable
> +	 * the APB DMA based serial driver, the comptible is
> +	 * "nvidia,tegra114-hsuart", "nvidia,tegra30-hsuart".
> +	 */

Again, that text says you want either of:

compatible = "nvidia,tegra114-uart",   "nvidia,tegra20-uart";
compatible = "nvidia,tegra114-hsuart", "nvidia,tegra30-hsuart";

(note Tegra20-vs-Tegra30 in the second compatible value)

Why isn't it instead:

compatible = "nvidia,tegra114-uart",   "nvidia,tegra20-uart";
compatible = "nvidia,tegra114-hsuart", "nvidia,tegra20-hsuart";

(note both second compatible values say Tegra20)

I assume this is a typo.

I suppose I can fix this up when I apply it to avoid a resend, assuming
it's wrong.
