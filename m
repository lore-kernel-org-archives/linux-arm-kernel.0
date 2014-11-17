From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Nov 2014 10:09:05 +0000
Subject: [PATCH] gpio: mxs: implement get_direction callback
In-Reply-To: <1416218753.520525851@f237.i.mail.ru>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <CACQ1gAha1MuroyB35zN_BuwRNGS_J3Xh1htiHJda_2_19qh31g@mail.gmail.com>
 <20141117095909.GH27002@pengutronix.de>
 <1416218753.520525851@f237.i.mail.ru>
Message-ID: <20141117100905.GN4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 01:05:53PM +0300, Alexander Shiyan wrote:
> Mon, 17 Nov 2014 10:59:09 +0100 ?? Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Hello Richard,
> > 
> > > >>>> So finally the prototypes would be:
> > > >>>> int mctrl_gpio_request_irqs(struct mctrl_gpios*, struct
> > > >>>> uart_port*, irqhandler_t);
> > > >>>> void mctrl_gpio_free_irqs(struct mctrl_gpios*);
> > > >>
> > > >> I think:
> > > >>
> > > >>         struct mctrl_gpios {
> > > >>                 struct uart_port *port;
> > > >>                 struct {
> > > >>                         gpio_desc *gpio;
> > > >>                         unsigned int irq;
> > > I think it's just "int irq;" there
> > irqs are unsigned. Some functions returning an irq use "int", but
> > depending on who you ask this only for error reporting or a relict.
> > Use 0 for invalid/unused in mctrl_gpio*.
> 
> afaik, IRQ 0 is valid irq number.

No.  IRQ0 is not a valid IRQ number, it's a historical mistake to think it
is (and it is something which needs correcting.)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
