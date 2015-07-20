From: tony@atomide.com (Tony Lindgren)
Date: Sun, 19 Jul 2015 23:09:30 -0700
Subject: [PATCH v2 1/2] input: touchscreen: pixcir_i2c_ts: Add support
 for optional wakeup interrupt
In-Reply-To: <1437367814-27785-2-git-send-email-vigneshr@ti.com>
References: <1437367814-27785-1-git-send-email-vigneshr@ti.com>
 <1437367814-27785-2-git-send-email-vigneshr@ti.com>
Message-ID: <20150720060929.GW17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vignesh R <vigneshr@ti.com> [150719 21:53]:
> @@ -445,6 +443,8 @@ static struct pixcir_ts_platform_data *pixcir_parse_dt(struct device *dev)
>  	dev_dbg(dev, "%s: x %d, y %d, gpio %d\n", __func__,
>  		pdata->x_max + 1, pdata->y_max + 1, pdata->gpio_attb);
>  
> +	pdata->wakeirq = of_irq_get_byname(dev->of_node, "wakeupirq");
> +
>  	return pdata;

What about handling -EPROVE_DEFER here? At least pinctrl-single can be
be a loadable module for the dedicated wakeirqs.

Regarads,

Tony
