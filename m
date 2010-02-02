From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 2 Feb 2010 10:55:37 +0100
Subject: Uncompressing broken with commit e7db7b4270
In-Reply-To: <F01D8B85CFF58440B2A13965FBA90CA4177969@GEORGE.Emea.Arm.com>
References: <1264698229.7064.93.camel@pc1117.cambridge.arm.com>
	<000001caa0fd$cef2f740$9fca010a@Emea.Arm.com>
	<20100202090121.GC22848@pengutronix.de>
	<F01D8B85CFF58440B2A13965FBA90CA4177969@GEORGE.Emea.Arm.com>
Message-ID: <20100202095537.GA32099@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Colin,

On Tue, Feb 02, 2010 at 09:07:47AM +0000, Colin Tuckley wrote:
> > -----Original Message-----
> > From: Uwe Kleine-K?nig [mailto:u.kleine-koenig at pengutronix.de]
> 
> > What do you mean saying "kernel image"?  zImage, Image, vmlinux,
> > arch/arm/boot/compressed/vmlinux?
> 
> It's actually a uImage (compressed image with u-boot 64 byte header).
> 
> > So where do you place your zImage, what is zreladdr, how big is your
> > RAM?
> 
> It gets loaded by u-boot TFTP into RAM at the physical address of memory at 0x70000000 and we have either 512MB or 1GB of RAM depending on which system it is.
> 
> zreladdr is 0x70008000
That should be fine.

What is the output on your machine?  If you see "done", can you try
defining DEBUG in arch/arm/boot/compressed/head.S?

Best reagards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
