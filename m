From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Mar 2011 11:05:14 +0100
Subject: [PATCH 09/10] ux500: Addressing irq header file dependency for
	snowball.
In-Reply-To: <1299884892-6766-10-git-send-email-mathieu.poirier@linaro.org>
References: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
	<1299884892-6766-10-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <201103121105.14621.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 March 2011 00:08:11 mathieu.poirier at linaro.org wrote:
> --- a/arch/arm/mach-ux500/include/mach/irqs.h
> +++ b/arch/arm/mach-ux500/include/mach/irqs.h
> @@ -36,7 +36,7 @@
>  /* This will be overridden by board-specific irq headers */
>  #define IRQ_BOARD_END                  IRQ_BOARD_START
>  
> -#ifdef CONFIG_MACH_U8500
> +#if defined CONFIG_MACH_U8500 || CONFIG_MACH_U8500_SNOWBALL
>  #include <mach/irqs-board-mop500.h>
>  #endif

Can't you just remove the #ifdef entirely? If you want to
be able to build a common kernel, these build-time conditionals
don't work anyway, so the irqs-* files need to be distinct.

The other option would be to remove the #include and directly
include the board specific irqs header from the board file.

In either case, the change would belong in the same patch as
the code that requires it. Just add a short notice about it
in the changelog.

	Arnd
