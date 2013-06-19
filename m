From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Jun 2013 17:30:55 +0200
Subject: [RFC/PATCH 11/11] ARM: msm: Move MSM's DT based hardware to
 multi-platform support
In-Reply-To: <1371600281-6118-12-git-send-email-sboyd@codeaurora.org>
References: <1371600281-6118-1-git-send-email-sboyd@codeaurora.org>
 <1371600281-6118-12-git-send-email-sboyd@codeaurora.org>
Message-ID: <201306191730.55203.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 June 2013, Stephen Boyd wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 430c922..22d4fff 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -618,8 +618,9 @@ config ARCH_PXA
>         help
>           Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
>  
> -config ARCH_MSM
> +config ARCH_MSM_NODT
>         bool "Qualcomm MSM"
> +       select ARCH_MSM
>         select ARCH_REQUIRE_GPIOLIB
>         select CLKDEV_LOOKUP
>         select CLKSRC_OF if OF


I think you have to adapt your defconfig after this change.

I'd suggest enabling all drivers for DT-based booting in
multi_v7_defconfig, and changing msm_defconfig to select
ARCH_MSM_NODT.

	Arnd
