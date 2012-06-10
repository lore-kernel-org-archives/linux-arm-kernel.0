From: robherring2@gmail.com (Rob Herring)
Date: Sun, 10 Jun 2012 17:39:01 -0500
Subject: [PATCH] ARM: nomadik: bump all IRQ numbers by one
In-Reply-To: <1339349778-32729-1-git-send-email-linus.walleij@linaro.org>
References: <1339349778-32729-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <4FD52205.5090509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2012 12:36 PM, Linus Walleij wrote:
> Since the VIC was converted to use generic IRQ domains IRQ 0
> is silently ignored. This IRQ is used on the Nomadik so we're
> missing it now. Bump all IRQ numbers by one since they are
> now decoupled from the hardware IRQ numbers.
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Really, we'd like to skip over 0-15 (legacy ISA irqs) and start at 16,
but it's not that important and I'd hope all this gets deleted soon anyway.

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  arch/arm/mach-nomadik/include/mach/irqs.h |   85 ++++++++++++++---------------
>  1 files changed, 42 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/arm/mach-nomadik/include/mach/irqs.h b/arch/arm/mach-nomadik/include/mach/irqs.h
> index 8faabc5..a118e61 100644
> --- a/arch/arm/mach-nomadik/include/mach/irqs.h
> +++ b/arch/arm/mach-nomadik/include/mach/irqs.h
> @@ -22,56 +22,56 @@
>  
>  #include <mach/hardware.h>
>  
> -#define IRQ_VIC_START		0	/* first VIC interrupt is 0 */
> +#define IRQ_VIC_START		1	/* first VIC interrupt is 1 */
>  
>  /*
>   * Interrupt numbers generic for all Nomadik Chip cuts
>   */
> -#define IRQ_WATCHDOG			0
> -#define IRQ_SOFTINT			1
> -#define IRQ_CRYPTO			2
> -#define IRQ_OWM				3
> -#define IRQ_MTU0			4
> -#define IRQ_MTU1			5
> -#define IRQ_GPIO0			6
> -#define IRQ_GPIO1			7
> -#define IRQ_GPIO2			8
> -#define IRQ_GPIO3			9
> -#define IRQ_RTC_RTT			10
> -#define IRQ_SSP				11
> -#define IRQ_UART0			12
> -#define IRQ_DMA1			13
> -#define IRQ_CLCD_MDIF			14
> -#define IRQ_DMA0			15
> -#define IRQ_PWRFAIL			16
> -#define IRQ_UART1			17
> -#define IRQ_FIRDA			18
> -#define IRQ_MSP0			19
> -#define IRQ_I2C0			20
> -#define IRQ_I2C1			21
> -#define IRQ_SDMMC			22
> -#define IRQ_USBOTG			23
> -#define IRQ_SVA_IT0			24
> -#define IRQ_SVA_IT1			25
> -#define IRQ_SAA_IT0			26
> -#define IRQ_SAA_IT1			27
> -#define IRQ_UART2			28
> -#define IRQ_MSP2			31
> -#define IRQ_L2CC			48
> -#define IRQ_HPI				49
> -#define IRQ_SKE				50
> -#define IRQ_KP				51
> -#define IRQ_MEMST			54
> -#define IRQ_SGA_IT			58
> -#define IRQ_USBM			60
> -#define IRQ_MSP1			62
> +#define IRQ_WATCHDOG			1
> +#define IRQ_SOFTINT			2
> +#define IRQ_CRYPTO			3
> +#define IRQ_OWM				4
> +#define IRQ_MTU0			5
> +#define IRQ_MTU1			6
> +#define IRQ_GPIO0			7
> +#define IRQ_GPIO1			8
> +#define IRQ_GPIO2			9
> +#define IRQ_GPIO3			10
> +#define IRQ_RTC_RTT			11
> +#define IRQ_SSP				12
> +#define IRQ_UART0			13
> +#define IRQ_DMA1			14
> +#define IRQ_CLCD_MDIF			15
> +#define IRQ_DMA0			16
> +#define IRQ_PWRFAIL			17
> +#define IRQ_UART1			18
> +#define IRQ_FIRDA			19
> +#define IRQ_MSP0			20
> +#define IRQ_I2C0			21
> +#define IRQ_I2C1			22
> +#define IRQ_SDMMC			23
> +#define IRQ_USBOTG			24
> +#define IRQ_SVA_IT0			25
> +#define IRQ_SVA_IT1			26
> +#define IRQ_SAA_IT0			27
> +#define IRQ_SAA_IT1			28
> +#define IRQ_UART2			29
> +#define IRQ_MSP2			30
> +#define IRQ_L2CC			49
> +#define IRQ_HPI				50
> +#define IRQ_SKE				51
> +#define IRQ_KP				52
> +#define IRQ_MEMST			55
> +#define IRQ_SGA_IT			59
> +#define IRQ_USBM			61
> +#define IRQ_MSP1			63
>  
> -#define NOMADIK_SOC_NR_IRQS		64
> +#define NOMADIK_GPIO_OFFSET		(IRQ_VIC_START+64)
>  
>  /* After chip-specific IRQ numbers we have the GPIO ones */
>  #define NOMADIK_NR_GPIO			128 /* last 4 not wired to pins */
> -#define NOMADIK_GPIO_TO_IRQ(gpio)	((gpio) + NOMADIK_SOC_NR_IRQS)
> -#define NOMADIK_IRQ_TO_GPIO(irq)	((irq) - NOMADIK_SOC_NR_IRQS)
> +#define NOMADIK_GPIO_TO_IRQ(gpio)	((gpio) + NOMADIK_GPIO_OFFSET)
> +#define NOMADIK_IRQ_TO_GPIO(irq)	((irq) - NOMADIK_GPIO_OFFSET)
>  #define NR_IRQS				NOMADIK_GPIO_TO_IRQ(NOMADIK_NR_GPIO)
>  
>  /* Following two are used by entry_macro.S, to access our dual-vic */
> @@ -79,4 +79,3 @@
>  #define VIC_REG_IRQSR1		0x20
>  
>  #endif /* __ASM_ARCH_IRQS_H */
> -
