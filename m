From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 26 Sep 2011 14:25:20 +0200
Subject: [PATCH 1/4] ARM i.MX avic: add handle_irq function
In-Reply-To: <20110926112151.GE22455@n2100.arm.linux.org.uk>
References: <1317030369-29352-1-git-send-email-s.hauer@pengutronix.de>
	<1317030369-29352-2-git-send-email-s.hauer@pengutronix.de>
	<20110926112151.GE22455@n2100.arm.linux.org.uk>
Message-ID: <20110926122520.GS31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 12:21:51PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 26, 2011 at 11:46:06AM +0200, Sascha Hauer wrote:
> > +void avic_handle_irq(struct pt_regs *);
> > +
> > +#define imx1_handle_irq avic_handle_irq
> > +#define imx21_handle_irq avic_handle_irq
> > +#define imx25_handle_irq avic_handle_irq
> > +#define imx27_handle_irq avic_handle_irq
> > +#define imx31_handle_irq avic_handle_irq
> > +#define imx35_handle_irq avic_handle_irq
> 
> Is there really something wrong in knowing (elsewhere) that mx1..mx35 all
> use the avic irq handler?

No technical reason. I copied this from the pxa code and thought
this way a board implementer does not need to know the interrupt
controller type but only the SoC type. We can use avic_/tzic_
directly if you like.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
