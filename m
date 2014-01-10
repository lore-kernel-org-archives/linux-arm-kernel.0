From: balbi@ti.com (Felipe Balbi)
Date: Fri, 10 Jan 2014 10:15:38 -0600
Subject: [PATCH 2/2] ARM: DRA7XX: Add support for DRA7XX only build
In-Reply-To: <1389347850-22435-3-git-send-email-t-kristo@ti.com>
References: <1389347850-22435-1-git-send-email-t-kristo@ti.com>
 <1389347850-22435-3-git-send-email-t-kristo@ti.com>
Message-ID: <20140110161538.GI6665@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 11:57:30AM +0200, Tero Kristo wrote:
> SOC_DRA7XX was under wrong menu within Kconfig file, which prevented
> DRA7XX only build. Fixed the kconfig options for this SoC as we are
> there. voltage.c needs to be added to the DRA7XX build also, otherwise
> DRA7XX only build will fail.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

one comment below, other than that:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/Kconfig  |   18 ++++++++++--------
>  arch/arm/mach-omap2/Makefile |    1 +
>  2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index dc21df1..e65948a 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -76,6 +76,16 @@ config SOC_AM43XX
>  	select ARM_GIC
>  	select MACH_OMAP_GENERIC
>  
> +config SOC_DRA7XX
> +	bool "TI DRA7XX"
> +	depends on ARCH_MULTI_V7
> +	select ARCH_OMAP2PLUS
> +	select ARM_CPU_SUSPEND if PM
> +	select ARM_GIC
> +	select CPU_V7
> +	select HAVE_SMP
> +	select HAVE_ARM_ARCH_TIMER
> +
>  config ARCH_OMAP2PLUS
>  	bool
>  	select ARCH_HAS_BANDGAP
> @@ -128,14 +138,6 @@ config SOC_HAS_REALTIME_COUNTER
>  	depends on SOC_OMAP5 || SOC_DRA7XX
>  	default y
>  
> -config SOC_DRA7XX
> -	bool "TI DRA7XX"
> -	select ARM_ARCH_TIMER
> -	select CPU_V7
> -	select ARM_GIC
> -	select HAVE_SMP
> -	select COMMON_CLK

seems like you lost COMMON_CLK when moving this up, was that on purpose?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140110/b3eec463/attachment.sig>
