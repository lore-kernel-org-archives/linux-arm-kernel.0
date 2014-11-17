From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 17 Nov 2014 13:05:53 +0300
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gZ3BpbzogbXhzOiBpbXBsZW1lbnQgZ2V0X2RpcmVjdGlv?=
 =?UTF-8?B?biBjYWxsYmFjaw==?=
In-Reply-To: <20141117095909.GH27002@pengutronix.de>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <CACQ1gAha1MuroyB35zN_BuwRNGS_J3Xh1htiHJda_2_19qh31g@mail.gmail.com>
 <20141117095909.GH27002@pengutronix.de>
Message-ID: <1416218753.520525851@f237.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mon, 17 Nov 2014 10:59:09 +0100 ?? Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Richard,
> 
> > >>>> So finally the prototypes would be:
> > >>>> int mctrl_gpio_request_irqs(struct mctrl_gpios*, struct
> > >>>> uart_port*, irqhandler_t);
> > >>>> void mctrl_gpio_free_irqs(struct mctrl_gpios*);
> > >>
> > >> I think:
> > >>
> > >>         struct mctrl_gpios {
> > >>                 struct uart_port *port;
> > >>                 struct {
> > >>                         gpio_desc *gpio;
> > >>                         unsigned int irq;
> > I think it's just "int irq;" there
> irqs are unsigned. Some functions returning an irq use "int", but
> depending on who you ask this only for error reporting or a relict.
> Use 0 for invalid/unused in mctrl_gpio*.

afaik, IRQ 0 is valid irq number.

---
