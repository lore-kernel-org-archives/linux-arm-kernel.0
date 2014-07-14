From: rdunlap@infradead.org (Randy Dunlap)
Date: Mon, 14 Jul 2014 11:34:37 -0700
Subject: [PATCH] mach-s3c64xx: Remove all defintions not related to
 regs-clocks
In-Reply-To: <1405361664-5210-1-git-send-email-xerofoify@gmail.com>
References: <1405361664-5210-1-git-send-email-xerofoify@gmail.com>
Message-ID: <53C422BD.3070608@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/14 11:14, Nicholas Krause wrote:
> This patch addresses the fix me message in this file that states to
> remove all definitions not related to reg-clocks in this header
> file.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  arch/arm/mach-s3c64xx/include/mach/regs-clock.h | 22 +---------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h b/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
> index 4f44aac..46e64cc 100644
> --- a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
> +++ b/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
> @@ -15,24 +15,4 @@
>  #ifndef __PLAT_REGS_CLOCK_H
>  #define __PLAT_REGS_CLOCK_H __FILE__
>  
> -/*
> - * FIXME: Remove remaining definitions
> - */
> -
> -#define S3C_CLKREG(x)		(S3C_VA_SYS + (x))
> -
> -#define S3C_PCLK_GATE		S3C_CLKREG(0x34)

There is another header file that uses the #define S3C_PCLK_GATE above.
Deleting it here should be causing a problem here:

./arch/arm/mach-s3c64xx/include/mach/pm-core.h:24:	u32 tmp = __raw_readl(S3
C_PCLK_GATE);
./arch/arm/mach-s3c64xx/include/mach/pm-core.h:37:	__raw_writel(tmp, S3C_PC
LK_GATE);

Please check things like this in advance.

> -#define S3C6410_CLK_SRC2	S3C_CLKREG(0x10C)
> -#define S3C_MEM_SYS_CFG		S3C_CLKREG(0x120)
> -
> -/* PCLK GATE Registers */
> -#define S3C_CLKCON_PCLK_UART3		(1<<4)

used by pm-core.h

> -#define S3C_CLKCON_PCLK_UART2		(1<<3)

used by pm-core.h

> -#define S3C_CLKCON_PCLK_UART1		(1<<2)

used by pm-core.h

> -#define S3C_CLKCON_PCLK_UART0		(1<<1)

used by pm-core.h

> -
> -/* MEM_SYS_CFG */
> -#define MEM_SYS_CFG_INDEP_CF		0x4000
> -#define MEM_SYS_CFG_EBI_FIX_PRI_CFCON	0x30
> -
> -#endif /* _PLAT_REGS_CLOCK_H */
> +/#endif /* _PLAT_REGS_CLOCK_H */
> 


-- 
~Randy
