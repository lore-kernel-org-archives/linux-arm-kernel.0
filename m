From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 13 May 2015 18:11:15 +0100
Subject: [PATCH 3/6] arm64: tegra: Add Tegra210 support
In-Reply-To: <1431529065-20128-3-git-send-email-thierry.reding@gmail.com>
References: <1431529065-20128-1-git-send-email-thierry.reding@gmail.com>
 <1431529065-20128-3-git-send-email-thierry.reding@gmail.com>
Message-ID: <20150513171114.GA18655@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 04:57:42PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> NVIDIA Tegra210 (also known as Tegra X1) has four Cortex-A57 and four
> Cortex-A53 CPUs. Compared to Tegra124 and Tegra132 it comes with a 256-
> core Maxwell GPU. It supports processing videos of up to 4K resolutions
> at 60 fps (H.265, VP9, H.264).
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm64/Kconfig                       |   9 +
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 998 +++++++++++++++++++++++++++++++
>  2 files changed, 1007 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/nvidia/tegra210.dtsi
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7796af4b1d6f..bfdf064ada66 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -225,6 +225,15 @@ config ARCH_TEGRA_132_SOC
>  	  but contains an NVIDIA Denver CPU complex in place of
>  	  Tegra124's "4+1" Cortex-A15 CPU complex.
>  
> +config ARCH_TEGRA_210_SOC
> +	bool "NVIDIA Tegra210 SoC"
> +	depends on ARCH_TEGRA
> +	select PINCTRL_TEGRA210
> +	select USB_ULPI if USB_PHY
> +	select USB_ULPI_VIEWPORT if USB_PHY
> +	help
> +	  Enable support for the NVIDIA Tegra210 SoC.
> +

The previous ARCH_TEGRA_132_SOC escaped me. Do we need all these
ARCH_TEGRA_*_SOC entries? Can we not have per-driver Kconfig options?
For example, ARCH_TEGRA_132_SOC seems to be only used in
drivers/clk/tegra, a specific Kconfig entry in there would suffice.

-- 
Catalin
