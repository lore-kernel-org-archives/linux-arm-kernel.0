From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 9 Aug 2011 12:04:30 -0500
Subject: [PATCH 13/13] ARM: gpio: make trivial GPIOLIB implementation
	the	default
In-Reply-To: <E1QqhMg-0003an-GW@rmk-PC.arm.linux.org.uk>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
	<E1QqhMg-0003an-GW@rmk-PC.arm.linux.org.uk>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F388389379@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 09, 2011 1:09 AM, Russell King wrote:
>
> Rather than marking the mach/gpio.h header files which want to use the
> trivial GPIOLIB implementation, mark those which do not want to use it
> instead.  This means that by default, you get the trivial implementation
> and only have to do something extra if you need to.  This should
> encourage the use of the trivial default implementation.
> 
> As an additional bonus, several gpio.h header files become empty.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/gpio.h                 |    2 +-
>  arch/arm/include/asm/hardware/iop3xx-gpio.h |    2 ++
> 
> diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
> index 5032224..11ad0bf 100644
> --- a/arch/arm/include/asm/gpio.h
> +++ b/arch/arm/include/asm/gpio.h
> @@ -4,7 +4,7 @@
>  /* not all ARM platforms necessarily support this API ... */
>  #include <mach/gpio.h>
>  
> -#ifdef __ARM_GPIOLIB_TRIVIAL
> +#ifndef __ARM_GPIOLIB_COMPLEX
>  /* Note: this may rely upon the value of ARCH_NR_GPIOS set in mach/gpio.h */
>  #include <asm-generic/gpio.h>
>  
> diff --git a/arch/arm/mach-ep93xx/include/mach/gpio.h b/arch/arm/mach-ep93xx/include/mach/gpio.h
> index fbc770e..071f676 100644
> --- a/arch/arm/mach-ep93xx/include/mach/gpio.h
> +++ b/arch/arm/mach-ep93xx/include/mach/gpio.h
> @@ -99,9 +99,6 @@
>  /* maximum value for irq capable line identifiers */
>  #define EP93XX_GPIO_LINE_MAX_IRQ	EP93XX_GPIO_LINE_F(7)
>  
> -/* new generic GPIO API - see Documentation/gpio.txt */
> -#define __ARM_GPIOLIB_TRIVIAL
> -
>  /*
>   * Map GPIO A0..A7  (0..7)  to irq 64..71,
>   *          B0..B7  (7..15) to irq 72..79, and

For ep93xx:

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Thanks!
