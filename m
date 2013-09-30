From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 30 Sep 2013 17:48:54 +0200
Subject: [PATCH v2] ARM: at91: cam60: fix incorrect placement of __initdata
 tag
In-Reply-To: <4748525.slmbI8ubRr@amdc1032>
References: <4748525.slmbI8ubRr@amdc1032>
Message-ID: <52499D66.9070203@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/09/2013 17:38, Bartlomiej Zolnierkiewicz :
> __initdata tag should be placed between the variable name and equal
> sign for the variable to be placed in the intended .init.data section.

Yes, okay. But please do not mix the removal of white lines with your 
modification.

> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Anyway, no need to resend it:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
> v2:
> - use __initdata as it is OK to do it
>
>   arch/arm/mach-at91/board-cam60.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
> index ade948b..ecabbed 100644
> --- a/arch/arm/mach-at91/board-cam60.c
> +++ b/arch/arm/mach-at91/board-cam60.c
> @@ -108,16 +108,14 @@ static struct spi_board_info cam60_spi_devices[] __initdata = {
>   #endif
>   };
>
> -
>   /*
>    * MACB Ethernet device
>    */
> -static struct __initdata macb_platform_data cam60_macb_data = {
> +static struct macb_platform_data cam60_macb_data __initdata = {
>   	.phy_irq_pin	= AT91_PIN_PB5,
>   	.is_rmii	= 0,
>   };
>
> -
>   /*
>    * NAND Flash
>    */
>


-- 
Nicolas Ferre
