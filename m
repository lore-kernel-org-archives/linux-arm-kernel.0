From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 9 Jan 2018 17:21:54 +0100
Subject: [PATCH] bq24190: Simplify code in property_is_writeable
In-Reply-To: <20171227092041.GA14507@amd>
References: <20171227092041.GA14507@amd>
Message-ID: <20180109162154.ewgp5bbuxlaesgwz@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 27, 2017 at 10:20:42AM +0100, Pavel Machek wrote:
> Simplify function that should be trivial.
> 
> Signed-off-by: Pavel machek <pavel@ucw.cz>

Thanks, queued.

-- Sebastian

> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index 35ff406..4ea8f0a 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1193,8 +1193,6 @@ static int bq24190_charger_set_property(struct power_supply *psy,
>  static int bq24190_charger_property_is_writeable(struct power_supply *psy,
>  		enum power_supply_property psp)
>  {
> -	int ret;
> -
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_ONLINE:
>  	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> @@ -1202,13 +1200,10 @@ static int bq24190_charger_property_is_writeable(struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> -		ret = 1;
> -		break;
> +		return 1;
>  	default:
> -		ret = 0;
> +		return 0;
>  	}
> -
> -	return ret;
>  }
>  
>  static void bq24190_input_current_limit_work(struct work_struct *work)
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180109/f02378f1/attachment.sig>
