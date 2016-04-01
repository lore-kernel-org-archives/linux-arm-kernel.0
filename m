From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 1 Apr 2016 17:12:26 +0530
Subject: [PATCH 2/2] arm: mach-spear: Enable PHY_PLAT to meet dependency
In-Reply-To: <1459510156-9147-2-git-send-email-gautam.vivek@samsung.com>
References: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
 <1459510156-9147-2-git-send-email-gautam.vivek@samsung.com>
Message-ID: <20160401114226.GD2987@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01-04-16, 16:59, Vivek Gautam wrote:
> mach-spear enables PHY_ST_SPEAR1310_MIPHY and
> PHY_ST_SPEAR1340_MIPHY, which now fall under PHY_PLAT
> config. So select CONFIG_PHY_PLAT as well to resolve
> dependencies.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> ---
>  arch/arm/mach-spear/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
> index ea9ea95..c0a62fd 100644
> --- a/arch/arm/mach-spear/Kconfig
> +++ b/arch/arm/mach-spear/Kconfig
> @@ -29,6 +29,7 @@ if ARCH_SPEAR13XX
>  config MACH_SPEAR1310
>  	bool "SPEAr1310 Machine support with Device Tree"
>  	select PINCTRL_SPEAR1310
> +	select PHY_PLAT
>  	select PHY_ST_SPEAR1310_MIPHY
>  	help
>  	  Supports ST SPEAr1310 machine configured via the device-tree
> @@ -36,6 +37,7 @@ config MACH_SPEAR1310
>  config MACH_SPEAR1340
>  	bool "SPEAr1340 Machine support with Device Tree"
>  	select PINCTRL_SPEAR1340
> +	select PHY_PLAT
>  	select PHY_ST_SPEAR1340_MIPHY
>  	help
>  	  Supports ST SPEAr1340 machine configured via the device-tree

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
