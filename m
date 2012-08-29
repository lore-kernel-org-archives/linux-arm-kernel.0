From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 29 Aug 2012 18:14:08 -0500
Subject: [PATCH 1/6] ARM: move ARCH config definitions into mach dirs
In-Reply-To: <1346280600-29395-2-git-send-email-robherring2@gmail.com>
References: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
 <1346280600-29395-2-git-send-email-robherring2@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206B1D9F2E4@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 29, 2012 3:50 PM, Rob Herring wrote:
>
> In preparation for mulit-platform support, convert all platforms' ARCH_
> definition to a hidden option and create a new choice option.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/Kconfig                 |  650 ++++++++------------------------------

<snip>

> arch/arm/mach-ep93xx/Kconfig     |   11 +

<snip>

>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig

<snip>

> -config ARCH_EP93XX
> +config ARCH_EP93XX_CHOICE
>  	bool "EP93xx-based"
> -	select CPU_ARM920T
> -	select ARM_AMBA
> -	select ARM_VIC
> -	select CLKDEV_LOOKUP
> -	select ARCH_REQUIRE_GPIOLIB
> -	select ARCH_HAS_HOLES_MEMORYMODEL
> -	select ARCH_USES_GETTIMEOFFSET
> -	select NEED_MACH_MEMORY_H
> +	select ARCH_EP93XX
>  	help
>  	  This enables support for the Cirrus EP93xx series of CPUs.

<snip>

> diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
> index fe3c1fa..4cf770c 100644
> --- a/arch/arm/mach-ep93xx/Kconfig
> +++ b/arch/arm/mach-ep93xx/Kconfig
> @@ -1,3 +1,14 @@
> +config ARCH_EP93XX
> +	bool
> +	select ARCH_REQUIRE_GPIOLIB
> +	select ARCH_HAS_HOLES_MEMORYMODEL
> +	select ARCH_USES_GETTIMEOFFSET
> +	select ARM_AMBA
> +	select ARM_VIC
> +	select CLKDEV_LOOKUP
> +	select CPU_ARM920T
> +	select NEED_MACH_MEMORY_H
> +
>  if ARCH_EP93XX
 >
>  menu "Cirrus EP93xx Implementation Options"

Curious... Why did you rearrange the select's? There "almost"
alphabetic now, but not quite...

But, FWIW, for the EP93xx part:

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Thanks
