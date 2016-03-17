From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 17 Mar 2016 14:54:47 +0100
Subject: [PATCH v2] ARM: rockchip: Fix use of plain integer as NULL pointer
In-Reply-To: <1458222191-26023-1-git-send-email-peter.griffin@linaro.org>
References: <1458222191-26023-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <3852103.Khn1BuqerF@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

no need to resend for that (will be lost when applying anyway), but for future 
patches please consider the things below:

Am Donnerstag, 17. M?rz 2016, 13:43:11 schrieb Peter Griffin:
> This fixes the following sparse build warning:
> 
>      mach-rockchip/platsmp.c:68:43: Using plain integer as NULL pointer
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

please bring aling tags received in previous versions to future ones, like the 
one from Lee:

Acked-by: Lee Jones <lee.jones@linaro.org>

> ---

changes in v2:
- beautify commit message


otherwise, patch looks nice and I'll pick it up shortly


Thanks for catching this
Heiko

>  arch/arm/mach-rockchip/platsmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/platsmp.c
> b/arch/arm/mach-rockchip/platsmp.c index d42a07e..4d827a0 100644
> --- a/arch/arm/mach-rockchip/platsmp.c
> +++ b/arch/arm/mach-rockchip/platsmp.c
> @@ -65,7 +65,7 @@ static struct reset_control *rockchip_get_core_reset(int
> cpu) if (dev)
>  		np = dev->of_node;
>  	else
> -		np = of_get_cpu_node(cpu, 0);
> +		np = of_get_cpu_node(cpu, NULL);
> 
>  	return of_reset_control_get(np, NULL);
>  }
