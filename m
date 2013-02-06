From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 6 Feb 2013 19:30:24 +0100
Subject: [PATCH 1/2] ARM: netx: bump IRQ offset to 64
In-Reply-To: <1360168530-20337-1-git-send-email-linus.walleij@linaro.org>
References: <1360168530-20337-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20130206183024.GI1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 05:35:30PM +0100, Linus Walleij wrote:
> The Netx IRQs offset from zero, which is illegal, since Linux
> IRQ 0 is NO_IRQ.
> 
> Cc: Jamie Iles <jamie@jamieiles.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Jamie, Sascha: are you actually booting this machine from time
> to time? I think this has been broken for a while. I hope HEAD
> plus this patch will make it work anyway.

I would have to ask Juergen (Cced). Otherwise:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha


> ---
>  arch/arm/mach-netx/generic.c           |  2 +-
>  arch/arm/mach-netx/include/mach/irqs.h | 64 +++++++++++++++++-----------------
>  2 files changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/arm/mach-netx/generic.c b/arch/arm/mach-netx/generic.c
> index aa62746..9139ed2 100644
> --- a/arch/arm/mach-netx/generic.c
> +++ b/arch/arm/mach-netx/generic.c
> @@ -168,7 +168,7 @@ void __init netx_init_irq(void)
>  {
>  	int irq;
>  
> -	vic_init(io_p2v(NETX_PA_VIC), 0, ~0, 0);
> +	vic_init(io_p2v(NETX_PA_VIC), NETX_IRQ_VIC_START, ~0, 0);
>  
>  	for (irq = NETX_IRQ_HIF_CHAINED(0); irq <= NETX_IRQ_HIF_LAST; irq++) {
>  		irq_set_chip_and_handler(irq, &netx_hif_chip,
> diff --git a/arch/arm/mach-netx/include/mach/irqs.h b/arch/arm/mach-netx/include/mach/irqs.h
> index 6ce914d..8f74a84 100644
> --- a/arch/arm/mach-netx/include/mach/irqs.h
> +++ b/arch/arm/mach-netx/include/mach/irqs.h
> @@ -17,42 +17,42 @@
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>   */
>  
> -#define NETX_IRQ_VIC_START   0
> -#define NETX_IRQ_SOFTINT     0
> -#define NETX_IRQ_TIMER0      1
> -#define NETX_IRQ_TIMER1      2
> -#define NETX_IRQ_TIMER2      3
> -#define NETX_IRQ_SYSTIME_NS  4
> -#define NETX_IRQ_SYSTIME_S   5
> -#define NETX_IRQ_GPIO_15     6
> -#define NETX_IRQ_WATCHDOG    7
> -#define NETX_IRQ_UART0       8
> -#define NETX_IRQ_UART1       9
> -#define NETX_IRQ_UART2      10
> -#define NETX_IRQ_USB        11
> -#define NETX_IRQ_SPI        12
> -#define NETX_IRQ_I2C        13
> -#define NETX_IRQ_LCD        14
> -#define NETX_IRQ_HIF        15
> -#define NETX_IRQ_GPIO_0_14  16
> -#define NETX_IRQ_XPEC0      17
> -#define NETX_IRQ_XPEC1      18
> -#define NETX_IRQ_XPEC2      19
> -#define NETX_IRQ_XPEC3      20
> -#define NETX_IRQ_XPEC(no)   (17 + (no))
> -#define NETX_IRQ_MSYNC0     21
> -#define NETX_IRQ_MSYNC1     22
> -#define NETX_IRQ_MSYNC2     23
> -#define NETX_IRQ_MSYNC3     24
> -#define NETX_IRQ_IRQ_PHY    25
> -#define NETX_IRQ_ISO_AREA   26
> +#define NETX_IRQ_VIC_START	64
> +#define NETX_IRQ_SOFTINT	(NETX_IRQ_VIC_START + 0)
> +#define NETX_IRQ_TIMER0		(NETX_IRQ_VIC_START + 1)
> +#define NETX_IRQ_TIMER1		(NETX_IRQ_VIC_START + 2)
> +#define NETX_IRQ_TIMER2		(NETX_IRQ_VIC_START + 3)
> +#define NETX_IRQ_SYSTIME_NS	(NETX_IRQ_VIC_START + 4)
> +#define NETX_IRQ_SYSTIME_S	(NETX_IRQ_VIC_START + 5)
> +#define NETX_IRQ_GPIO_15	(NETX_IRQ_VIC_START + 6)
> +#define NETX_IRQ_WATCHDOG	(NETX_IRQ_VIC_START + 7)
> +#define NETX_IRQ_UART0		(NETX_IRQ_VIC_START + 8)
> +#define NETX_IRQ_UART1		(NETX_IRQ_VIC_START + 9)
> +#define NETX_IRQ_UART2		(NETX_IRQ_VIC_START + 10)
> +#define NETX_IRQ_USB		(NETX_IRQ_VIC_START + 11)
> +#define NETX_IRQ_SPI		(NETX_IRQ_VIC_START + 12)
> +#define NETX_IRQ_I2C		(NETX_IRQ_VIC_START + 13)
> +#define NETX_IRQ_LCD		(NETX_IRQ_VIC_START + 14)
> +#define NETX_IRQ_HIF		(NETX_IRQ_VIC_START + 15)
> +#define NETX_IRQ_GPIO_0_14	(NETX_IRQ_VIC_START + 16)
> +#define NETX_IRQ_XPEC0		(NETX_IRQ_VIC_START + 17)
> +#define NETX_IRQ_XPEC1		(NETX_IRQ_VIC_START + 18)
> +#define NETX_IRQ_XPEC2		(NETX_IRQ_VIC_START + 19)
> +#define NETX_IRQ_XPEC3		(NETX_IRQ_VIC_START + 20)
> +#define NETX_IRQ_XPEC(no)	(NETX_IRQ_VIC_START + 17 + (no))
> +#define NETX_IRQ_MSYNC0		(NETX_IRQ_VIC_START + 21)
> +#define NETX_IRQ_MSYNC1		(NETX_IRQ_VIC_START + 22)
> +#define NETX_IRQ_MSYNC2		(NETX_IRQ_VIC_START + 23)
> +#define NETX_IRQ_MSYNC3		(NETX_IRQ_VIC_START + 24)
> +#define NETX_IRQ_IRQ_PHY	(NETX_IRQ_VIC_START + 25)
> +#define NETX_IRQ_ISO_AREA	(NETX_IRQ_VIC_START + 26)
>  /* int 27 is reserved */
>  /* int 28 is reserved */
> -#define NETX_IRQ_TIMER3     29
> -#define NETX_IRQ_TIMER4     30
> +#define NETX_IRQ_TIMER3		(NETX_IRQ_VIC_START + 29)
> +#define NETX_IRQ_TIMER4		(NETX_IRQ_VIC_START + 30)
>  /* int 31 is reserved */
>  
> -#define NETX_IRQS 32
> +#define NETX_IRQS 		(NETX_IRQ_VIC_START + 32)
>  
>  /* for multiplexed irqs on gpio 0..14 */
>  #define NETX_IRQ_GPIO(x) (NETX_IRQS + (x))
> -- 
> 1.8.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
