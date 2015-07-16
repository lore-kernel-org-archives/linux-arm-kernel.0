From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 16 Jul 2015 09:45:20 +0900
Subject: [PATCH 1/3] ARM: multi_v7_defconfig: Enable max77802 regulator
In-Reply-To: <1436977965-7078-2-git-send-email-javier@osg.samsung.com>
References: <1436977965-7078-1-git-send-email-javier@osg.samsung.com>
 <1436977965-7078-2-git-send-email-javier@osg.samsung.com>
Message-ID: <55A6FEA0.8090202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.07.2015 01:32, Javier Martinez Canillas wrote:
> The Maxim max77802 Power Management IC has besides other devices, a set of
> regulators. Commit f3caa529c6f5 ("ARM: multi_v7_defconfig: Enable max77802
> regulator, rtc and clock drivers") was supposed to enable the config option
> for the regulator driver as a module but the final version that landed did
> not include this. So this patch enables the needed Kconfig option.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Please describe why do you want to enable it (IOW who will benefit from
enabling it?). This symbol was removed by Kukjin from your commit:
	[kgene at kernel.org: removing useless REGULATOR_MAX77802 config]
so justification would be welcomed.

Beside the commit description I agree with the patch.

Best regards,
Krzysztof

> ---
> 
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 4b93761d58d2..b07493997993 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -402,6 +402,7 @@ CONFIG_REGULATOR_MAX14577=m
>  CONFIG_REGULATOR_MAX8907=y
>  CONFIG_REGULATOR_MAX8973=y
>  CONFIG_REGULATOR_MAX77686=y
> +CONFIG_REGULATOR_MAX77802=m
>  CONFIG_REGULATOR_MAX77693=m
>  CONFIG_REGULATOR_PALMAS=y
>  CONFIG_REGULATOR_S2MPS11=y
> 
