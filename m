From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 17 Oct 2009 16:44:07 +0200
Subject: [PATCH v3 5/7] [ARM]: U8500 integrate to ARM architecture
In-Reply-To: <1255300082.21542.413.camel@vinay-desktop>
References: <1255300073.21542.412.camel@vinay-desktop>
	<1255300082.21542.413.camel@vinay-desktop>
Message-ID: <20091017144407.GC14673@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03:58 Mon 12 Oct     , srinidhi kasagar wrote:
> From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> 
> This hooks the U8500 support into the ARM kbuild
> system. This integration also enables SMP and its
> helper funtions for u8500 platform
> 
> Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
> ---
>  arch/arm/Kconfig  |   19 +++++++++++++++----
>  arch/arm/Makefile |    1 +
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1c4119c..459f1ce 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -702,6 +702,15 @@ config ARCH_BCMRING
>  	help
>  	  Support for Broadcom's BCMRing platform.
>  
> +config ARCH_U8500
> +	bool "ST-Ericsson U8500 Series"
> +	select ARM_AMBA
> +	select GENERIC_TIME
> +	select GENERIC_CLOCKEVENTS
> +	select COMMON_CLKDEV
> +	help
> +	  Include support for ST-Ericsson's Cortex-A9 Platform.
> +
>  endchoice
>  
>  source "arch/arm/mach-clps711x/Kconfig"
> @@ -800,6 +809,8 @@ source "arch/arm/mach-msm/Kconfig"
>  
>  source "arch/arm/mach-u300/Kconfig"
>  
> +source "arch/arm/mach-ux500/Kconfig"
> +
>  source "arch/arm/mach-w90x900/Kconfig"
>  
>  source "arch/arm/mach-bcmring/Kconfig"
> @@ -955,10 +966,10 @@ source "kernel/time/Kconfig"
>  config SMP
>  	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
>  	depends on EXPERIMENTAL && (REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP ||\
> -		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4)
> +		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || ARCH_U8500)
I think it time to stop this and specify at arch or mach level the capability
to use SMP with
config HAS_SMP
	bool

>  config LOCAL_TIMERS
>  	bool "Use local timer interrupts"
>  	depends on SMP && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || \
> -		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4)
> +		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || ARCH_U8500)
same idea here

Best Regards,
J.
