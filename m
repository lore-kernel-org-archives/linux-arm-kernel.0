From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 15 Jul 2015 14:20:14 +0100
Subject: [PATCH] arm64: Split out platform options to separate Kconfig
In-Reply-To: <1436958621-23524-1-git-send-email-olof@lixom.net>
References: <1436958621-23524-1-git-send-email-olof@lixom.net>
Message-ID: <20150715132014.GE20186@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 07:10:21AM -0400, Olof Johansson wrote:
> Let's move out the platform Kconfig entries to a separate file, since these
> changes usually get moved through arm-soc instead of the arm64 arch tree, and
> this will lead to fewer conflicts
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> 
> Will, Catalin, I'll merge this through arm-soc if I get your acks. Thanks!

That's fine by me.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

> +config ARCH_TEGRA
> +	bool "NVIDIA Tegra SoC Family"
> +	select ARCH_HAS_RESET_CONTROLLER
> +	select ARCH_REQUIRE_GPIOLIB
> +	select CLKDEV_LOOKUP
> +	select CLKSRC_MMIO
> +	select CLKSRC_OF
> +	select GENERIC_CLOCKEVENTS
> +	select HAVE_CLK
> +	select PINCTRL
> +	select RESET_CONTROLLER
> +	help
> +	  This enables support for the NVIDIA Tegra SoC family.
> +
> +config ARCH_TEGRA_132_SOC
> +	bool "NVIDIA Tegra132 SoC"
> +	depends on ARCH_TEGRA
> +	select PINCTRL_TEGRA124
> +	select USB_ULPI if USB_PHY
> +	select USB_ULPI_VIEWPORT if USB_PHY
> +	help
> +	  Enable support for NVIDIA Tegra132 SoC, based on the Denver
> +	  ARMv8 CPU.  The Tegra132 SoC is similar to the Tegra124 SoC,
> +	  but contains an NVIDIA Denver CPU complex in place of
> +	  Tegra124's "4+1" Cortex-A15 CPU complex.

Also, please make sure we won't get any more Kconfig entries for SoC
variations on arm64 (still waiting for the Tegra folk to remove
ARCH_TEGRA_132_SOC; this seems to be one of the very few SoCs that use
Makefile obj-y tricks to build clock, memory controller drivers instead
of dedicated driver Kconfig entries and they aren't even consistent:
PINCTRL_TEGRA124).

Thanks.

-- 
Catalin
