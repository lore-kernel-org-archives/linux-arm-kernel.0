From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 19 Aug 2011 19:00:07 +0200
Subject: [PATCH 06/12] ARM: mxc: Setup consistent dma size at boot time
In-Reply-To: <1313744901.28978.16.camel@computer2>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
	<1312813712-22808-7-git-send-email-tixy@yxit.co.uk>
	<20110808164731.GP31404@pengutronix.de>
	<alpine.LFD.2.00.1108172309450.20358@xanadu.home>
	<1313655216.2254.9.camel@computer2>
	<20110818185128.GQ31404@pengutronix.de>
	<1313744901.28978.16.camel@computer2>
Message-ID: <20110819170007.GT31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2011 at 10:08:21AM +0100, Tixy wrote:
> > Sorry, I forgot about this issue. The solution is really simple: All
> > boards in tree using video use memblock_* functions to get their
> > coherent dma space for the camera. So we can just remove all
> > CONSISTENT_DMA_SIZE defines in arch/arm/plat-mxc/include/mach/memory.h.
> > 
> > If I understand your patch correctly we get a default size of 2MiB
> > when init_consistent_dma_size() is not called. That's fine for the other
> > i.MX boards.
> 
> Just to make sure I've understood. I see memblock_ calls in
> 	mach-mx31_3ds.c
> 	mach-pcm037.c
> 	mach-mx31moboard.c
> these all seem to be mx3 related.
> 
> For mx1 and mx2, these currently increase CONSISTENT_DMA_SIZE to 4MB,
> but the 2MB default is actually big enough for these?

It should be bigger for boards which make use of the camera driver, but
no mx1/2 board in the tree currently registers the camera.

> 
> Therefore, as you said, we can just delete the definitions of
> CONSISTENT_DMA_SIZE from memory.h and leave all other imx and mx5 files
> unchanged.

Yes

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
