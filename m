From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 22 Apr 2010 12:19:56 +0200
Subject: [PATCH] ARM: pxa/raumfeld: fix button name
In-Reply-To: <1271576129-16133-1-git-send-email-daniel@caiaq.de>
References: <1271576129-16133-1-git-send-email-daniel@caiaq.de>
Message-ID: <20100422101956.GV30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 18, 2010 at 09:35:29AM +0200, Daniel Mack wrote:
> "on/off button" was recently renamed to remove the slash character.
> Follow that change in the pin polarity detection as well.
> 
> While at it, fix another cosmetic coding style flaw as well.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Eric Miao <eric.y.miao@gmail.com>

Eric, can you apply this? Would be nice to have it in .34, but not
totally mandatory.

Thanks,
Daniel


> ---
>  arch/arm/mach-pxa/raumfeld.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
> index 3bbc2d8..7582a12 100644
> --- a/arch/arm/mach-pxa/raumfeld.c
> +++ b/arch/arm/mach-pxa/raumfeld.c
> @@ -1001,7 +1001,7 @@ static void __init raumfeld_common_init(void)
>  		int i;
>  
>  		for (i = 0; i < ARRAY_SIZE(gpio_keys_button); i++)
> -			if (!strcmp(gpio_keys_button[i].desc, "on/off button"))
> +			if (!strcmp(gpio_keys_button[i].desc, "on_off button"))
>  				gpio_keys_button[i].active_low = 1;
>  	}
>  
> @@ -1027,8 +1027,7 @@ static void __init raumfeld_common_init(void)
>  		gpio_direction_output(GPIO_W2W_PDN, 0);
>  
>  	/* this can be used to switch off the device */
> -	ret = gpio_request(GPIO_SHUTDOWN_SUPPLY,
> -				"supply shutdown");
> +	ret = gpio_request(GPIO_SHUTDOWN_SUPPLY, "supply shutdown");
>  	if (ret < 0)
>  		pr_warning("Unable to request GPIO_SHUTDOWN_SUPPLY\n");
>  	else
> -- 
> 1.7.0.3
> 
