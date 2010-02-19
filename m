From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 19 Feb 2010 15:21:35 +0100
Subject: Uncompressing broken with commit e7db7b4270
In-Reply-To: <20100203094107.GC11354@pengutronix.de>
References: <1264698229.7064.93.camel@pc1117.cambridge.arm.com>
	<000001caa0fd$cef2f740$9fca010a@Emea.Arm.com>
	<20100202090121.GC22848@pengutronix.de>
	<F01D8B85CFF58440B2A13965FBA90CA4177969@GEORGE.Emea.Arm.com>
	<20100202095537.GA32099@pengutronix.de>
	<1265105976.12634.10.camel@pc1117.cambridge.arm.com>
	<20100203094107.GC11354@pengutronix.de>
Message-ID: <20100219142135.GB6959@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Feb 03, 2010 at 10:41:07AM +0100, Uwe Kleine-K?nig wrote:
> Hello Catalin,
> 
> On Tue, Feb 02, 2010 at 10:19:36AM +0000, Catalin Marinas wrote:
> > On Tue, 2010-02-02 at 09:55 +0000, Uwe Kleine-K?nig wrote:
> > > On Tue, Feb 02, 2010 at 09:07:47AM +0000, Colin Tuckley wrote:
> > > > > -----Original Message-----
> > > > > From: Uwe Kleine-K?nig [mailto:u.kleine-koenig at pengutronix.de]
> > > >
> > > > > What do you mean saying "kernel image"?  zImage, Image, vmlinux,
> > > > > arch/arm/boot/compressed/vmlinux?
> > > >
> > > > It's actually a uImage (compressed image with u-boot 64 byte header).
> > > >
> > > > > So where do you place your zImage, what is zreladdr, how big is your
> > > > > RAM?
> > > >
> > > > It gets loaded by u-boot TFTP into RAM at the physical address of 
> > > > memory at 0x70000000 and we have either 512MB or 1GB of RAM 
> > > > depending on which system it is.
> > > >
> > > > zreladdr is 0x70008000
> > > That should be fine.
> > > 
> > > What is the output on your machine?  If you see "done", can you try
> > > defining DEBUG in arch/arm/boot/compressed/head.S?
> > 
> > I don't think we were seeing any "done". Just "Uncompressing Linux ...".
> > 
> > I need to get back to a bigger kernel image and I'll then try to
> > increase the stack size in the compressed head.S.
> Can you try the patch below and report the output in the failing case?
> 
> I tried to get STAND_ALONE_DEBUG running, but the code suffered bit rot
> and is far away from working.
> 
> And I think it makes sense to make sure it's not a toolchain problem.
> So can you send me a config and I give you back an uImage compiled with
> my toolchain?  And maybe the other way round, too?
ping.

If we choose to revert e7db7b4270 we should do so before 2.6.33.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
