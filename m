From: david@gibson.dropbear.id.au (David Gibson)
Date: Wed, 9 Aug 2017 14:06:42 +1000
Subject: [PATCH] scripts/dtc: fix '%zx' warning
In-Reply-To: <20170808112818.GC20805@n2100.armlinux.org.uk>
References: <E1da2Z7-0008GG-AV@rmk-PC.armlinux.org.uk>
 <20170726013004.GJ8978@umbus.fritz.box>
 <20170808112818.GC20805@n2100.armlinux.org.uk>
Message-ID: <20170809040642.GG13670@umbus.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 08, 2017 at 12:28:19PM +0100, Russell King - ARM Linux wrote:
> On Wed, Jul 26, 2017 at 11:30:04AM +1000, David Gibson wrote:
> > On Tue, Jul 25, 2017 at 05:20:09PM +0100, Russell King wrote:
> > > dtc uses an incorrect format specifier for printing a uint64_t value.
> > > uint64_t may be either 'unsigned long' or 'unsigned long long' depending
> > > on the host architecture.
> > > 
> > > Fix this by using %llx and casting to unsigned long long, which ensures
> > > that we always have a wide enough variable to print 64 bits of hex.
> > > 
> > >   HOSTCC  scripts/dtc/checks.o
> > > scripts/dtc/checks.c: In function 'check_simple_bus_reg':
> > > scripts/dtc/checks.c:876:2: warning: format '%zx' expects argument of type 'size_t', but argument 4 has type 'uint64_t' [-Wformat=]
> > >   snprintf(unit_addr, sizeof(unit_addr), "%zx", reg);
> > >   ^
> > > scripts/dtc/checks.c:876:2: warning: format '%zx' expects argument of type 'size_t', but argument 4 has type 'uint64_t' [-Wformat=]
> > > 
> > > Fixes: 828d4cdd012c ("dtc: check.c fix compile error")
> > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > 
> > This (embarrassing) error is already fixed in upstream dtc.
> 
> It remains unfixed in 4.13-rc4.  How do we get this fixed in the
> kernel's dtc?  From what I can see, sending a patch to fix stuff
> doesn't work.

Um.. I don't know.  I haven't been the person doing updates of the
kernel dtc to match upstream dtc for ages.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170809/a642415a/attachment.sig>
