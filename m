From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 Nov 2009 13:27:00 +0100
Subject: i.MX audio support
In-Reply-To: <20091120111703.GB20236@rakim.wolfsonmicro.main>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<20091120111703.GB20236@rakim.wolfsonmicro.main>
Message-ID: <20091120122700.GY30179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2009 at 11:17:03AM +0000, Mark Brown wrote:
> On Thu, Nov 19, 2009 at 04:48:14PM +0100, Sascha Hauer wrote:
> 
> > one single FIFO. The WM9712 I worked with sends data in slot 12 which we have
> > to sort out manually from the FIFO, so I think there is no way to work around
> > the fiq handler using the DMA engine with AC97.
> 
> Slot 12 is used for GPIOs to allow them to be read/written without
> register accesses - I'd expect that data there will not be uncommon.
> 
> > The devdma code is actually a copy of sound/arm/devdma.[ch]. It should probably
> > be selected somehow instead of duplicated.
> 
> Yes, ideally.  A simple Makefile change in sound/arm should do the
> trick.  Other than this I'm happy with all the patches I've not
> specifically commented on.

Ok, great. I'm working on the comments you made. I expect this
will take some days. Thanks for review.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
