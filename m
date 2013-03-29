From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 28 Mar 2013 21:18:01 -0400
Subject: [PATCH] ARM: dove: fix Dove cpu type from V7 to PJ4
In-Reply-To: <20130328210412.GG3368@n2100.arm.linux.org.uk>
References: <1364051211-24414-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130328170654.GX13280@titan.lakedaemon.net>
 <20130328181425.GE3368@n2100.arm.linux.org.uk>
 <5154A5B5.7@gmail.com>
 <20130328210412.GG3368@n2100.arm.linux.org.uk>
Message-ID: <20130329011801.GF13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 09:04:12PM +0000, Russell King - ARM Linux wrote:
...
> From what I could see, there's not much point to pj4-cp0.c without
> iwmmxt.S also being built.  So, what I'd suggest is this, which will
> ensure IWMMXT is enabled when PJ4 is set, otherwise giving people the
> choice as it used to be.
> 

Russell,

Are you going to take these two patches?  I don't want to assume and
have them potentially get lost.

thx,

Jason.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 67874b8..ef6733a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1171,9 +1171,9 @@ config ARM_NR_BANKS
>  	default 8
>  
>  config IWMMXT
> -	bool "Enable iWMMXt support"
> +	bool "Enable iWMMXt support" if !CPU_PJ4
>  	depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4
> -	default y if PXA27x || PXA3xx || ARCH_MMP
> +	default y if PXA27x || PXA3xx || ARCH_MMP || CPU_PJ4
>  	help
>  	  Enable support for iWMMXt context switching at run time if
>  	  running on a CPU that supports it.
> 
