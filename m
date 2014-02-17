From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 17 Feb 2014 18:57:15 -0500
Subject: [PATCH v2 12/23] ARM: Fix default CPU selection for ARCH_MULTI_V5
In-Reply-To: <1392459621-24003-13-git-send-email-andrew@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <1392459621-24003-13-git-send-email-andrew@lunn.ch>
Message-ID: <20140217235715.GL7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

12, 13, and 14 should go into rmk's patch tracker.

Russell, we'd really like to move kirkwood DT into mach-mvebu for v3.15.
Is there any possibility you could create a topic branch for us
containing the this patch and the other two I mentioned, above?

Or, if you don't think there will be any significant conflicts, would
you mind Acking these three for us to take through mvebu/arm-soc?

thx,

Jason.

On Sat, Feb 15, 2014 at 11:20:10AM +0100, Andrew Lunn wrote:
> CPU_ARM926T should be selected if no other CPU is. Put the ! in the
> right place so this works.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e25419817791..beba369d74de 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -898,7 +898,7 @@ config ARCH_MULTI_V5
>  	bool "ARMv5 based platforms (ARM926T, XSCALE, PJ1, ...)"
>  	depends on !ARCH_MULTI_V6_V7
>  	select ARCH_MULTI_V4_V5
> -	select CPU_ARM926T if (!CPU_ARM946E || CPU_ARM1020 || \
> +	select CPU_ARM926T if !(CPU_ARM946E || CPU_ARM1020 || \
>  		CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
>  		CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_FEROCEON)
>  
> -- 
> 1.8.5.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
