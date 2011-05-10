From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 11 May 2011 01:45:26 +0200
Subject: [PATCH] AT91: Add external RTC for Flexibity board
In-Reply-To: <4DC53134.8070706@gmail.com>
References: <4DC53134.8070706@gmail.com>
Message-ID: <20110510234526.GC18929@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:47 Sat 07 May     , Maxim Osipov wrote:
> Hello,
> 
> This patch enables external RTC support on AT91 Flexibity board.
> 
> Kind regards,
> Maxim
> 
> 
> Signed-off-by: Maxim Osipov <maxim.osipov@gmail.com>
> ---
>  arch/arm/mach-at91/board-flexibity.c |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
> index c8a62dc..4fdc96c 100644
> --- a/arch/arm/mach-at91/board-flexibity.c
> +++ b/arch/arm/mach-at91/board-flexibity.c
> @@ -1,7 +1,7 @@
>  /*
>   * linux/arch/arm/mach-at91/board-flexibity.c
>   *
> - *  Copyright (C) 2010 Flexibity
> + *  Copyright (C) 2010-2011 Flexibity
>   *  Copyright (C) 2005 SAN People
>   *  Copyright (C) 2006 Atmel
>   *
> @@ -65,6 +65,13 @@ static struct at91_udc_data __initdata flexibity_udc_data = {
>  	.pullup_pin	= 0,		/* pull-up driven by UDC */
>  };
>  
> +/* I2C devices */
> +static struct i2c_board_info __initdata flexibity_i2c_devices[] = {
> +	{
> +		I2C_BOARD_INFO("ds1307", 0x68),
> +	},
> +};
> +
looks fine just one comment please add your board to the new at91sam9260_defconfig

so we can compile it when compiling all the sam9260

Best Regards,
J.
