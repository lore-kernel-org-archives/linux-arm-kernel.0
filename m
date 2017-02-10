From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 10 Feb 2017 09:29:32 -0800
Subject: [PATCH 1/4] ARM: add CPU_THUMB_CAPABLE to indicate possible Thumb
 support
In-Reply-To: <E1cbngI-00025v-UE@rmk-PC.armlinux.org.uk>
References: <20170209121756.GC27312@n2100.armlinux.org.uk>
 <E1cbngI-00025v-UE@rmk-PC.armlinux.org.uk>
Message-ID: <ac402201-ffc4-36fb-b657-2f8bc6ea51be@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2017 04:18 AM, Russell King wrote:
> @@ -410,11 +429,17 @@ config CPU_V7M
>  
>  config CPU_THUMBONLY
>  	bool
> +	select CPU_THUMB_CAPABLE
>  	# There are no CPUs available with MMU that don't implement an ARM ISA:
>  	depends on !MMU
>  	help
>  	  Select this if your CPU doesn't support the 32 bit ARM instructions.
>  
> +config CPU_THUMB_CAPABLE
> +	bool
> +	help
> +	  Selected this if your CPU can support Thumb mode

s/Selected/Select/ ?Also add the full stop like the previous help text?

> +
>  # Figure out what processor architecture version we should be using.
>  # This defines the compiler instruction set which depends on the machine type.
>  config CPU_32v3
> @@ -655,11 +680,7 @@ config ARCH_DMA_ADDR_T_64BIT
>  
>  config ARM_THUMB
>  	bool "Support Thumb user binaries" if !CPU_THUMBONLY
> -	depends on CPU_ARM720T || CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || \
> -		CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || \
> -		CPU_ARM1020 || CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
> -		CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_V6 || CPU_V6K || \
> -		CPU_V7 || CPU_FEROCEON || CPU_V7M
> +	depends on CPU_THUMB_CAPABLE

Nice!

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
