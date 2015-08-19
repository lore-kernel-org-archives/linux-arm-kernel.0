From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 19 Aug 2015 12:09:38 +0200
Subject: [PATCH V3] Watchdog: Fix parent of watchdog_devices
In-Reply-To: <db7db9102158b87a4a7169e84e2272b3ba03f9f7.1439954581.git.panand@redhat.com>
References: <db7db9102158b87a4a7169e84e2272b3ba03f9f7.1439954581.git.panand@redhat.com>
Message-ID: <20150819100937.GD26627@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 08:58:24AM +0530, Pratyush Anand wrote:
[...]
> diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
> index 30451ea46902..7f97cdd53f29 100644
> --- a/drivers/watchdog/tegra_wdt.c
> +++ b/drivers/watchdog/tegra_wdt.c
> @@ -218,6 +218,7 @@ static int tegra_wdt_probe(struct platform_device *pdev)
>  	wdd->ops = &tegra_wdt_ops;
>  	wdd->min_timeout = MIN_WDT_TIMEOUT;
>  	wdd->max_timeout = MAX_WDT_TIMEOUT;
> +	wdd->parent = &pdev->dev;
>  
>  	watchdog_set_drvdata(wdd, wdt);
>  

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150819/f971965d/attachment.sig>
