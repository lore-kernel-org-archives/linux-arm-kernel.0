From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 8 Mar 2010 14:58:34 -0500
Subject: [PATCH] ep93xx: register the pwm devices on the ts72xx dev boards
In-Reply-To: <1268071608-5327-1-git-send-email-mcrapet@gmail.com>
References: <1268071608-5327-1-git-send-email-mcrapet@gmail.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190902242769@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 08, 2010 11:07 AM, Matthieu Crapet wrote:
> Add the platform init code to register the pwm device that exist
> on the various ts72xx development boards.
> 
> Signed-off-by: Matthieu Crapet <mcrapet@gmail.com>

Looks ok.

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

> ---
>  arch/arm/mach-ep93xx/ts72xx.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
> index 259f782..1acb7bf 100644
> --- a/arch/arm/mach-ep93xx/ts72xx.c
> +++ b/arch/arm/mach-ep93xx/ts72xx.c
> @@ -176,6 +176,9 @@ static void __init ts72xx_init_machine(void)
>  	ts72xx_register_flash();
>  	platform_device_register(&ts72xx_rtc_device);
>  
> +	/* PWM1 is DIO_6 on TS-72xx header */
> +	ep93xx_register_pwm(0, 1);
> +
>  	ep93xx_register_eth(&ts72xx_eth_data, 1);
>  }
