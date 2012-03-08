From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 8 Mar 2012 17:53:38 +0100
Subject: [PATCH 1/5 v3] i2c/gpio: add DT support
In-Reply-To: <4F588F50.7060906@samsung.com>
References: <1331196635-27203-1-git-send-email-plagnioj@jcrosoft.com>
 <4F588F50.7060906@samsung.com>
Message-ID: <20120308165338.GI27213@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:52 Thu 08 Mar     , Karol Lewandowski wrote:
> On 08.03.2012 09:50, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > +static int __devinit of_i2c_gpio_probe(struct device_node *np,
> > +			     struct i2c_gpio_platform_data *pdata)
> > +{
> > +	u32 reg;
> > +
> > +	if (of_gpio_count(np) < 2)
> > +		return -ENODEV;
> > +
> > +	pdata->sda_pin = of_get_gpio(np, 0);
> > +	pdata->scl_pin = of_get_gpio(np, 1);
> > +
> > +	if (pdata->sda_pin < 0 || pdata->scl_pin < 0) {
> > +		pr_err("%s: invalid GPIO pins, sda=%d/scl=%d\n",
> > +		       np->full_name, pdata->sda_pin, pdata->scl_pin);
> > +		return -ENODEV;
> > +	}
> > +
> > +	of_property_read_u32(np, "i2c-gpio,delay-us", &pdata->udelay);
> > +
> 
> 
> 
> > +	if (of_property_read_u32(np, "i2c-gpio,timeout-ms", &reg))
> > +		pdata->timeout = msecs_to_jiffies(reg);
> 
> 
> I've already said (two times!) that of_property_read_u32() returns
> nonzero (negative) error code on _error_.
> 
> Don't you see obvious error in above code fragment?
> 
> You assign to pdata->timeout on _error_.
yeah forget this one

Jean can I have you are ack so I send the v4 and the pull today

Best Regards,
J.
