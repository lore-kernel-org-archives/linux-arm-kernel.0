From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 29 Aug 2012 14:49:34 -0700
Subject: [PATCH] clk: Make the generic clock API available by default
In-Reply-To: <1346186104-4083-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1346186104-4083-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <503E8E6E.1010101@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/12 13:35, Mark Brown wrote:
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

> @@ -674,6 +676,7 @@ config ARCH_TEGRA
>   	select GENERIC_CLOCKEVENTS
>   	select GENERIC_GPIO
>   	select HAVE_CLK
> +	select HAVE_CUSTOM_CLK

For 3.7, Tegra will switch to the common clock framework. I think this 
patch would then disable that. How should we resolve this - rebase the 
Tegra common-clk tree on top of any branch containing this patch in 
order to remove that select statement?
