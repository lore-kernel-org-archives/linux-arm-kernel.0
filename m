From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Nov 2012 18:16:37 +0100
Subject: [PATCH 1/3] i2c: at91: fix compilation warning
In-Reply-To: <1352911493-6979-2-git-send-email-ludovic.desroches@atmel.com>
References: <1352911493-6979-1-git-send-email-ludovic.desroches@atmel.com>
 <1352911493-6979-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <50A52375.4070304@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2012 05:44 PM, ludovic.desroches at atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Maybe tell Wolfram to remove this one from the series and add it to his
3.7 tree...

Bye,

> ---
>  drivers/i2c/busses/i2c-at91.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index a6670eb..dc8cb22 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -412,7 +412,7 @@ static struct at91_twi_pdata * __devinit at91_twi_get_driver_data(
>  		match = of_match_node(atmel_twi_dt_ids, pdev->dev.of_node);
>  		if (!match)
>  			return NULL;
> -		return match->data;
> +		return (struct at91_twi_pdata *) match->data;
>  	}
>  	return (struct at91_twi_pdata *) platform_get_device_id(pdev)->driver_data;
>  }
> 


-- 
Nicolas Ferre
