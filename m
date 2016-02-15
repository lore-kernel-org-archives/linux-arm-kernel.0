From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 15 Feb 2016 09:58:17 +0800
Subject: [PATCH] rtc: mt6397: Add platform device ID table
In-Reply-To: <1455016095-13724-1-git-send-email-javier@osg.samsung.com>
References: <1455016095-13724-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1455501497.7263.4.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-02-09 at 08:08 -0300, Javier Martinez Canillas wrote:
> The platform bus_type .match callback attempts to match the platform device
> name with an entry on the .id_table if provided and fallbacks to match with
> the driver's name if a table is not provided.
> 
> Using a platform device ID to match is more explicit, allows the driver to
> support more than one device and also the MODULE_DEVICE_TABLE macro can be
> used to export the module aliases information instead of the MODULE_ALIAS.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  drivers/rtc/rtc-mt6397.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> index 06a5c52b292f..46533f11f7fc 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
> @@ -404,6 +404,12 @@ static const struct of_device_id mt6397_rtc_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mt6397_rtc_of_match);
>  
> +static const struct platform_device_id mt6397_rtc_id[] = {
> +	{"mt6397-rtc", 0},
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(platform, mt6397_rtc_id);
> +
>  static struct platform_driver mtk_rtc_driver = {
>  	.driver = {
>  		.name = "mt6397-rtc",
> @@ -412,6 +418,7 @@ static struct platform_driver mtk_rtc_driver = {
>  	},
>  	.probe	= mtk_rtc_probe,
>  	.remove = mtk_rtc_remove,
> +	.id_table = mt6397_rtc_id,
>  };
>  
>  module_platform_driver(mtk_rtc_driver);
> @@ -419,4 +426,3 @@ module_platform_driver(mtk_rtc_driver);
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Tianping Fang <tianping.fang@mediatek.com>");
>  MODULE_DESCRIPTION("RTC Driver for MediaTek MT6397 PMIC");
> -MODULE_ALIAS("platform:mt6397-rtc");

This patch looks good to me, but I am wondering, since we tend to use
device tree method to match driver, do we still need support platform
device ID ?

Eddie
