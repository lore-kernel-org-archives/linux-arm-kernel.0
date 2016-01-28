From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 28 Jan 2016 11:24:55 +0000
Subject: [PATCH] arm64: Disallow combination of ARCH_XGENE and 16K page
 size
In-Reply-To: <1453936230-7305-1-git-send-email-dann.frazier@canonical.com>
References: <1453936230-7305-1-git-send-email-dann.frazier@canonical.com>
Message-ID: <20160128112454.GJ17123@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 04:10:30PM -0700, dann frazier wrote:
> 16K page size is an optional feature of the architecture,

Technically, support for any particular page size and endianness
configuration is an optional architectural feature.

I don't think we can capture this information for each SoC family or
specific SoC.

The best thing we can do is early checks in the EFI stub (and
potentially bootloaders) to check whether the kernel's configured page
size and endianness is implemented.

Thanks,
Mark.

> and is not supported by the X-Gene SoC family.
> 
> Signed-off-by: dann frazier <dann.frazier@canonical.com>
> ---
>  arch/arm64/Kconfig.platforms | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 21074f6..b241290 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -133,6 +133,7 @@ config ARCH_VEXPRESS
>  
>  config ARCH_XGENE
>  	bool "AppliedMicro X-Gene SOC Family"
> +	depends on !ARM64_16K_PAGES
>  	help
>  	  This enables support for AppliedMicro X-Gene SOC Family
>  
> -- 
> 2.7.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
