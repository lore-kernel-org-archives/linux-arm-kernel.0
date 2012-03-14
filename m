From: olof@lixom.net (Olof Johansson)
Date: Wed, 14 Mar 2012 15:37:15 -0700
Subject: [PATCH v4 11/12] ARM: EXYNOS: add support device tree enabled
 board file for EXYNOS5
In-Reply-To: <1331736138-28964-12-git-send-email-kgene.kim@samsung.com>
References: <1331736138-28964-1-git-send-email-kgene.kim@samsung.com>
 <1331736138-28964-12-git-send-email-kgene.kim@samsung.com>
Message-ID: <20120314223715.GA13872@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 07:42:17AM -0700, Kukjin Kim wrote:
> This patch adds a new EXYNOS5 compatible device tree enabled board
> When using this, a corresponding device tree blob which describes the
> board's properties should be supplied at boot time to the kernel.

Hi,

Sorry, missed this last time around:

> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index a2ed05c..ac24386 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -362,7 +362,18 @@ config MACH_SMDK4412
>  	  Machine support for Samsung SMDK4412
>  endif
>  
> -comment "Flattened Device Tree based board for Exynos4 based SoC"
> +if ARCH_EXYNOS5
> +
> +comment "EXYNOS5250 Boards"
> +
> +config MACH_SMDK5250
> +	bool "SMDK5250"
> +	select SOC_EXYNOS5250
> +	help
> +	  Machine support for Samsung SMDK5250
> +endif


There's no board file for SMDK5250 in this series (and there shouldn't be since
it should all be covered by MACH_EXYNOS5_DT. So the above config option can go
away.


-Olof
