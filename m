From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 18 Feb 2016 12:48:28 -0500 (EST)
Subject: [PATCH] ARM: Allow MULTIPLATFORM to select XIP
In-Reply-To: <1455816310-11308-1-git-send-email-chris.brandt@renesas.com>
References: <1455816310-11308-1-git-send-email-chris.brandt@renesas.com>
Message-ID: <alpine.LFD.2.20.1602181244490.13632@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Feb 2016, Chris Brandt wrote:

> As Multiplatform seems to be the way of the future, you should not restrict
> from selecting XIP. Whether it makes sense or not depends on how you
> configure the rest of the kernel (as in, removing individual platforms).
> Also, it stands to reason that if you select MULTIPLATFORM and XIP_KERNEL,
> you either know what you are doing...or have NO idea what you are doing.

There are simply too many people who don't know what they're doing.

And realistically it makes no sense to use XIP (surely because you 
need to save space) and have multi-platform support in your kernel.

IMHO it should be clear that with XIP there is only one platform that 
can be supported.




> 
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
>  arch/arm/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index cc95ff8..2e4a127 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -327,7 +327,7 @@ config ARCH_MULTIPLATFORM
>  	depends on MMU
>  	select ARCH_WANT_OPTIONAL_GPIOLIB
>  	select ARM_HAS_SG_CHAIN
> -	select ARM_PATCH_PHYS_VIRT
> +	select ARM_PATCH_PHYS_VIRT if !XIP_KERNEL
>  	select AUTO_ZRELADDR
>  	select CLKSRC_OF
>  	select COMMON_CLK
> @@ -1919,7 +1919,7 @@ endchoice
>  
>  config XIP_KERNEL
>  	bool "Kernel Execute-In-Place from ROM"
> -	depends on !ARM_LPAE && !ARCH_MULTIPLATFORM
> +	depends on !ARM_LPAE
>  	help
>  	  Execute-In-Place allows the kernel to run from non-volatile storage
>  	  directly addressable by the CPU, such as NOR flash. This saves RAM
> -- 
> 1.9.1
> 
> 
> 
