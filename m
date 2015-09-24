From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 25 Sep 2015 00:10:16 +0200
Subject: [PATCH v2 2/5] ARM: multi_v7_defconfig: Enable common regulators
 for rockchip boards
In-Reply-To: <1443094759-28531-3-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1443094759-28531-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1443094759-28531-3-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <5471789.IH6TzhIBOd@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 24. September 2015, 13:39:16 schrieb Sjoerd Simons:
> Rockchip boards seem to have two common regulator setups. Various board
> used the Active Semi act8846 often in combination with Silergy syr82x

For people just skimming over these patches, the syr82x are siblings to the 
fan53555 - same register interface and all, thus that option gets enabled.


> regulators (e.g. Radxa Rock Pro/Rock 2, Firefly, and Netxeon R89 etc),
> while others use regulator part of the Rockchip RK808 chip (e.g. the
> various Veyron based chromebooks, Chipspark Popmetal etc)
> 
> Enable all these regulators.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> 
> ---
> 
> Changes in v2:
> - Enable all common rockchip regulators, not just ACT8846
> 
>  arch/arm/configs/multi_v7_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig
> b/arch/arm/configs/multi_v7_defconfig index 170f18e..3938f54 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -394,6 +394,7 @@ CONFIG_MFD_MAX14577=y
>  CONFIG_MFD_MAX77686=y
>  CONFIG_MFD_MAX77693=y
>  CONFIG_MFD_MAX8907=y
> +CONFIG_MFD_RK808=y
>  CONFIG_MFD_SEC_CORE=y
>  CONFIG_MFD_STMPE=y
>  CONFIG_MFD_PALMAS=y
> @@ -401,11 +402,14 @@ CONFIG_MFD_TPS65090=y
>  CONFIG_MFD_TPS6586X=y
>  CONFIG_MFD_TPS65910=y
>  CONFIG_REGULATOR_AB8500=y
> +CONFIG_REGULATOR_ACT8865=y
>  CONFIG_REGULATOR_AS3711=y
>  CONFIG_REGULATOR_AS3722=y
>  CONFIG_REGULATOR_AXP20X=y
>  CONFIG_REGULATOR_BCM590XX=y
>  CONFIG_REGULATOR_DA9210=y
> +CONFIG_REGULATOR_FAN53555=y
> +CONFIG_REGULATOR_RK808=y
>  CONFIG_REGULATOR_GPIO=y
>  CONFIG_MFD_SYSCON=y
>  CONFIG_POWER_RESET_SYSCON=y
