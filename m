From: kuninori.morimoto.gx@gmail.com (Kuninori Morimoto)
Date: Tue, 07 Jan 2014 17:08:16 -0800 (PST)
Subject: [PATCH 3/4] thermal: rcar: Add missing clock handling
In-Reply-To: <1389121036-3555-4-git-send-email-geert@linux-m68k.org>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
 <1389121036-3555-4-git-send-email-geert@linux-m68k.org>
Message-ID: <87ha9fxoua.wl%kuninori.morimoto.gx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Geert

> +	common->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(common->clk)) {
> +		dev_err(&pdev->dev, "cannot get clock\n");
> +		return PTR_ERR(common->clk);
> +	}
> +
> +	ret = clk_prepare(common->clk);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "unable to prepare clock\n");
> +		return ret;
> +	}
> +
> +	clk_enable(common->clk);
> +
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);

You can use "dev" instead of "&pdev->dev" :)

And this patch seems strange for me.
pm_runtime_xxx() is doing same things.
If it didn't work, wrong place is not driver, clock side ?
