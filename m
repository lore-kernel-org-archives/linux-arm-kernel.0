From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Aug 2011 11:26:16 +0100
Subject: [PATCH v3] amba: consolidate PrimeCell magic
In-Reply-To: <1313662087.2254.31.camel@computer2>
References: <1313569846-22902-1-git-send-email-linus.walleij@stericsson.com>
	<ADE657CA350FB648AAC2C43247A983F001F3884BB382@AUSP01VMBX24.collaborationhost.net>
	<20110817184905.GA11221@n2100.arm.linux.org.uk>
	<1313662087.2254.31.camel@computer2>
Message-ID: <20110818102616.GC21865@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2011 at 11:08:07AM +0100, Tixy wrote:
> On Wed, 2011-08-17 at 19:49 +0100, Russell King - ARM Linux wrote:
> > On Wed, Aug 17, 2011 at 12:03:57PM -0500, H Hartley Sweeten wrote:
> > > > +	cellid = amba_get_pid((void __iomem *)((u32)base & PAGE_MASK), SZ_4K);
> > > 
> > > This produces a sparse warning.  But, the same warning was present with the
> > > old code.
> > > 
> > > arch/arm/common/vic.c:353:49: warning: cast removes address space of expression
> > 
> > That's prabably because casting from a pointer to a u32 (unsigned int)
> > isn't the best thing to do.  Casting to unsigned long is much better,
> > and iirc doesn't provoke such a sparse warning.
> 
> Is there any reason not to use uintptr_t for things like this?

Probably not - it's just history that we've tended to use the base C
types rather than the typedef'd stuff for this kind of thing.
