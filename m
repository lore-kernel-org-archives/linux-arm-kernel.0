From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 15 Jan 2013 09:31:31 +0800
Subject: [PATCH v3 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
In-Reply-To: <20130114175724.GD12611@arwen.pp.htv.fi>
References: <50F3DF1D.3040706@pengutronix.de>
 <20130114103952.GF10874@arwen.pp.htv.fi>
 <50F3E301.7040509@pengutronix.de>
 <20130114105357.GH10874@arwen.pp.htv.fi>
 <50F3E5E8.2000905@pengutronix.de>
 <20130114110600.GI10874@arwen.pp.htv.fi>
 <20130114125632.GA30157@nchen-desktop>
 <20130114174054.GB12611@arwen.pp.htv.fi>
 <50F4464E.7000605@pengutronix.de>
 <20130114175724.GD12611@arwen.pp.htv.fi>
Message-ID: <20130115013130.GA16514@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 07:57:24PM +0200, Felipe Balbi wrote:
> On Mon, Jan 14, 2013 at 06:54:22PM +0100, Marc Kleine-Budde wrote:
> > On 01/14/2013 06:40 PM, Felipe Balbi wrote:
> > > Hi,
> > > 
> > > On Mon, Jan 14, 2013 at 08:56:33PM +0800, Peter Chen wrote:
> > > 
> > > <snip>
> > > 
> > >>>> Usually there isn't any Changelog between IP cores used in the different
> > >>>> fsl processors (at least available outside of fsl), that makes it quite
> > >>>> difficult to say if something found on one imx is really the same as on
> > >>>> the other one. And they (usually) don't provide any versioning
> > >>>> information in a register or the documentation.
> > >>>>
> > >>>> just my 2?
> > >>>
> > >>> $SUBJECT is trying to differentiate a single feature (or maybe two) to
> > >>> replace cpu_is_xxx(), then expose that on driver_data without creating
> > >>> one enum value for each release from fsl.
> > >>
> > >> Felipe, every one or two SoCs may have their special operations for
> > >> integrate PHY interface, clk operation, or workaround for IC
> > >> limitation.
> > > 
> > > the particular PHY and clk used should be hidden by phy layer and clk
> > > API respectively. Workarounds, fair enough, we need to handle them; but
> > > ideally those should be based on runtime revision detection, not some
> > > hackery using driver_data.
> > 
> > If this is actually possible, I'd love to do this. But IP vendor don't
> > include a version register in their cores. :(
> 
> then fair enough, driver_data or platform_data is the way to go, still
> my point (a) below is valid.
I will send v5 patch with your suggestion.

> 
> -- 
> balbi



-- 

Best Regards,
Peter Chen
