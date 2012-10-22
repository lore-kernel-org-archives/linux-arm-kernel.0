From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Oct 2012 09:56:54 -0600
Subject: [PATCH] clk: Make the generic clock API available by default
In-Reply-To: <1350910970-9095-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1350910970-9095-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <50856CC6.7010403@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2012 07:02 AM, Mark Brown wrote:
> Rather than requiring platforms to select the generic clock API to make
> it available make the API available as a user selectable option unless the
> user either selects HAVE_CUSTOM_CLK (if they have their own implementation)
> or selects COMMON_CLK (if they depend on the generic implementation).
> 
> All current architectures that HAVE_CLK but don't use the common clock
> framework have selects of HAVE_CUSTOM_CLK added.
> 
> This allows drivers to use the generic API on platforms which have no need
> for the clock API at platform level.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig

> @@ -632,6 +634,7 @@ config ARCH_TEGRA
>  	select GENERIC_CLOCKEVENTS
>  	select GENERIC_GPIO
>  	select HAVE_CLK
> +	select HAVE_CUSTOM_CLK
>  	select HAVE_SMP
>  	select MIGHT_HAVE_CACHE_L2X0
>  	select SPARSE_IRQ

Since v3.7-rc1, Tegra uses common clock, so I don't think the change
above is right is it?
