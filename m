From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 26 Oct 2009 18:28:37 -0400
Subject: [PATCH 2/2] ep93xx: fix missing commu in ep93xx_register_i2c
	formachines edb9307/12/15
In-Reply-To: <1256594690-9872-1-git-send-email-plagnioj@jcrosoft.com>
References: <1256594665-9837-1-git-send-email-plagnioj@jcrosoft.com>
	<1256594690-9872-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901E24EFB@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 26, 2009 3:05 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> Subject: [PATCH 2/2] ep93xx: fix missing commu in ep93xx_register_i2c formachines edb9307/12/15
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  arch/arm/mach-ep93xx/edb93xx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
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

This patch is already in Russell's Patch Tracker as 5760/1.

Regards,
Hartley
