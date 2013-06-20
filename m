From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 21 Jun 2013 07:45:30 +0900
Subject: [GIT PULL 01/10] Samsung cleanup-1 for v3.11
In-Reply-To: <201306201730.38049.arnd@arndb.de>
References: <51C0BC37.7090604@samsung.com> <201306201730.38049.arnd@arndb.de>
Message-ID: <25b701ce6e07$ddec4b40$99c4e1c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:

[...]

> 
> I've had to apply this patch on top to get s5p to build cleanly again.
> It's part of next/cleanup now as well.
> 
> 	Arnd
> 
> From 854f1c88e6ab7c8a12a49913e8b1648f96af0701 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Thu, 20 Jun 2013 17:27:13 +0200
> Subject: [PATCH] ARM: s5p64x0: avoid build warning for uncompress.h
> 
> Commit 5336539 "ARM: S5P64X0: Use common uncompress.h part
> for plat-samsung" was missing a type cast, this brings
> it in line with the other samsung platforms.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
Yes, thanks for fix it and if you want,

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

probably, you can't amend it though :)

- Kukjin

> diff --git a/arch/arm/mach-s5p64x0/include/mach/uncompress.h
> b/arch/arm/mach-s5p64x0/include/mach/uncompress.h
> index bc04bd5..bbcc3f6 100644
> --- a/arch/arm/mach-s5p64x0/include/mach/uncompress.h
> +++ b/arch/arm/mach-s5p64x0/include/mach/uncompress.h
> @@ -23,9 +23,9 @@ static void arch_detect_cpu(void)
>  	chipid = *(const volatile unsigned int __force *) 0xE0100118;
> 
>  	if ((chipid & 0xff000) == 0x50000)
> -		uart_base = S5P6450_PA_UART(CONFIG_S3C_LOWLEVEL_UART_PORT);
> +		uart_base = (volatile u8
> *)S5P6450_PA_UART(CONFIG_S3C_LOWLEVEL_UART_PORT);
>  	else
> -		uart_base = S5P6440_PA_UART(CONFIG_S3C_LOWLEVEL_UART_PORT);
> +		uart_base = (volatile u8
> *)S5P6440_PA_UART(CONFIG_S3C_LOWLEVEL_UART_PORT);
> 
>  	fifo_mask = S3C2440_UFSTAT_TXMASK;
>  	fifo_max = 63 << S3C2440_UFSTAT_TXSHIFT;
