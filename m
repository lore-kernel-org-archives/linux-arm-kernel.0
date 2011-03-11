From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 11 Mar 2011 15:11:45 +0300
Subject: [PATCH] z2-battery: Fix count of properties
In-Reply-To: <1299837813-14952-1-git-send-email-anarsoul@gmail.com>
References: <1299837813-14952-1-git-send-email-anarsoul@gmail.com>
Message-ID: <4D7A1181.2000802@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11-03-2011 13:03, Vasily Khoruzhick wrote:

> PROP_STATUS property was not counted, as result
> VOLTAGE_MIN property is missing in sysfs. Fix it.

> Signed-off-by: Vasily Khoruzhick<anarsoul@gmail.com>
> ---
>   drivers/power/z2_battery.c |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)

> diff --git a/drivers/power/z2_battery.c b/drivers/power/z2_battery.c
> index e5ed52d..551d7bf 100644
> --- a/drivers/power/z2_battery.c
> +++ b/drivers/power/z2_battery.c
> @@ -134,6 +134,8 @@ static int z2_batt_ps_init(struct z2_charger *charger, int props)
>   	enum power_supply_property *prop;
>   	struct z2_battery_info *info = charger->info;
>
> +	if (info->charge_gpio>= 0)
> +		props++; /* POWER_SUPPLY_PROP_STATUS */

    Why not align this comment with the below one?

>   	if (info->batt_tech>= 0)
>   		props++;	/* POWER_SUPPLY_PROP_TECHNOLOGY */
>   	if (info->batt_I2C_reg>= 0)

WBR, Sergei
