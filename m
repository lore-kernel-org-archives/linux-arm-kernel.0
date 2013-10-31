From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 30 Oct 2013 17:43:38 -0700
Subject: [PATCH] watchdog: imx2_wdt: add module device table
In-Reply-To: <E1VbfdE-0003gA-4q@rmk-PC.arm.linux.org.uk>
References: <E1VbfdE-0003gA-4q@rmk-PC.arm.linux.org.uk>
Message-ID: <20131031004338.GA20335@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 11:57:00PM +0000, Russell King wrote:
> Add the module device table declaration so the module can be loaded
> automatically at boot time.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Hi Russell,

Wim should have this patch in his queue already, as 'watchdog: imx2_wdt:
expose module alias for loading from device-tree', submitted by Niels
de Vos back in July.

Thanks,
Guenter

> ---
>  drivers/watchdog/imx2_wdt.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 693ac3f4de5a..ae1ac198d968 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -340,3 +340,4 @@ MODULE_DESCRIPTION("Watchdog driver for IMX2 and later");
>  MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
>  MODULE_ALIAS("platform:" DRIVER_NAME);
> +MODULE_DEVICE_TABLE(of, imx2_wdt_dt_ids);
> -- 
> 1.7.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
