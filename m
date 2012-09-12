From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Sep 2012 20:45:16 +0000
Subject: [PATCH v2 6/6] ARM: make mach/gpio.h headers optional
In-Reply-To: <1346960563-18689-7-git-send-email-robherring2@gmail.com>
References: <1346960563-18689-1-git-send-email-robherring2@gmail.com>
 <1346960563-18689-7-git-send-email-robherring2@gmail.com>
Message-ID: <201209122045.17116.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 September 2012, Rob Herring wrote:
> diff --git a/arch/arm/mach-ux500/include/mach/gpio.h b/arch/arm/mach-ux500/include/mach/gpio.h
> deleted file mode 100644
> index c01ef66..0000000
> --- a/arch/arm/mach-ux500/include/mach/gpio.h
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -#ifndef __ASM_ARCH_GPIO_H
> -#define __ASM_ARCH_GPIO_H
> -
> -
> -#endif /* __ASM_ARCH_GPIO_H */

Another one: this file is included by
drivers/staging/ste_rmi4/board-mop500-u8500uib-rmi4.c, but that obviously doesn't need
it, so the #include needs to be removed.

	Arnd
