From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 31 Jan 2013 21:02:50 +0100
Subject: [PATCH] power/reset: restart: remove __dev{init,exit}
In-Reply-To: <1359658469-14856-1-git-send-email-jason@lakedaemon.net>
References: <20130106220426.GE26928@lizard.sbx05280.losalca.wayport.net>
 <1359658469-14856-1-git-send-email-jason@lakedaemon.net>
Message-ID: <20130131200250.GR29973@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 06:54:29PM +0000, Jason Cooper wrote:
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>

Hi Jason

I Acked-by: a very similar patch to this yesterday....

https://lkml.org/lkml/2013/1/30/233

	Andrew

> ---
>  drivers/power/reset/restart-poweroff.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/reset/restart-poweroff.c b/drivers/power/reset/restart-poweroff.c
> index b11b9e8..059cd15 100644
> --- a/drivers/power/reset/restart-poweroff.c
> +++ b/drivers/power/reset/restart-poweroff.c
> @@ -22,7 +22,7 @@ static void restart_poweroff_do_poweroff(void)
>  	arm_pm_restart('h', NULL);
>  }
>  
> -static int __devinit restart_poweroff_probe(struct platform_device *pdev)
> +static int restart_poweroff_probe(struct platform_device *pdev)
>  {
>  	/* If a pm_power_off function has already been added, leave it alone */
>  	if (pm_power_off != NULL) {
> @@ -35,7 +35,7 @@ static int __devinit restart_poweroff_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int __devexit restart_poweroff_remove(struct platform_device *pdev)
> +static int restart_poweroff_remove(struct platform_device *pdev)
>  {
>  	if (pm_power_off == &restart_poweroff_do_poweroff)
>  		pm_power_off = NULL;
> @@ -50,7 +50,7 @@ static const struct of_device_id of_restart_poweroff_match[] = {
>  
>  static struct platform_driver restart_poweroff_driver = {
>  	.probe = restart_poweroff_probe,
> -	.remove = __devexit_p(restart_poweroff_remove),
> +	.remove = restart_poweroff_remove,
>  	.driver = {
>  		.name = "poweroff-restart",
>  		.owner = THIS_MODULE,
> -- 
> 1.8.1.1
> 
