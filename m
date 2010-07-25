From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 25 Jul 2010 23:35:21 +0100
Subject: [PATCH RFC] h1940: use gpiolib for latch access
In-Reply-To: <1280076072-1049-1-git-send-email-anarsoul@gmail.com>
References: <1280076072-1049-1-git-send-email-anarsoul@gmail.com>
Message-ID: <20100725223521.GA14747@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 25, 2010 at 07:41:12PM +0300, Vasily Khoruzhick wrote:
> diff --git a/arch/arm/mach-s3c2410/include/mach/h1940-latch.h b/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
> index d8a8327..4607d5c 100644
> --- a/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
> +++ b/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
> @@ -14,51 +14,30 @@
>  #ifndef __ASM_ARCH_H1940_LATCH_H
>  #define __ASM_ARCH_H1940_LATCH_H
>  
> +#include <mach/gpio.h>

Would linux/gpio.h make more sense here?

> diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
> index 779b45b..693f467 100644
> --- a/arch/arm/mach-s3c2410/mach-h1940.c
> +++ b/arch/arm/mach-s3c2410/mach-h1940.c
> @@ -42,6 +42,7 @@
>  #include <mach/regs-gpio.h>
>  #include <mach/gpio-fns.h>
>  #include <mach/gpio-nrs.h>
> +#include <mach/gpio.h>

linux/gpio.h ?
