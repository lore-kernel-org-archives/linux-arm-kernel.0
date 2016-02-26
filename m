From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 26 Feb 2016 06:15:13 -0800
Subject: [PATCH v4 1/6] watchdog: pnx4008: update logging during power-on
In-Reply-To: <1456425100-28136-2-git-send-email-slemieux.tyco@gmail.com>
References: <1456425100-28136-1-git-send-email-slemieux.tyco@gmail.com>
 <1456425100-28136-2-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <56D05DF1.8000504@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25/2016 10:31 AM, Sylvain Lemieux wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
>
> There is no need add the driver name in the text to display
> on the console during the power-on:
> pnx4008-watchdog 4003c000.watchdog: PNX4008 Watchdog Timer: heartbeat 19 sec
>
> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes from v3 to v4:
> - none.
>
> Changes from v2 to v3:
> - none.
>
> Changes from v1 to v2:
> - new patch in v2.
>
>   drivers/watchdog/pnx4008_wdt.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
> index 313cd1c..88264a2 100644
> --- a/drivers/watchdog/pnx4008_wdt.c
> +++ b/drivers/watchdog/pnx4008_wdt.c
> @@ -178,8 +178,7 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
>   		goto disable_clk;
>   	}
>
> -	dev_info(&pdev->dev, "PNX4008 Watchdog Timer: heartbeat %d sec\n",
> -		 pnx4008_wdd.timeout);
> +	dev_info(&pdev->dev, "heartbeat %d sec\n", pnx4008_wdd.timeout);
>
>   	return 0;
>
>
