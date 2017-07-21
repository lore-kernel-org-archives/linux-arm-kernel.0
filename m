From: rafal@milecki.pl (=?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?=)
Date: Fri, 21 Jul 2017 22:04:42 +0200
Subject: [PATCH v2 2/4] thermal: add brcmstb AVS TMON driver
In-Reply-To: <20170721192735.6546-3-code@mmayer.net>
References: <20170721192735.6546-1-code@mmayer.net>
 <20170721192735.6546-3-code@mmayer.net>
Message-ID: <1b44dcc1381fda8ab3f29c97718e9999@milecki.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm far from being thermal expert, to me it looks OK, only 1 trivial 
issue
noticed (see below).


On 2017-07-21 21:27, Markus Mayer wrote:
> +static void avs_tmon_trip_enable(struct brcmstb_thermal_priv *priv,
> +				 enum avs_tmon_trip_type type, int en)
> +{
> +	struct avs_tmon_trip *trip = &avs_tmon_trips[type];
> +	u32 val = __raw_readl(priv->tmon_base + trip->enable_offs);
> +
> +	pr_debug("%sable trip, type %d\n", en ? "en" : "dis", type);

This probably could be dev_dbg?


> +static void avs_tmon_set_trip_temp(struct brcmstb_thermal_priv *priv,
> +				   enum avs_tmon_trip_type type,
> +				   int temp)
> +{
> +	struct avs_tmon_trip *trip = &avs_tmon_trips[type];
> +	u32 val, orig;
> +
> +	pr_debug("set temp %d to %d\n", type, temp);

Same here.


> +static int brcmstb_set_trips(void *data, int low, int high)
> +{
> +	struct brcmstb_thermal_priv *priv = data;
> +
> +	pr_debug("set trips %d <--> %d\n", low, high);

And the last time here.
