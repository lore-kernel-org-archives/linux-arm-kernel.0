From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 20 Oct 2016 09:23:18 -0700
Subject: [PATCH] pwm: meson: Remove unneeded platform MODULE_ALIAS
In-Reply-To: <1476906599-14350-1-git-send-email-javier@osg.samsung.com>
 (Javier Martinez Canillas's message of "Wed, 19 Oct 2016 16:49:59
 -0300")
References: <1476906599-14350-1-git-send-email-javier@osg.samsung.com>
Message-ID: <7h8ttj7zwp.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas <javier@osg.samsung.com> writes:

> The Amlogic Meson is a DT-only platform, which means the devices are
> registered via OF and not using the legacy platform devices support.
>
> So there's no need to have a MODULE_ALIAS("platform:meson-pwm") since
> the reported uevent MODALIAS to user-space will always be the OF one.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>
>  drivers/pwm/pwm-meson.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 381871b2bb46..5678092cad4b 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -523,7 +523,6 @@ static struct platform_driver meson_pwm_driver = {
>  };
>  module_platform_driver(meson_pwm_driver);
>  
> -MODULE_ALIAS("platform:meson-pwm");
>  MODULE_DESCRIPTION("Amlogic Meson PWM Generator driver");
>  MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>  MODULE_LICENSE("Dual BSD/GPL");
