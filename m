From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 25 Mar 2013 18:33:43 +0800
Subject: [PATCH 4/8] ARM: sirf: enable sparse IRQ
In-Reply-To: <1363779679-16880-5-git-send-email-arnd@arndb.de>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
 <1363779679-16880-5-git-send-email-arnd@arndb.de>
Message-ID: <CAGsJ_4xUjH_kcMv4=r8-duZFR9Xz25V-KZRGwv0SM8pUAnfdyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/20, Arnd Bergmann <arnd@arndb.de>:
> Now that both irqchips for sirf are converted to not rely on
> legacy domains, let's move all of the platform over to sparse
> IRQ.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig                         |  1 +
>  arch/arm/mach-prima2/include/mach/irqs.h | 17 -----------------
>  2 files changed, 1 insertion(+), 17 deletions(-)
>  delete mode 100644 arch/arm/mach-prima2/include/mach/irqs.h
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5bfd584..c674b32 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -427,6 +427,7 @@ config ARCH_SIRF
>  	select PINCTRL
>  	select PINCTRL_SIRF
>  	select USE_OF
> +	select SPARSE_IRQ
>  	help
>  	  Support for CSR SiRFprimaII/Marco/Polo platforms
>
> diff --git a/arch/arm/mach-prima2/include/mach/irqs.h
> b/arch/arm/mach-prima2/include/mach/irqs.h
> deleted file mode 100644
> index b778a0f..0000000
> --- a/arch/arm/mach-prima2/include/mach/irqs.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -/*
> - * arch/arm/mach-prima2/include/mach/irqs.h
> - *
> - * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group
> company.
> - *
> - * Licensed under GPLv2 or later.
> - */
> -
> -#ifndef __ASM_ARCH_IRQS_H
> -#define __ASM_ARCH_IRQS_H
> -
> -#define SIRFSOC_INTENAL_IRQ_START  0
> -#define SIRFSOC_INTENAL_IRQ_END    127
> -#define SIRFSOC_GPIO_IRQ_START     (SIRFSOC_INTENAL_IRQ_END + 1)
> -#define NR_IRQS	288

after dropping NR_IRQS and enabling SPARSE_IRQ, should we add .nr_irqs
= 288 to MACHINE_START(ATLAS6/PRIMA2/MARCO_DT...)?

-barry
