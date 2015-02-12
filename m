From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 12 Feb 2015 16:45:18 +0300
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MyAxLzRdIHR0eTogc2VyaWFsX21jdHJsX2dwaW86IEFk?=
 =?UTF-8?B?ZCBpcnFzIGhlbHBlcnMgZm9yIGlucHV0IGxpbmVz?=
In-Reply-To: <20150212132939.GE10842@pengutronix.de>
References: <1423241735-30387-1-git-send-email-j.uzycki@elproma.com.pl>
 <20150212132939.GE10842@pengutronix.de>
Message-ID: <1423748718.221741158@f354.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????, 12 ??????? 2015, 14:29 +01:00 ?? Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
...
> > +int mctrl_gpio_request_irqs(struct mctrl_gpios *gpios)
> 
> > +{
> 
> > +	struct uart_port *port = gpios->port;
> 
> > +	int *irq = gpios->irq;
> 
> > +	enum mctrl_gpio_idx i;
> 
> > +	int err = 0;
> 
> > +
> 
> > +	/* When gpios is NULL just gpio irqs are also never set
> 
> > +	 * so return without any error */
> 
> > +	if (IS_ERR_OR_NULL(gpios))
> 
> > +		return err;
> 
> I'd expect drivers using mctrl-gpio to error out if mctrl_gpio_init_dt
> 
> fails. Also mctrl_gpio_init_dt never returns NULL, so IMHO this check
> 
> can be dropped. (There are more places in mctrl-gpio that should be
> 
> fixed accordingly.

At least this check should be moved to start of this function due
future usage of gpios->port and gpios->irq.

---
