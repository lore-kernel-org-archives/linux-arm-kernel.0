From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 14 Oct 2009 13:41:20 +1300
Subject: [PATCH] ep93xx: fix build error in edb93xx.c
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901DB807D@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901DB807D@mi8nycmail19.Mi8.com>
Message-ID: <4AD51E30.4000804@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> Fix a build error due to a typo (missing comma) in:
> 
> 	ARM: 5754/1: ep93xx: update i2c support
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> 
> ---
> 
> diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
> index ca71cf1..a4a7be3 100644
> --- a/arch/arm/mach-ep93xx/edb93xx.c
> +++ b/arch/arm/mach-ep93xx/edb93xx.c
> @@ -112,7 +112,7 @@ static void __init edb93xx_register_i2c(void)
>  				    ARRAY_SIZE(edb93xxa_i2c_board_info));
>  	} else if (machine_is_edb9307() || machine_is_edb9312() ||
>  		   machine_is_edb9315()) {
> -		ep93xx_register_i2c(&edb93xx_i2c_gpio_data
> +		ep93xx_register_i2c(&edb93xx_i2c_gpio_data,
>  				    edb93xx_i2c_board_info,
>  				    ARRAY_SIZE(edb93xx_i2c_board_info));
>  	} 
> 

Acked-by: Ryan Mallon <ryan@bluewatersys.com>

How did it slip through?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
