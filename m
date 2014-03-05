From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Tue, 04 Mar 2014 18:28:24 -0800
Subject: [PATCH v6 2/2] ARM hibernation / suspend-to-disk
In-Reply-To: <20140228181731.29118.41809@capellas-linux>
References: <1393545478-14908-1-git-send-email-sebastian.capella@linaro.org>
 <1393545478-14908-3-git-send-email-sebastian.capella@linaro.org>
 <530FD3CF.2040900@codeaurora.org> <530FEAA9.7040601@ti.com>
 <530FF245.7070300@codeaurora.org>
 <20140228102018.GP21483@n2100.arm.linux.org.uk>
 <20140228181731.29118.41809@capellas-linux>
Message-ID: <53168bd7.426b440a.14d5.7306@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sebastian Capella (2014-02-28 10:17:31)
> Quoting Russell King - ARM Linux (2014-02-28 02:20:18)
> > On Thu, Feb 27, 2014 at 06:19:49PM -0800, Stephen Boyd wrote:
> > > On 02/27/14 17:47, Russ Dill wrote:
> > > > On 02/27/2014 04:09 PM, Stephen Boyd wrote:
> > > >> On 02/27/14 15:57, Sebastian Capella wrote:
> > > >>> diff --git a/arch/arm/include/asm/memory.h
> > > >>> b/arch/arm/include/asm/memory.h index 8756e4b..1079ea8 100644 ---
> > > >>> a/arch/arm/include/asm/memory.h +++
> > > >>> b/arch/arm/include/asm/memory.h @@ -291,6 +291,7 @@ static inline
> > > >>> void *phys_to_virt(phys_addr_t x) */ #define __pa(x)
> > > >>> __virt_to_phys((unsigned long)(x)) #define __va(x)                        ((void
> > > >>> *)__phys_to_virt((phys_addr_t)(x))) +#define __pa_symbol(x)
> > > >>> __pa(RELOC_HIDE((unsigned long)(x), 0))
> > > >> Just curious, is there a reason for the RELOC_HIDE() here? Or 
> > > >> __pa_symbol() for that matter? It looks like only x86 uses this on
> > > >> the __nosave_{begin,end} symbol. Maybe it's copy-pasta?
> > > > From my understanding this needs to stick around so long as gcc 3.x is
> > > > supported (did it get dropped yet?) on ARM Linux since it doesn't
> > > > support -fno-strict-overflow.
> > > 
> > > I don't think it's been dropped yet but I wonder if anyone has tried
> > > recent kernels with such a compiler?
> > > 
> > > Would the usage of &__pv_table_begin in arch/arm/mm/mmu.c also need the
> > > same treatment?
> > 
> > We've never had to play these kinds of games on ARM irrespective of
> > compiler version.
> 
> I am using gcc 4.6.3.  I can try removing it but I suspect it will just
> work without it.  Let me see if I can get an older compiler and try both
> ways.

Hi,

I've been struggling a bit to test 3.x compilers on this.

I'm running an armv7 board, but the 3.x compilers I'm trying
don't appear to suport armv7.

Anyone have any suggestions?  Is this a worthwhile effort?

Thanks!

Sebastian
