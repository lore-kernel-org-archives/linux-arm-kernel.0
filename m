From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sun, 19 Jul 2015 23:24:07 -0700
Subject: [PATCH v2 1/2] input: touchscreen: pixcir_i2c_ts: Add support
 for optional wakeup interrupt
In-Reply-To: <20150720060929.GW17550@atomide.com>
References: <1437367814-27785-1-git-send-email-vigneshr@ti.com>
 <1437367814-27785-2-git-send-email-vigneshr@ti.com>
 <20150720060929.GW17550@atomide.com>
Message-ID: <20150720062407.GA13092@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 19, 2015 at 11:09:30PM -0700, Tony Lindgren wrote:
> * Vignesh R <vigneshr@ti.com> [150719 21:53]:
> > @@ -445,6 +443,8 @@ static struct pixcir_ts_platform_data *pixcir_parse_dt(struct device *dev)
> >  	dev_dbg(dev, "%s: x %d, y %d, gpio %d\n", __func__,
> >  		pdata->x_max + 1, pdata->y_max + 1, pdata->gpio_attb);
> >  
> > +	pdata->wakeirq = of_irq_get_byname(dev->of_node, "wakeupirq");
> > +
> >  	return pdata;
> 
> What about handling -EPROVE_DEFER here? At least pinctrl-single can be
> be a loadable module for the dedicated wakeirqs.

Right. I think we should only allow -ENODATA to continue and return
error in all other cases.

Also, I think "irq" suffix on name is redundant.

Thanks.

-- 
Dmitry
