From: B19295@freescale.com (Lin Tony-B19295)
Date: Mon, 8 Aug 2011 02:03:58 +0000
Subject: [PATCH v4 0/7] ARM: mx28: add usb host function
In-Reply-To: <20110805165250.GJ31404@pengutronix.de>
References: <1312274386-6833-1-git-send-email-tony.lin@freescale.com>
	<97D3A72708D04647A5AC84A04996E5B516A392@039-SN1MPN1-006.039d.mgd.msft.net>
	<20110805130301.GG31404@pengutronix.de>
	<20110805142252.GA12405@nchen-desktop>
	<20110805165250.GJ31404@pengutronix.de>
Message-ID: <97D3A72708D04647A5AC84A04996E5B5174DE7@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of s.hauer at pengutronix.de
> Sent: Saturday, August 06, 2011 12:53 AM
> To: Chen Peter-B29397
> Cc: heikki.krogerus at linux.intel.com; linux-usb at vger.kernel.org;
> stern at rowland.harvard.edu; Lin Tony-B19295; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v4 0/7] ARM: mx28: add usb host function
> 
> On Fri, Aug 05, 2011 at 10:22:54PM +0800, Peter Chen wrote:
> > On Fri, Aug 05, 2011 at 03:03:01PM +0200, s.hauer at pengutronix.de wrote:
> > > On Fri, Aug 05, 2011 at 07:53:21AM +0000, Lin Tony-B19295 wrote:
> > > > Any comments for the patch series?
> > >
> > > Yes. The way you handle the USB phys is totally inacceptable. Please
> > > understand that there are *two* devices, one is the ehci core and
> > > the other is the associated phy.
> > >
> > > You need to register the phy as a platform device, the corresponding
> > > driver then has to register the phy using some kind of
> usb_transceiver_register().
> > > On the ehci side the mxc-ehci driver has to find its phy using
> > > usb_get_transceiver().
> > >
> > > Note that the infrastructure needed for this is not in the kernel,
> > > but there are patches recently posted on linux-usb:
> > >
> > > http://www.spinics.net/lists/linux-usb/msg50148.html
> > >
> > > Sascha
> > >
> > I have discussed with Heikki, his framework is good, it saperates phys
> > from otg driver, so phy's utilities can be called at both otg and
> > device only mode, besides it can support usb charger better.
> >
> > So, do we pause i.mx28 usb's upstream until Heikki's otg modification
> > in master, or just do thing like ulpi.c?
> 
> I think you can use Heikkis patches as a base. They will get updates
> before hitting mainline, but the changes to the (phy-) driver side should
> be trivial. This way we can also detect possible problems with Heikkis
> patches. There's plenty of time before the next merge window to get the
> patches into shape.
> 
Ok. Thanks for your advice.
Tony

> Sascha
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555
> |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
