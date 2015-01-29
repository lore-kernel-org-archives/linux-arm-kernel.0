From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 29 Jan 2015 10:50:47 +0100
Subject: [PATCH] arm64: Kconfig: clean up two no-op Kconfig options from
 CONFIG_ARCH_TEGRA*
In-Reply-To: <alpine.DEB.2.02.1501290928230.19947@utopia.booyaka.com>
References: <alpine.DEB.2.02.1501290928230.19947@utopia.booyaka.com>
Message-ID: <1422525047.26924.3.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-01-29 at 09:35 +0000, Paul Walmsley wrote:
> Paul Bolle pointed out that commit
> d035fdfa27ac124bc8f94c3d7dc82ad069802170 ("arm64: Add Tegra132
> support") included two Kconfig symbols that are now no-ops:
> USB_ARCH_HAS_EHCI and HAVE_SMP.  So, drop the two symbols.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Paul Walmsley <pwalmsley@nvidia.com>
> Cc: Allen Martin <amartin@nvidia.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Paul Bolle <pebolle@tiscali.it>

There's probably no one using that address. But if there is that person
will be wondering what on earth that message is all about:
    s/.it/.nl/

> Boot-tested on NVIDIA Tegra132 Norrin64 FFD with a extra DTS page for the 
> board data (not yet posted upstream).
> 
>  arch/arm64/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 3b97e725ebfc..ae18c3d2bb3b 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -180,7 +180,6 @@ config ARCH_TEGRA
>  	select CLKSRC_OF
>  	select GENERIC_CLOCKEVENTS
>  	select HAVE_CLK
> -	select HAVE_SMP
>  	select PINCTRL
>  	select RESET_CONTROLLER
>  	help
> @@ -190,7 +189,6 @@ config ARCH_TEGRA_132_SOC
>  	bool "NVIDIA Tegra132 SoC"
>  	depends on ARCH_TEGRA
>  	select PINCTRL_TEGRA124
> -	select USB_ARCH_HAS_EHCI if USB_SUPPORT
>  	select USB_ULPI if USB_PHY
>  	select USB_ULPI_VIEWPORT if USB_PHY
>  	help


Paul Bolle
