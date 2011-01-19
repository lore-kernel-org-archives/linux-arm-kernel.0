From: tony@atomide.com (Tony Lindgren)
Date: Wed, 19 Jan 2011 11:04:42 -0800
Subject: [PATCH v5 09/14] OMAP: DMA: Convert DMA library into platform
	driver
In-Reply-To: <AANLkTikbnP55ERXy5G7NyeF-FHcGAxcpUyZnoYx+iOKO@mail.gmail.com>
References: <1290603110-14119-1-git-send-email-manjugk@ti.com>
	<1290603110-14119-10-git-send-email-manjugk@ti.com>
	<20101202184419.GR17222@atomide.com>
	<20101202184617.GS17222@atomide.com>
	<20101202184925.GT17222@atomide.com>
	<20101202200454.GA27696@manju-desktop>
	<20101202205219.GV17222@atomide.com>
	<20101203164317.GB10048@GLPP-machine>
	<AANLkTikbnP55ERXy5G7NyeF-FHcGAxcpUyZnoYx+iOKO@mail.gmail.com>
Message-ID: <20110119190441.GB4957@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* G, Manjunath Kondaiah <manjugk@ti.com> [110113 03:19]:
> >
> >>
> >> Also, eventually within next few merge cycles we should have:
> >>
> >> arch/arm/mach-omap1/dma.c ? ? omap1 specific platform init
> >> arch/arm/mach-omap2/dma.c ? ? omap2+ specific platform init
> >
> > This seems to be ok.
> >
> >> drivers/dma/omap-dma.c ? ? ? ? ? ? ? ?driver using dmaengine.c
> >
> > This might require more time.
> 
> Since this will take more time, can we have run time pm changes on top
> of existing dma hwmod changes?
> If so, I can pull out run time pm patch from the dma hwmod series and
> resend it again.

Sure. That will make it easier to convert it to use dmaengine
eventually.

Tony
