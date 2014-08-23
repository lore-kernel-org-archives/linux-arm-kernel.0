From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Sat, 23 Aug 2014 18:23:15 +0200
Subject: [PATCH] phy: exynos5-usbdrd: Add MODULE_DEVICE_TABLE entry
In-Reply-To: <1408715892-27728-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1408715892-27728-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <53F8BFF3.8020001@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 22.08.2014 15:58, schrieb Sjoerd Simons:
> Add a MODULE_DEVICE_TABLE call for OF match tables. This allows the
> module to be autoloaded based on devicetree information.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> ---
>  drivers/phy/phy-exynos5-usbdrd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/phy-exynos5-usbdrd.c b/drivers/phy/phy-exynos5-usbdrd.c
> index b05302b..e9a0f54 100644
> --- a/drivers/phy/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/phy-exynos5-usbdrd.c
> @@ -542,6 +542,7 @@ static const struct of_device_id exynos5_usbdrd_phy_of_match[] = {
>  	},
>  	{ },
>  };
> +MODULE_DEVICE_TABLE (of, exynos5_usbdrd_phy_of_match);

Nit: Probably there should be no space before '('?

>  
>  static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
>  {

Otherwise certainly sensible. I ran into another such case myself.

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
