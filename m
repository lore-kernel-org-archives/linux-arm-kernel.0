From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Oct 2011 14:53:53 +0100
Subject: [PATCH] asm-generic/gpio.h: merge basic gpiolib wrappers
In-Reply-To: <1319720503-3183-1-git-send-email-vapier@gentoo.org>
References: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1319720503-3183-1-git-send-email-vapier@gentoo.org>
Message-ID: <20111027135353.GM19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2011 at 09:01:43AM -0400, Mike Frysinger wrote:
> diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
> index 11ad0bf..741efb2 100644
> --- a/arch/arm/include/asm/gpio.h
> +++ b/arch/arm/include/asm/gpio.h
> @@ -5,14 +5,15 @@
>  #include <mach/gpio.h>
>  
>  #ifndef __ARM_GPIOLIB_COMPLEX
> +/* assume the mach has defined this */
> +#ifndef irq_to_gpio
> +#define irq_to_gpio irq_to_gpio
> +#endif

Oh, this isn't a valid assumption either - it's far from valid.  Those
sub-architectures which don't define __ARM_GPIOLIB_COMPLEX probably don't
define any kind of irq_to_gpio function by any means.  Some of our
mach/gpio.h header files for sub-architectures using entirely gpiolib
are entirely empty - and we want them to stay that way.
