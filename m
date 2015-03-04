From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 04 Mar 2015 06:51:51 -0800
Subject: [PATCH v3 3/9] watchdog: at91rm9200: use the system timer syscon
In-Reply-To: <1425478897-27322-4-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425478897-27322-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425478897-27322-4-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <54F71C07.6070204@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2015 06:21 AM, Alexandre Belloni wrote:
> Use a syscon regmap to access the systemr timer registers.
>
s/systemr/system/

> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
...
>
>   static const struct of_device_id at91_wdt_dt_ids[] = {
> +	{ .compatible = "atmel,at91rm9200-st" },
>   	{ .compatible = "atmel,at91rm9200-wdt" },
>   	{ /* sentinel */ }
>   };
> @@ -267,7 +276,7 @@ static struct platform_driver at91wdt_driver = {
>   	.suspend	= at91wdt_suspend,
>   	.resume		= at91wdt_resume,
>   	.driver		= {
> -		.name	= "at91_wdt",
> +		.name	= "atmel_st_watchdog",

If you change the driver name you also need to change the MODULE_ALIAS
a few lines down.

But why change it in the first place ? Maybe that was discussed somewhere,
but not here where it belongs, and not in patch 0/9 either.

Guenter
