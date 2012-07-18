From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 18 Jul 2012 13:36:46 +0200
Subject: [PATCH v2 1/2] USB: chipidea: add imx usbmisc support
In-Reply-To: <20120718111916.GL21635@b20223-02.ap.freescale.net>
References: <1342607348-8587-1-git-send-email-richard.zhao@freescale.com>
 <1342607348-8587-2-git-send-email-richard.zhao@freescale.com>
 <20120718105204.GF30009@pengutronix.de>
 <20120718111916.GL21635@b20223-02.ap.freescale.net>
Message-ID: <20120718113646.GH30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2012 at 07:19:17PM +0800, Richard Zhao wrote:
> > > +
> > > +struct imx6q_usbmisc {
> > > +	void __iomem *base;
> > > +	struct clk *clk;
> > > +	struct device *usb_dev[USB_DEV_MAX];
> > > +	spinlock_t lock;
> > > +
> > > +	int disable_oc:USB_DEV_MAX;
> > > +};
> > 
> > Please add a per-port struct instead of adding multiple arrays into
> > struct imx6q_usbmisc.
> ok
> 
> > 
> > Also, I think this per port struct shouldn't be imx6q specific. Then
> > we could add generic code parsing the oftree flags into the port
> > specific struct and have SoC specific code which translates this struct
> > into the acual register settings.
> hmm... I thought only ops is generic. The code is SoC specific, I doubt
> do we really need to take the properties as generic?

I think it would be good. They mostly match across the different i.MX
SoCs.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
