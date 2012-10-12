From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Oct 2012 11:17:43 +0000
Subject: [PATCH 1/6] ARM: bcm476x: Add infrastructure
In-Reply-To: <20121012130139.6c3079c5@skate>
References: <20121007015300.828366635@gmail.com>
 <201210121048.24998.arnd@arndb.de> <20121012130139.6c3079c5@skate>
Message-ID: <201210121117.44153.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 October 2012, Thomas Petazzoni wrote:
> On Fri, 12 Oct 2012 10:48:24 +0000, Arnd Bergmann wrote:
> 
> > The main thing to watch out for are mappings that are not for MMIO,
> > such as the call to create_mapping() in map_lowmem() or in
> > devicemaps_init().
> > 
> > I would suggest making struct map_desc specific to callers of
> > iotable_init() and changing the prototype for create_mapping() to
> > 
> > void __init create_mapping(unsigned long virtual, unsigned long pfn,
> >                          size_t length, unsigned int type);
> 
> Yes, this is exactly what I've done. I'll rebase my work, test and send
> it.

Ok, looking forward to it. FWIW, I have a branch called
testing/defconfig-warnings in the arm-soc tree that shuts up all known
build warnings. If you pull that in for testing, you can see if any
warnings were added by your patches.

	Arnd
