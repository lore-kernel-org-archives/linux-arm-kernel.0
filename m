From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 24 Apr 2012 22:49:47 +0200
Subject: [PATCH 08/11] MXS: Add imx-otg driver
In-Reply-To: <201204241949.37938.marex@denx.de>
References: <1335099567-21056-1-git-send-email-marex@denx.de>
 <20374.53520.690267.206408@ipc1.ka-ro>
 <20120424164751.GY3852@pengutronix.de>
 <201204241949.37938.marex@denx.de>
Message-ID: <20120424204947.GZ3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 07:49:37PM +0200, Marek Vasut wrote:
> > > > > 
> > > > > Why do you call this driver imx-otg when it is actually MXS specific?
> > > > > How would you call a corresponding driver for the remaining i.MX
> > > > > processors?
> > > > 
> > > > This is the driver for the all i.MX processors.
> > > 
> > > If it is for all i.MX processors, it shouldn't access MXS specific
> > > registers, like:
> > > +		writel(wakeup, x->io_priv + HW_USBPHY_CTRL_SET);
> > 
> > Indeed not. This should be done in the phy driver.
> 
> Ok, so now you figured out that all these set_host() set_peripheral() work() 
> calls should be back in the phy driver, not in the imx-otg? hm ... so back to 
> the V4 of the patchset?

Not really, you are just not allowed to put phy code into imx-otg.c,
because the phy may be another one on a different SoC.

That said, I am a bit confused at the moment. There seems to be no
method to activate the interrupt in the phy.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
