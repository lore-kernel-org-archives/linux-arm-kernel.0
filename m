From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 16 Jan 2015 10:48:42 +0000
Subject: [PATCH v5 4/5] arm64: Add support for Spreadtrum's Sharkl64
 Platform in Kconfig and defconfig
In-Reply-To: <1421402411-3479-5-git-send-email-chunyan.zhang@spreadtrum.com>
References: <sc9836-v5>
 <1421402411-3479-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1421402411-3479-5-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <20150116104842.GE21809@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 10:00:10AM +0000, Chunyan Zhang wrote:
> From: Zhizhou Zhang <zhizhou.zhang@spreadtrum.com>
> 
> Adds support for Spreadtrum's SoC Platform in the arm64 Kconfig and
> defconfig files.
> 
> Signed-off-by: Zhizhou Zhang <zhizhou.zhang@spreadtrum.com>
> Signed-off-by: Orson Zhai <orson.zhai@spreadtrum.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---
>  arch/arm64/Kconfig           |    5 +++++
>  arch/arm64/configs/defconfig |    1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b1f9a20..885c1f4 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -153,6 +153,11 @@ config ARCH_SEATTLE
>  	help
>  	  This enables support for AMD Seattle SOC Family
>  
> +config ARCH_SPRD

This should presumably be ARCH_SHARKL64, so you can add other SoC
families later. The other entries in here are already formatted that
way.

I wonder if we should have these of the form ARCH_${VENDOR}_${FAMILY}
(e.g. ARCH_SPRD_SHARKL64) rather than just ARCH_${FAMILY} to save
ourselves from name conflicts in future (and to make it easier to grep
for a particular vendor's config options).

> +	bool "Spreadtrum SoC platform"

bool "Spreadtrun Sharkl64 SoC Family"

> +	help
> +	  Support for Spreadtrum ARM based SoCs


Support for the Spreadtrum Sharkl64 SoC family.

Thanks,
Mark.

> +
>  config ARCH_THUNDER
>  	bool "Cavium Inc. Thunder SoC Family"
>  	help
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index dd301be..c1677ca 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -33,6 +33,7 @@ CONFIG_MODULE_UNLOAD=y
>  # CONFIG_BLK_DEV_BSG is not set
>  # CONFIG_IOSCHED_DEADLINE is not set
>  CONFIG_ARCH_THUNDER=y
> +CONFIG_ARCH_SPRD=y
>  CONFIG_ARCH_VEXPRESS=y
>  CONFIG_ARCH_XGENE=y
>  CONFIG_PCI=y
> -- 
> 1.7.9.5
> 
> 
