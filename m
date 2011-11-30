From: B29397@freescale.com (Chen Peter-B29397)
Date: Wed, 30 Nov 2011 03:08:47 +0000
Subject: Want to Get Suggestion for MX28 USB Submisson
In-Reply-To: <20111130030401.GA2506@S2100-06.ap.freescale.net>
References: <35AB98346D25394A9354ED89C4D76587225CFF@039-SN1MPN1-002.039d.mgd.msft.net>
 <20111128045733.GA9194@suse.de>
 <20111130030401.GA2506@S2100-06.ap.freescale.net>
Message-ID: <35AB98346D25394A9354ED89C4D7658722713D@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> On Mon, Nov 28, 2011 at 01:57:33PM +0900, Greg KH wrote:
> > On Mon, Nov 28, 2011 at 03:06:48AM +0000, Chen Peter-B29397 wrote:
> > > Hi lists:
> > >
> > > Tony Lin has submitted Freescale mx28 USB Patch at August
> > > (See: http://www.spinics.net/lists/linux-usb/msg50201.html), but it
> hasn't been accepted.
> >
> > Why wasn't it accepted?  Have the issues raised from that last posting
> > of the driver now been addressed?  If not, why not?  If so, great.
> >
> > > I would like to re-submit mx28 usb patches, before that, I would like
> get some suggestion
> > > from you. I think your suggestion will also be benefit for coming
> mx53, mx50 and mx6q's submission.
> > >
> > > All Recently Freescale SoC's USB controller are the same, they are
> mx23, mx25, mx28, mx31, mx35,
> > > mx37, mx50, mx51, mx53, and mx6.
> > > But, the transceiver is different between them
> > > mx23, mx28, mx6 (Transceiver A)
> > > mx25 mx31, mx35,mx37, mx50, mx51, mx53 (Transceiver B)
> > >
> > > Current upstream platform information:
> > > mx23 mx28 ==> mxs platfrom
> > > others (including mx6) ==> mxc platform
> > >
> > > Current upstream USB information:
> > > mx25, mx3x, mx51: ehci-mxc.c (host), fsl_mxc_udc.c(device, main
> functions are at fsl_udc_core.c)
> > >
> > > My plan of submitting mx28 (mx53,mx50, mx6 later if possible):
> > > 1. Replace cpu_is_mxxx() with struct platform_device_id for ehci-
> mxc.c and fsl_mxc_udc.c
> > > 2. Using ehci-mxc.c and fsl_mxc_udc.c for mx28 upstreaming.
> > > For Step 2, I have concern that whether mxs platform users will be
> confused of their
> > > usb driver named xxx_mxc, not xxx_mxs?
> >
> > Do they even care?
> >
> If the renaming will not cause any trouble, I prefer to name them with
> 'imx' which could reasonably cover both mxs and mxc.
> 
Shawn, since current i.mx usb framework and otg/phy structure may not suitable
for mx28's mainline, I will postpone mx28 usb's mainline, and do i.mx usb framework
refine first.
> --
> Regards,
> Shawn
