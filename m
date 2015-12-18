From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Fri, 18 Dec 2015 12:11:39 +0000
Subject: arm64/efi handling of persistent memory
In-Reply-To: <20151218115224.GE29219@leverpostej>
References: <94D0CD8314A33A4D9D801C0FE68B40295BEBD864@G9W0745.americas.hpqcorp.net>
 <20151218110651.GL25034@bivouac.eciton.net>
 <20151218115224.GE29219@leverpostej>
Message-ID: <20151218121139.GM25034@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 11:52:24AM +0000, Mark Rutland wrote:
> On Fri, Dec 18, 2015 at 11:06:51AM +0000, Leif Lindholm wrote:
> > On Fri, Dec 18, 2015 at 01:33:25AM +0000, Elliott, Robert (Persistent Memory) wrote:
> > > Similar to the questions about the arm64 efi boot stub
> > > handing persistent memory, some of the arm64 kernel code 
> > > looks fishy.
> 
> [...]
> 
> > > 2. is_reserve_region() treating EFI_PERSISTENT_MEMORY the same
> > > as EFI_CONVENTIONAL_MEMORY looks wrong.
> > 
> > Yeah... That one was introduced by
> > ad5fb870c486 ("e820, efi: add ACPI 6.0 persistent memory types")
> > without any ACKs from ARM people :/
> 
> Do we need to do anythign to avoid his kind of thing in future? e.g. a
> MAINTAINERS patch for the ARM EFI bits?

We've not needed that sort of thing in the past.
And running get_maintainer.pl on ad5fb870c486 does yield Catalin,
Will, Matt Fleming, you, Ard, me, lakml and linux-efi.

> Or do we just need to pay attention to linux-efi?

While I am certainly guilty of not watching that closely enough, I
can't actually find that patch in my linux-efi history. Or lakml.

/
    Leif
