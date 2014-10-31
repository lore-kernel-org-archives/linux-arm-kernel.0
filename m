From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Oct 2014 21:47:55 +0100
Subject: [PATCH 1/3] ARM: Add default SPARSEMEM settings
In-Reply-To: <CADtm3G6vygCo8LK5drqCNH6r3gp8kPq6BrnMFjxJ2Q=BX7YKmg@mail.gmail.com>
References: <1410488562-21863-1-git-send-email-cernekee@gmail.com>
 <CADtm3G6vygCo8LK5drqCNH6r3gp8kPq6BrnMFjxJ2Q=BX7YKmg@mail.gmail.com>
Message-ID: <3450236.7ui9jXEKqb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 October 2014 13:11:54 Gregory Fong wrote:
> On Thu, Sep 11, 2014 at 7:22 PM, Kevin Cernekee <cernekee@gmail.com> wrote:
> > We can still override these settings via mach/memory.h, but let's provide
> > sensible defaults so that SPARSEMEM is available in the multiplatform
> > kernels.
> >
> > Two platforms currently use SECTION_SIZE_BITS < 28, but are expected to
> > work with 28 (albeit slightly less efficiently if not all banks are
> > populated):
> >
> >  - mach-rpc: uses 26 bits.  Based on mach/hardware.h it looks like this
> >    platform puts RAM at 0x1000_0000 - 0x1fff_ffff, and I/O below
> >    0x1000_0000.
> >
> >  - mach-sa1100: uses 27 bits.  mach/memory.h indicates that RAM occupies
> >    the entire range of 0xc000_0000 - 0xdfff_ffff.
> >
> > Several platforms need MAX_PHYSMEM_BITS >= 36 so we'll pick that as the
> > minimum.  Anything higher and we'll fail the SECTIONS_WIDTH + NODES_WIDTH +
> > ZONES_WIDTH test in <linux/mm.h>.
> >
> > Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> 
> Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
> 

I didn't see this patch originally, just saw the reply. The patch looks
good, but it's worth noting in the changelog that rpc and sa1100 will
never have to use the default, because they cannot be part of a multiplatform
kernel, and that is very unlikely to ever change.

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
