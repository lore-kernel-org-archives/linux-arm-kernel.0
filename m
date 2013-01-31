From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 31 Jan 2013 10:05:44 +0800
Subject: [PATCH,RFC] usb: add devicetree helpers for determining
 dr_mode and phy_type
In-Reply-To: <20130130140015.GZ1906@pengutronix.de>
References: <1359458548-25071-1-git-send-email-s.hauer@pengutronix.de>
 <87pq0omcfb.fsf@ashishki-desk.ger.corp.intel.com>
 <20130130020627.GA699@nchen-desktop>
 <20130130140015.GZ1906@pengutronix.de>
Message-ID: <20130131020542.GD9777@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 03:00:15PM +0100, Sascha Hauer wrote:
> On Wed, Jan 30, 2013 at 10:06:28AM +0800, Peter Chen wrote:
> > On Tue, Jan 29, 2013 at 01:55:04PM +0200, Alexander Shishkin wrote:
> > > Sascha Hauer <s.hauer@pengutronix.de> writes:
> > > 
> > > > From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > > >
> > > > This adds two little devicetree helper functions for determining the
> > > > dr_mode (host, peripheral, otg) and phy_type (utmi, ulpi,...) from
> > > > the devicetree.
> > > >
> > > > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > > > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > > > ---
> > > >
> > > > The properties and their values have been taken from the fsl-mph-dr driver.
> > > > This binding is also documented (though currently not used) for the tegra
> > > > ehci driver (Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt).
> > > > This is a first attempt to parse these bindings at a common place so that
> > > > others can make use of it.
> > > >
> > > > Basically I want to know whether this binding is recommended for new drivers
> > > > since normally the devicetree uses '-' instead of '_', and maybe there are
> > > > other problems with it.
> > > >
> > > > I need this binding for the chipidea driver. I suspect that the fsl-mph-dr
> > > > driver also really handles a chipidea core.
> > > 
> > > As far as I know, it is a chipidea core. Adding Peter to Cc list, he can
> > > probably confirm.
> > 
> > The fsl-mph-dr can't be used for chipdiea as it handles three platform
> > drivers for three roles (peripheral , host, otg). But chipidea only has
> > two platform drivers, one is the chipidea core, the other is related
> > controller wrapper.
> 
> What do you mean by 'three platform drivers'? That's only how the driver
> is built, no? I was talking about the hardware the fsl-mph-dr driver
> handles which definitely smells like chipidea.

It creates host/device/otg platform device according to dr_mode from
the device tree.
> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 

-- 

Best Regards,
Peter Chen
