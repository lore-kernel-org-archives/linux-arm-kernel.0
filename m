From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 5 Jan 2016 11:08:06 +0000
Subject: [PATCHv2 13/18] arm64: mm: add functions to walk tables in fixmap
In-Reply-To: <568AF70A.6020004@redhat.com>
References: <1451930211-22460-1-git-send-email-mark.rutland@arm.com>
 <1451930211-22460-14-git-send-email-mark.rutland@arm.com>
 <568AF70A.6020004@redhat.com>
Message-ID: <20160105110805.GB24664@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 02:49:46PM -0800, Laura Abbott wrote:
> On 01/04/2016 09:56 AM, Mark Rutland wrote:
> >As a prepratory step to allow us to allocate early page tables from
> >unmapped memory using memblock_alloc, add new p??_fixmap* functions that
> >can be used to walk page tables outside of the linear mapping by using
> >fixmap slots.
> >
> >Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> >Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >Cc: Catalin Marinas <catalin.marinas@arm.com>
> >Cc: Jeremy Linton <jeremy.linton@arm.com>
> >Cc: Laura Abbott <labbott@fedoraproject.org>
> >Cc: Will Deacon <will.deacon@arm.com>
> >---
> >  arch/arm64/include/asm/fixmap.h  | 10 ++++++++++
> >  arch/arm64/include/asm/pgtable.h | 26 ++++++++++++++++++++++++++
> >  2 files changed, 36 insertions(+)

> >+#define pgd_fixmap(addr)		((pgd_t *)set_fixmap_offset(FIX_PGD, addr))
> >+#define pgd_fixmap_unmap()		clear_fixmap(FIX_PGD)

> Bikeshed: p??_fixmap_offset doesn't make it obvious that this is an
> operation with a side effect. It seems more similar to
> p??_offset_kernel which is read only. Perhaps it's the lack of set/map
> in the name.

I agree.

I've locally changed them to p??_set_fixmap{,_offset}, p??_clear_fixmap,
to match the usual fixmap function naming.

Thanks,
Mark.
