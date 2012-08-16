From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Thu, 16 Aug 2012 03:18:48 +0000
Subject: [PATCHv6 14/24] i2c: omap: always return IRQ_HANDLED
In-Reply-To: <1344953946-13005-15-git-send-email-shubhrajyoti@ti.com>
References: <1344953946-13005-1-git-send-email-shubhrajyoti@ti.com>
 <1344953946-13005-15-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA5F5B6@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 19:48:56, Datta, Shubhrajyoti wrote:
> From: Felipe Balbi <balbi@ti.com>
> 
> otherwise we could get our IRQ line disabled due
> to many spurious IRQs.

Patch description should be readable by itself. It is not a continuation of
subject line.

> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 80ebcf5..eb6898b 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -962,7 +962,7 @@ complete:
>  		}
>  	} while (stat);
>  
> -	return count ? IRQ_HANDLED : IRQ_NONE;
> +	return IRQ_HANDLED;
>  }
>  
>  static const struct i2c_algorithm omap_i2c_algo = {
> -- 
> 1.7.5.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


Regards, 
Gururaja
