From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 11 Mar 2011 22:36:14 +0100
Subject: [PATCH v2] z2-battery: Fix count of properties
In-Reply-To: <1299848972-25596-1-git-send-email-anarsoul@gmail.com>
References: <4D7A1181.2000802@ru.mvista.com>
	<1299848972-25596-1-git-send-email-anarsoul@gmail.com>
Message-ID: <201103112236.14261.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 March 2011 14:09:32 Vasily Khoruzhick wrote:
> PROP_STATUS property was not counted, as result
> VOLTAGE_MIN property is missing in sysfs. Fix it.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

You can have my:

Acked-by: Marek Vasut <marek.vasut@gmail.com>

on this one.
> ---
> v2: Align comment properly
> 
>  drivers/power/z2_battery.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/power/z2_battery.c b/drivers/power/z2_battery.c
> index 81304c0..2a9ab89 100644
> --- a/drivers/power/z2_battery.c
> +++ b/drivers/power/z2_battery.c
> @@ -134,6 +134,8 @@ static int z2_batt_ps_init(struct z2_charger *charger,
> int props) enum power_supply_property *prop;
>  	struct z2_battery_info *info = charger->info;
> 
> +	if (info->charge_gpio >= 0)
> +		props++;	/* POWER_SUPPLY_PROP_STATUS */
>  	if (info->batt_tech >= 0)
>  		props++;	/* POWER_SUPPLY_PROP_TECHNOLOGY */
>  	if (info->batt_I2C_reg >= 0)
