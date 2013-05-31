From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Fri, 31 May 2013 11:03:24 -0400
Subject: [PATCHv2 1/3] arm: introduce config HAS_BANDGAP
In-Reply-To: <1368629928-6723-2-git-send-email-eduardo.valentin@ti.com>
References: <1368629928-6723-1-git-send-email-eduardo.valentin@ti.com>
 <1368629928-6723-2-git-send-email-eduardo.valentin@ti.com>
Message-ID: <51A8BBBC.9000505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony, Russell,



On 15-05-2013 10:58, Eduardo Valentin wrote:
> Introduce HAS_BANDGAP config entry. This config is a
> boolean value so that arch code can flag is they
> feature a bandgap device.
> 
> This config entry follows the same idea behind
> ARCH_HAS_CPUFREQ.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-omap at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>

Gentle reminder on this one.

> ---
>  arch/arm/Kconfig            | 3 +++
>  arch/arm/mach-omap2/Kconfig | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index d423d58..bcbdec9 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -174,6 +174,9 @@ config ARCH_HAS_CPUFREQ
>  	  and that the relevant menu configurations are displayed for
>  	  it.
>  
> +config ARCH_HAS_BANDGAP
> +	bool
> +
>  config GENERIC_HWEIGHT
>  	bool
>  	default y
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index f49cd51..8620ab5 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -4,6 +4,7 @@ config ARCH_OMAP
>  config ARCH_OMAP2PLUS
>  	bool "TI OMAP2/3/4/5 SoCs with device tree support" if (ARCH_MULTI_V6 || ARCH_MULTI_V7)
>  	select ARCH_HAS_CPUFREQ
> +	select ARCH_HAS_BANDGAP
>  	select ARCH_HAS_HOLES_MEMORYMODEL
>  	select ARCH_OMAP
>  	select ARCH_REQUIRE_GPIOLIB
> 


-- 
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 295 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130531/5c661b74/attachment.sig>
