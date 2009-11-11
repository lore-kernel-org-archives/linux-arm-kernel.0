From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Wed, 11 Nov 2009 01:02:11 +0100
Subject: [PATCH] OMAP1: PM: Fix omapfb/lcd on Amstrad Delta broken when PM
	set
In-Reply-To: <alpine.DEB.2.00.0911100347320.20233@utopia.booyaka.com>
References: <200910292339.48610.jkrzyszt@tis.icnet.pl>
	<200910301542.27206.jkrzyszt@tis.icnet.pl>
	<alpine.DEB.2.00.0911100347320.20233@utopia.booyaka.com>
Message-ID: <200911110102.16009.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tuesday 10 November 2009 11:50:52 Paul Walmsley napisa?(a):
> Hello Janusz et al,
>
> On Fri, 30 Oct 2009, Janusz Krzysztofik wrote:
> > More looking at it, I found that might be omap_dma_running() from
> > arch/arm/plat-omap/dma.c that needs correction. It already checks for LCD
> > dma running for OMAP1610, but does nothing similiar for 1510. I have
> > revisited http://focus.ti.com/lit/ug/spru674/spru674.pdf, but found no
> > hint how to do that in a 1610 similiar way.
>
> Speaking of this code, here's a project suggestion if someone has some
> spare time.  All of the LCD DMA code in plat-omap/dma.c appears to be
> OMAP1-only (and apparently only is available on a subset of OMAP1 chips).
> It would be great if this code could be moved to mach-omap1/lcd_dma.c or
> a similar place.

Paul,

Thank you for putting me into right direction (I hope :-)). If there are no 
more comments, I'll try to take care of what you suggest after the situation 
with my pending patches AND Tomi Valkeinen's DSS2 patch series, that both 
more or less fiddle with LCD DMA related files, gets clear.

Thanks,
Janusz
