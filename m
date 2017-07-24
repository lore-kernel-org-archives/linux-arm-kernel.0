From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 24 Jul 2017 16:14:17 +0800
Subject: [PATCH 1/4] arm: multi_v7: Add AXP20X_POWER
In-Reply-To: <20170721162005.18892-1-maxime.ripard@free-electrons.com>
References: <20170721162005.18892-1-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65TMPh8iVAzM=8bakqh15r01AumAUJdpqm8hWh+kxWKjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 22, 2017 at 12:20 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The multi_v7 defconfig is missing the AXP209 USB power supply driver,
> resulting in non-working USB controllers because the USB PHY will always
> return EPROBE_DEFER.
>
> Make sure it's selected.

This seems weird. You only change it from a module to built-in.
AFAIK, the module does have proper module aliases, and the mfd
core does give out proper uevents for modaliases.

Is the module not getting loaded? Or is it loaded too late?

ChenYu

>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 4d19c1b4b8e7..6bab339a8dd8 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -432,6 +432,7 @@ CONFIG_GPIO_TPS6586X=y
>  CONFIG_GPIO_TPS65910=y
>  CONFIG_BATTERY_ACT8945A=y
>  CONFIG_BATTERY_SBS=y
> +CONFIG_AXP20X_POWER=y
>  CONFIG_BATTERY_MAX17040=m
>  CONFIG_BATTERY_MAX17042=m
>  CONFIG_CHARGER_MAX14577=m
> @@ -439,7 +440,6 @@ CONFIG_CHARGER_MAX77693=m
>  CONFIG_CHARGER_MAX8997=m
>  CONFIG_CHARGER_MAX8998=m
>  CONFIG_CHARGER_TPS65090=y
> -CONFIG_AXP20X_POWER=m
>  CONFIG_POWER_RESET_AS3722=y
>  CONFIG_POWER_RESET_GPIO=y
>  CONFIG_POWER_RESET_GPIO_RESTART=y
> --
> 2.13.3
>
