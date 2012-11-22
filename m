From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Thu, 22 Nov 2012 12:08:41 -0800
Subject: [PATCH 1/4] mfd: ab8500: add devicetree support for fuelgauge
In-Reply-To: <1353609827-8218-2-git-send-email-rajanikanth.hv@linaro.org>
References: <1353609827-8218-1-git-send-email-rajanikanth.hv@linaro.org>
 <1353609827-8218-2-git-send-email-rajanikanth.hv@linaro.org>
Message-ID: <20121122200841.GB12397@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 12:13:44AM +0530, Rajanikanth H.V wrote:
[...]
> +/*
> + * Note that the batres_vs_temp table must be strictly sorted by falling
> + * temperature values to work.
> + */
> +struct batres_vs_temp temp_to_batres_tbl_thermistor[] = {

It must be static.

[..]
> +struct batres_vs_temp temp_to_batres_tbl_ext_thermistor[] = {

Ditto.

> +	{ 60, 300},
> +	{ 30, 300},
> +	{ 20, 300},
> +	{ 10, 300},
> +	{ 00, 300},
> +	{-10, 300},
> +	{-20, 300},
> +};
> +
> +/* battery resistance table for LI ION 9100 battery */
> +struct batres_vs_temp temp_to_batres_tbl_9100[] = {

Ditto.

There are other issues, which I fixed in my tree for the previous series.
So the previous series already merged, please post patches on top of it.

Thanks,
Anton.
