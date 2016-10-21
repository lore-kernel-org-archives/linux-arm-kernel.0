From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 21 Oct 2016 16:11:28 +0200
Subject: [PATCH] hwrng: meson: Remove unneeded platform MODULE_ALIAS
In-Reply-To: <1476906618-14455-1-git-send-email-javier@osg.samsung.com>
References: <1476906618-14455-1-git-send-email-javier@osg.samsung.com>
Message-ID: <29086305-c8a7-ba17-5e99-3a779b9dd410@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2016 09:50 PM, Javier Martinez Canillas wrote:
> The Amlogic Meson is a DT-only platform, which means the devices are
> registered via OF and not using the legacy platform devices support.
> 
> So there's no need to have a MODULE_ALIAS("platform:meson-rng") since
> the reported uevent MODALIAS to user-space will always be the OF one.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  drivers/char/hw_random/meson-rng.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/char/hw_random/meson-rng.c b/drivers/char/hw_random/meson-rng.c
> index 51864a509be7..119d698439ae 100644
> --- a/drivers/char/hw_random/meson-rng.c
> +++ b/drivers/char/hw_random/meson-rng.c
> @@ -122,7 +122,6 @@ static struct platform_driver meson_rng_driver = {
>  
>  module_platform_driver(meson_rng_driver);
>  
> -MODULE_ALIAS("platform:meson-rng");
>  MODULE_DESCRIPTION("Meson H/W Random Number Generator driver");
>  MODULE_AUTHOR("Lawrence Mok <lawrence.mok@amlogic.com>");
>  MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
