From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 17 Nov 2015 11:09:12 +0100
Subject: [PATCH] regulator: mt6311: MT6311_REGULATOR needs to select
 REGMAP_I2C
In-Reply-To: <1447749409-19900-1-git-send-email-henryc.chen@mediatek.com>
References: <1447749409-19900-1-git-send-email-henryc.chen@mediatek.com>
Message-ID: <564AFCC8.6000604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/11/15 09:36, Henry Chen wrote:
> This patch fix the below build error:
> drivers/regulator/mt6311-regulator.c:111: undefined reference to `__devm_regmap_init_i2c'
>
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>   drivers/regulator/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 8df0b0e..0067620 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -446,6 +446,7 @@ config REGULATOR_MC13892
>   config REGULATOR_MT6311
>   	tristate "MediaTek MT6311 PMIC"
>   	depends on I2C
> +	select REGMAP_I2C
>   	help
>   	  Say y here to select this option to enable the power regulator of
>   	  MediaTek MT6311 PMIC.
>

This should also be added to v4.3
I propose that you resend it adding the tag:
Cc: stable at vger.kernel.org

as explained in Documentation/stable_kernel_rules.txt

Regards,
Matthias
