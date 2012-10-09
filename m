From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 9 Oct 2012 02:49:55 +0000 (UTC)
Subject: [PATCH] ARM: OMAP: move old debug-devices.c and debug-leds.c to
 be OMAP2+ only for now
In-Reply-To: <20121008221333.GZ13011@atomide.com>
References: <alpine.DEB.2.00.1210080145080.5736@utopia.booyaka.com>
 <20121008221333.GZ13011@atomide.com>
Message-ID: <alpine.DEB.2.00.1210090249240.5736@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Oct 2012, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [121007 18:48]:
> > 
> > Commit 801475ccb2b2c1928b22aec4b9e5285d9e347602 ("ARM: OMAP: move
> > debug_card_init() function") results in the following new sparse[1]
> > warning:
> > 
> > arch/arm/plat-omap/debug-devices.c:71:12: warning: symbol 'debug_card_init' was not declared. Should it be static?
> > 
> > Normally this could be fixed by including the appropriate header file
> > in plat-omap/debug-devices.c, but the header file now exists only in
> > mach-omap2/, so this would require a "sideways include" and is thus
> > impractical.  It turns out that only code in mach-omap2/ currently
> > uses the debug-devices.c and debug-leds.c files, so move them there.
> > In the long term, these devices should be created by DT, and the code
> > should be moved into drivers/ somewhere.
> 
> Hmm are you sure that omap1 is not using debug-leds.c?
> At least the initcall seems like it should run on omap1
> if enabled.

Will drop this one for now until we figure out what to do about it.


- Paul
