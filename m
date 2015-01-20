From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 Jan 2015 13:36:34 +0000
Subject: [RFC PATCHv2 18/19] mfd: ab8500: Decrement the power supply's
 device reference counter
In-Reply-To: <1420472882-10463-19-git-send-email-k.kozlowski@samsung.com>
References: <1420472882-10463-1-git-send-email-k.kozlowski@samsung.com>
 <1420472882-10463-19-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20150120133634.GH13701@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 05 Jan 2015, Krzysztof Kozlowski wrote:

> Use power_supply_put() to decrement the power supply's device reference
> counter.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>

You've sent this to me already Acked.  I don't see 00/00, so I have no
idea what's going on.  Do you want me to take this patch?  Can it be
taking on its own?

> ---
>  drivers/mfd/ab8500-sysctrl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
> index d4a4b24be7c6..0d1825696153 100644
> --- a/drivers/mfd/ab8500-sysctrl.c
> +++ b/drivers/mfd/ab8500-sysctrl.c
> @@ -51,6 +51,7 @@ static void ab8500_power_off(void)
>  
>  		ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
>  				&val);
> +		power_supply_put(psy);
>  
>  		if (!ret && val.intval) {
>  			charger_present = true;
> @@ -73,6 +74,7 @@ static void ab8500_power_off(void)
>  			       pss[i]);
>  			machine_restart("charging");
>  		}
> +		power_supply_put(psy);
>  	}
>  
>  shutdown:

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
