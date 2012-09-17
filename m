From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Sep 2012 14:25:07 -0700
Subject: [PATCH 17/24] ARM: OMAP: use __iomem pointers for MMIO
In-Reply-To: <20120916203850.GI4521@atomide.com>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-18-git-send-email-arnd@arndb.de>
 <20120915181057.GH4521@atomide.com>
 <201209152014.37989.arnd@arndb.de>
 <20120916203850.GI4521@atomide.com>
Message-ID: <20120917212506.GB11762@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120916 13:39]:
> * Arnd Bergmann <arnd@arndb.de> [120915 13:15]:
> > On Saturday 15 September 2012, Tony Lindgren wrote:
> > > With my patches, this is now all omap1 specific and
> > > moved to arch/arm/mach-omap1/include/mach/hardware.h.
> > > It's probably easiest to just update this patch on
> > > top of the hardware.h changes I've done.
> > 
> > Yes, sounds good. Do you want to send a patch for that
> > and let me drop this one then?
> 
> Yes I can pick this one and update it against one of my
> branches to avoid merge conflicts.

This applies against mach-omap1/include/mach/hardware.h
with some fuzz so no issues there.

But I think we should not apply it as these are physical
addresses, not virtual addresses for omap1.

We have IOMEM already in use for omap_read/write because of:

#define OMAP1_IO_ADDRESS(pa)	IOMEM((pa) - OMAP1_IO_OFFSET)

I think the right solution is to eventually get rid of
omap_read/write for omap1 also and replace them with ioremap
+ readl/writel.

Or am I missing something?

Regards,

Tony
