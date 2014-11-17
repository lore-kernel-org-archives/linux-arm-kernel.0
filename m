From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 17 Nov 2014 11:53:36 +0300
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gZ3BpbzogbXhzOiBpbXBsZW1lbnQgZ2V0X2RpcmVjdGlv?=
 =?UTF-8?B?biBjYWxsYmFjaw==?=
In-Reply-To: <20141117084410.GD27002@pengutronix.de>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <1416213534.761947189@f70.i.mail.ru>
 <20141117084410.GD27002@pengutronix.de>
Message-ID: <1416214416.941104920@f40.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mon, 17 Nov 2014 09:44:10 +0100 ?? Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Alexander,
> 
> On Mon, Nov 17, 2014 at 11:38:54AM +0300, Alexander Shiyan wrote:
> > Hello.
> > 
> > ...
> > > > struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int
> > > > idx, int *irqs)
> > > What is idx about? I see it already in the mctrl_gpio API, but there is
> > > no documentation about how it's used. Is it always 0?
> > 
> > This could be used for drivers with several UARTs, which registered at once.
> Then what about:
> 
> 	/**
> 	 * Document what idx is about here.
> 	 */
> 	struct mctrl_gpios *mctrl_gpio_init_index(struct uart_port *port, unsigned int idx);
> 	static inline struct mctrl_gpios *mctrl_gpio_init(struct uart_port *port)
> 	{
> 		return mctrl_gpio_init_index(port, 0);
> 	}
> 
> ? That matches how gpio and of functions use the indexed variants.

This is planned by me for "sccnxp" driver at least.

---
