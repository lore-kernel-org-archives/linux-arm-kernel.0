From: richard.genoud@gmail.com (Richard Genoud)
Date: Mon, 17 Nov 2014 11:10:53 +0100
Subject: [PATCH] gpio: mxs: implement get_direction callback
In-Reply-To: <1416218753.520525851@f237.i.mail.ru>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <CACQ1gAha1MuroyB35zN_BuwRNGS_J3Xh1htiHJda_2_19qh31g@mail.gmail.com>
 <20141117095909.GH27002@pengutronix.de> <1416218753.520525851@f237.i.mail.ru>
Message-ID: <CACQ1gAjCK68qB4iQhyAbfWErpbSC2z0B+SiOWChoqUNamDb-3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-17 11:05 GMT+01:00 Alexander Shiyan <shc_work@mail.ru>:
> Mon, 17 Nov 2014 10:59:09 +0100 ?? Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>> Hello Richard,
>>
>> > >>>> So finally the prototypes would be:
>> > >>>> int mctrl_gpio_request_irqs(struct mctrl_gpios*, struct
>> > >>>> uart_port*, irqhandler_t);
>> > >>>> void mctrl_gpio_free_irqs(struct mctrl_gpios*);
>> > >>
>> > >> I think:
>> > >>
>> > >>         struct mctrl_gpios {
>> > >>                 struct uart_port *port;
>> > >>                 struct {
>> > >>                         gpio_desc *gpio;
>> > >>                         unsigned int irq;
>> > I think it's just "int irq;" there
>> irqs are unsigned. Some functions returning an irq use "int", but
>> depending on who you ask this only for error reporting or a relict.
>> Use 0 for invalid/unused in mctrl_gpio*.
>
> afaik, IRQ 0 is valid irq number.
Unfortunately, that's right. For instance on atmel processors, irq 0
is often used.
