From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 15 Aug 2011 19:20:50 -0400 (EDT)
Subject: Enabling runtime P2V by default (Re: [PATCH 3/5] mach-u300:
	patch physoffset by default)
In-Reply-To: <20110811082413.GA4775@n2100.arm.linux.org.uk>
References: <1312918898-11894-1-git-send-email-linus.walleij@stericsson.com>
	<20110810091635.GF1831@n2100.arm.linux.org.uk>
	<20110810092206.GE10121@e102144-lin.cambridge.arm.com>
	<20110810092955.GG1831@n2100.arm.linux.org.uk>
	<20110811082413.GA4775@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1108151919110.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 Aug 2011, Russell King - ARM Linux wrote:

> Enable virtual to physical translation patching by default in all
> kernels.  Hide the option behind EMBEDDED.
> 
> This can still be turned off if people desire, and they know what
> they're doing, to shrink the size of the kernel to a minimum.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

> ---
>  arch/arm/Kconfig |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5ebc5d9..6085a6c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -195,7 +195,8 @@ config VECTORS_BASE
>  	  The base address of exception vectors.
>  
>  config ARM_PATCH_PHYS_VIRT
> -	bool "Patch physical to virtual translations at runtime"
> +	bool "Patch physical to virtual translations at runtime" if EMBEDDED
> +	default y
>  	depends on !XIP_KERNEL && MMU
>  	depends on !ARCH_REALVIEW || !SPARSEMEM
>  	help
> @@ -207,6 +208,10 @@ config ARM_PATCH_PHYS_VIRT
>  	  of physical memory is at a 16MB boundary, or theoretically 64K
>  	  for the MSM machine class.
>  
> +	  Only disable this option if you know what you do not require
> +	  this feature (eg, building a kernel for a single machine) and
> +	  you need to shrink the kernel to the minimal size.
> +
>  config ARM_PATCH_PHYS_VIRT_16BIT
>  	def_bool y
>  	depends on ARM_PATCH_PHYS_VIRT && ARCH_MSM
> @@ -301,7 +306,6 @@ config ARCH_AT91
>  	select ARCH_REQUIRE_GPIOLIB
>  	select HAVE_CLK
>  	select CLKDEV_LOOKUP
> -	select ARM_PATCH_PHYS_VIRT if MMU
>  	help
>  	  This enables support for systems based on the Atmel AT91RM9200,
>  	  AT91SAM9 and AT91CAP9 processors.
> -- 
> 1.7.4.4
> 
> 
