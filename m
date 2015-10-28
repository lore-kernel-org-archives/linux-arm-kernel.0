From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 28 Oct 2015 18:45:04 +0000
Subject: [PATCH v12 1/7] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC
 support
In-Reply-To: <1445839312-8874-2-git-send-email-horms+renesas@verge.net.au>
References: <1445839312-8874-1-git-send-email-horms+renesas@verge.net.au>
 <1445839312-8874-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20151028184504.GG8899@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 03:01:46PM +0900, Simon Horman wrote:
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -66,6 +66,23 @@ config ARCH_SEATTLE
>  	help
>  	  This enables support for AMD Seattle SOC Family
>  
> +config ARCH_SHMOBILE
> +	bool
> +
> +config ARCH_RENESAS
> +	bool "Renesas SoC Platforms"
> +	select ARCH_SHMOBILE
> +	select PINCTRL
> +	select PM_GENERIC_DOMAINS if PM
> +	help
> +	  This enables support for the ARMv8 based Renesas SoCs.
> +
> +config ARCH_R8A7795
> +	bool "Renesas R-Car H3 SoC Platform"
> +	depends on ARCH_RENESAS
> +	help
> +	  This enables support for the Renesas R-Car H3 SoC.

Do you need such fine-grained configuration? I'd really like to avoid
individual SoC Kconfig entries and only include SoC families (like
ARCH_RENESAS). There are some which I didn't spot at the time
(ARCH_FSL_LS2085A and ARCH_TEGRA_132_SOC) but we shouldn't continue this
trend any further.

-- 
Catalin
