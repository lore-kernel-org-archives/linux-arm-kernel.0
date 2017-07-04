From: contact@paulk.fr (Paul Kocialkowski)
Date: Tue, 04 Jul 2017 17:29:05 +0300
Subject: [PATCH] ARM: tegra: Select appropriate DMA options for LPAE
In-Reply-To: <20170424225946.19425-1-contact@paulk.fr>
References: <20170424225946.19425-1-contact@paulk.fr>
Message-ID: <1499178545.12420.4.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-04-25 at 00:59 +0200, Paul Kocialkowski wrote:
> This automatically selects options for zone DMA and 64 bit DMA addresses
> when LPAE is enabled on ARM Tegra platforms. These options are required
> for proper operation with LPAE enabled.

Bumping this one since it did not get any review yet.

It should be a good candidate for inclusion now that the merge window is open.

> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/mach-tegra/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index 329f01c5b6f8..c8368d647741 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -13,5 +13,7 @@ menuconfig ARCH_TEGRA
>  	select ARCH_HAS_RESET_CONTROLLER
>  	select RESET_CONTROLLER
>  	select SOC_BUS
> +	select ZONE_DMA if ARM_LPAE
> +	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
>  	help
>  	  This enables support for NVIDIA Tegra based systems.
-- 
Paul Kocialkowski, developer of free digital technology and hardware support

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
