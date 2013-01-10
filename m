From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 09 Jan 2013 23:12:07 -0800
Subject: [PATCH 01/16] ARM: b.L: secondary kernel entry code
In-Reply-To: <1357777251-13541-2-git-send-email-nicolas.pitre@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-2-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <50EE69C7.6010802@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/9/2013 4:20 PM, Nicolas Pitre wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f95ba14ae3..2271f02e8e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1579,6 +1579,12 @@ config HAVE_ARM_TWD
>  	help
>  	  This options enables support for the ARM timer and watchdog unit
>  
> +config BIG_LITTLE
> +	bool "big.LITTLE support (Experimental)"
> +	depends on CPU_V7 && SMP && EXPERIMENTAL

I thought EXPERIMENTAL was being phased out?

> diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
> index e8a4e58f1b..50880c494f 100644
> --- a/arch/arm/common/Makefile
> +++ b/arch/arm/common/Makefile
> @@ -13,3 +13,6 @@ obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
>  obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
>  obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
>  obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
> +obj-$(CONFIG_FIQ_GLUE)		+= fiq_glue.o fiq_glue_setup.o
> +obj-$(CONFIG_FIQ_DEBUGGER)	+= fiq_debugger.o

This looks like non-related stuff?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
