From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 08 Mar 2013 10:54:44 -0700
Subject: [PATCH 3/5] ARM: DT: tegra114:add aliases and DMA requestor for
 serial controller
In-Reply-To: <1362750782-15174-4-git-send-email-ldewangan@nvidia.com>
References: <1362750782-15174-1-git-send-email-ldewangan@nvidia.com>
 <1362750782-15174-4-git-send-email-ldewangan@nvidia.com>
Message-ID: <513A25E4.8040504@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2013 06:53 AM, Laxman Dewangan wrote:
> Add APB DMA requestor and serial aliases for serial controller.
> There will be two serial driver i.e. 8250 based simple serial driver
> and APB DMA based serial driver for higher baudrate and performace.
> 
> The simple serial driver get enabled with compatible nvidia,tegra20-uart
> and APB DMA based driver will get enabled with compatible
> nvidia,tegra30-hsuart.
> 
> Also Fix the clock id for the UARTB.

If you feel like saying "also", that should probably be a separate patch!

In this case, if the UARTB clock ID actually should be changed, then the
fix should be rolled into Peter's Tegra114 clock series, since it adds
the property you're changing here, and his series hasn't yet been applied.

But, as I mentioned in my previous email, I don't believe the UARTB
clock ID change is correct.

> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi

> +	/*
> +	 * There are two serial driver i.e. 8250 based simple serial
> +	 * driver and APB DMA based serial driver for higher baudrate
> +	 * and performace. To enable the 8250 based driver, the compatible
> +	 * is "nvidia,tegra30-uart", "nvidia,tegra20-uart" and to enable
> +	 * the APB DMA based serial driver, the comptible is
> +	 * "nvidia,tegra30-hsuart", "nvidia,tegra20-hsuart".
> +	 */

Any references to Tegra30 there should be changed to Tegra114 I think.
