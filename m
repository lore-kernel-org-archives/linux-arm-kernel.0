From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Jul 2011 00:35:58 -0700
Subject: [PATCH 2/3] Add tps65921 chip
In-Reply-To: <1308066307-415-3-git-send-email-green@linuxhacker.ru>
References: <1308066307-415-1-git-send-email-green@linuxhacker.ru>
	<1308066307-415-3-git-send-email-green@linuxhacker.ru>
Message-ID: <20110701073557.GF23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samuel,

* green at linuxhacker.ru <green@linuxhacker.ru> [110614 08:42]:
> From: Oleg Drokin <green@linuxhacker.ru>
> 
> Very similar to TPS65920
> List of differences: http://www.ti.com/litv/pdf/swcu066b
> 
> CC: sameo at linux.intel.com
> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>

Looks like this one can be merged independently of the rest of the
Nook patches via your mfd tree. Care to queue this?

Regards,

Tony


> ---
>  drivers/mfd/twl-core.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index b8f2a4e..756f3eb 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -1284,6 +1284,8 @@ static const struct i2c_device_id twl_ids[] = {
>  	{ "tps65950", 0 },		/* catalog version of twl5030 */
>  	{ "tps65930", TPS_SUBSET },	/* fewer LDOs and DACs; no charger */
>  	{ "tps65920", TPS_SUBSET },	/* fewer LDOs; no codec or charger */
> +	{ "tps65921", TPS_SUBSET },	/* fewer LDOs; no codec, no LED
> +					   and vibrator. Charger in USB module*/
>  	{ "twl6030", TWL6030_CLASS },	/* "Phoenix power chip" */
>  	{ "twl6025", TWL6030_CLASS | TWL6025_SUBCLASS }, /* "Phoenix lite" */
>  	{ /* end of list */ },
> -- 
> 1.7.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
