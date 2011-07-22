From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 22 Jul 2011 11:18:44 +0200
Subject: [PATCH 3/7] add usb phy clocks to clock tree
In-Reply-To: <97D3A72708D04647A5AC84A04996E5B51622DF@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
	<1311160106-4898-4-git-send-email-tony.lin@freescale.com>
	<20110720191034.GL26347@pengutronix.de>
	<97D3A72708D04647A5AC84A04996E5B51622DF@039-SN1MPN1-006.039d.mgd.msft.net>
Message-ID: <20110722091844.GW20587@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2011 at 06:02:00AM +0000, Lin Tony-B19295 wrote:
> > >  	_REGISTER_CLOCK(NULL, "usb1", usb1_clk)
> > > +	_REGISTER_CLOCK(NULL, "usb0_phy", usb_phy_clk0)
> > > +	_REGISTER_CLOCK(NULL, "usb1_phy", usb_phy_clk1)
> > 
> > This looks suspicious. The phys are real devices, but this shows you do
> > not intend to use them as devices. Really the phys should be drivers.
> > 
> > Sascha
> > 
> Hi Sascha:
> 
> 	I didn't get it. Shouldn't I register PHY clocks here?
> '_REGISTER_CLOCK("mxc-ehci.0", "usb_phy1", usb_phy1_clk)'
> 	This is what mx51/53 did in clock-mx51-mx53.c

Yes, you should register them, but like this:

_REGISTER_CLOCK("mxs-usb-phy.0", NULL, usb_phy_clk0)
_REGISTER_CLOCK("mxs-usb-phy.1", NULL, usb_phy_clk1)

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
