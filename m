From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 13 Sep 2017 14:13:45 +0200
Subject: [PATCH v4 4/4] [media] exynos-gsc: Add hardware rotation limits
In-Reply-To: <1505302915-15699-5-git-send-email-hoegeun.kwon@samsung.com>
References: <1505302915-15699-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170913114215epcas2p346dd3987cf25481bc780e0eef8b91ed8@epcas2p3.samsung.com>
 <1505302915-15699-5-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <509750b5-22d0-77ee-8295-0e52679e0d1e@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2017 01:41 PM, Hoegeun Kwon wrote:
> @@ -1004,11 +1088,33 @@ static irqreturn_t gsc_irq_handler(int irq, void *priv)
>   	.num_clocks = 1,
>   };
>   
> +static struct gsc_driverdata gsc_v_5250_drvdata = {
> +	.variant = {
> +		[0] = &gsc_v_5250_variant,
> +		[1] = &gsc_v_5250_variant,
> +		[2] = &gsc_v_5250_variant,
> +		[3] = &gsc_v_5250_variant,
> +	},
> +	.num_entities = 4,
> +	.clk_names = { "gscl" },
> +	.num_clocks = 1,
> +};
> +
> +static struct gsc_driverdata gsc_v_5420_drvdata = {
> +	.variant = {
> +		[0] = &gsc_v_5420_variant,
> +		[1] = &gsc_v_5420_variant,
> +	},
> +	.num_entities = 4,

Shouldn't num_enities be 2 here? You don't need to resend, I can
amend that when applying.

> +	.clk_names = { "gscl" },
> +	.num_clocks = 1,
> +};
> +

--
Regards,
Sylwester
