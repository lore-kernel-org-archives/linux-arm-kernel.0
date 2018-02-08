From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 8 Feb 2018 15:00:47 +0530
Subject: [PATCH 2/7] soc: davinci: new genpd driver
In-Reply-To: <20180207134553.13510-3-brgl@bgdev.pl>
References: <20180207134553.13510-1-brgl@bgdev.pl>
 <20180207134553.13510-3-brgl@bgdev.pl>
Message-ID: <65f2690c-c605-3c66-9d8a-9a882aaf446d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 February 2018 07:15 PM, Bartosz Golaszewski wrote:
> +	/*
> +	 * DaVinci always uses a single clock for power-management. We assume
> +	 * it's the first one in the clocks property.
> +	 */
> +	clk = of_clk_get(dev->of_node, 0);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);

We already get this today with drivers/base/power/clock_ops.c once
.con_ids list is dropped from pm_clk_notifier_block (which I think it
should).

If there is no reason to introduce thus functionality at this stage,
perhaps we should wait till such a time when its clearly needed?

Thanks,
Sekhar
