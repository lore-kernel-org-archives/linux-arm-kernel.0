From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 13 Jun 2017 15:02:02 +0200
Subject: [PATCH] ARM: at91: remove atmel_nand_data
In-Reply-To: <20170613125400.12774-1-alexandre.belloni@free-electrons.com>
References: <20170613125400.12774-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170613150202.7e0241f9@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Jun 2017 14:54:00 +0200
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> Since AVR32 is gone and the driver rework, struct atmel_nand_data is not
> used anywhere.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  include/linux/platform_data/atmel.h | 21 ---------------------
>  1 file changed, 21 deletions(-)
> 
> diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
> index 7b6dce7d6d33..70c5c766628e 100644
> --- a/include/linux/platform_data/atmel.h
> +++ b/include/linux/platform_data/atmel.h
> @@ -7,8 +7,6 @@
>  #ifndef __ATMEL_H__
>  #define __ATMEL_H__
>  
> -#include <linux/mtd/nand.h>
> -#include <linux/mtd/partitions.h>
>  #include <linux/serial.h>
>  
>   /* Compact Flash */
> @@ -23,25 +21,6 @@ struct at91_cf_data {
>  #define AT91_IDE_SWAP_A0_A2	0x02
>  };
>  
> - /* NAND / SmartMedia */
> -struct atmel_nand_data {
> -	int		enable_pin;		/* chip enable */
> -	int		det_pin;		/* card detect */
> -	int		rdy_pin;		/* ready/busy */
> -	u8		rdy_pin_active_low;	/* rdy_pin value is inverted */
> -	u8		ale;			/* address line number connected to ALE */
> -	u8		cle;			/* address line number connected to CLE */
> -	u8		bus_width_16;		/* buswidth is 16 bit */
> -	u8		ecc_mode;		/* ecc mode */
> -	u8		on_flash_bbt;		/* bbt on flash */
> -	struct mtd_partition *parts;
> -	unsigned int	num_parts;
> -	bool		has_dma;		/* support dma transfer */
> -
> -	/* default is false, only for at32ap7000 chip is true */
> -	bool		need_reset_workaround;
> -};
> -
>   /* Serial */
>  struct atmel_uart_data {
>  	int			num;		/* port num */
