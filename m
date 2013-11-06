From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 6 Nov 2013 09:41:17 +0100
Subject: linux-next: manual merge of the gpio tree with the arm-soc and
 cortex trees
In-Reply-To: <20131106191454.5f45b0b5300f03e74a6a09eb@canb.auug.org.au>
References: <20131106191454.5f45b0b5300f03e74a6a09eb@canb.auug.org.au>
Message-ID: <20131106084117.GT14892@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stephen,

On Wed, Nov 06, 2013 at 07:14:54PM +1100, Stephen Rothwell wrote:
> Hi Linus,
> 
> Today's linux-next merge of the gpio tree got a conflict in
> arch/arm/Kconfig between commit f3372c01816e ("ARM: gemini: convert to
> GENERIC_CLOCKEVENTS") from the arm-soc tree and f5caa3b59e18 ("ARM:
> deprecate mach/timex.h for !ARCH_MULTIPLATFORM") from the cortex tree and
> commits ffde39ea61ea ("ARM: mmp: delete the custom GPIO header"),
> 88f718e3fa4d ("ARM: pxa: delete the custom GPIO header") and 85649711a895
> ("ARM: gemini: delete <mach/gpio.h>") from the gpio tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).
looks correct.

BTW, "cortex" is a bit too general. My tree is only about Cortex-M. Also
you can drop -2.6 from the URL.

Best regards
Uwe
> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
> 
> diff --cc arch/arm/Kconfig
> index 568d6471dd18,c6debe07f036..000000000000
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@@ -397,10 -386,8 +397,9 @@@ config ARCH_CLPS711
>   config ARCH_GEMINI
>   	bool "Cortina Systems Gemini"
>   	select ARCH_REQUIRE_GPIOLIB
>  -	select ARCH_USES_GETTIMEOFFSET
>  +	select CLKSRC_MMIO
>   	select CPU_FA526
>  +	select GENERIC_CLOCKEVENTS
> - 	select NEED_MACH_GPIO_H
>   	help
>   	  Support for the Cortina Systems Gemini family SoCs
>   
> @@@ -593,8 -558,6 +592,7 @@@ config ARCH_MM
>   	select GPIO_PXA
>   	select IRQ_DOMAIN
>   	select MULTI_IRQ_HANDLER
> - 	select NEED_MACH_GPIO_H
>  +	select NEED_MACH_TIMEX_H
>   	select PINCTRL
>   	select PLAT_PXA
>   	select SPARSE_IRQ
> @@@ -658,8 -620,6 +656,7 @@@ config ARCH_PX
>   	select GPIO_PXA
>   	select HAVE_IDE
>   	select MULTI_IRQ_HANDLER
> - 	select NEED_MACH_GPIO_H
>  +	select NEED_MACH_TIMEX_H
>   	select PLAT_PXA
>   	select SPARSE_IRQ
>   	help



-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
