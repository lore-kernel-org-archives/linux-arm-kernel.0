From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Dec 2015 14:08:40 +0000
Subject: [RFC PATCH 04/20] arm64: mm: assume PAGE SIZE for page table
 allocator
In-Reply-To: <1449665095-20774-5-git-send-email-mark.rutland@arm.com>
References: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
 <1449665095-20774-5-git-send-email-mark.rutland@arm.com>
Message-ID: <20151210140840.GE21134@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2015 at 12:44:39PM +0000, Mark Rutland wrote:
> We pass a size parameter to early_alloc and late_alloc, but these are
> only ever used to allocate single pages. In late_alloc we always
> allocate a single page.
> 
> Remove the redundant size parameter.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Laura Abbott <labbott@fedoraproject.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)

Looks sensible to me. Cosmetic nit, but we could we rename these to
early_page_alloc/late_page_alloc instead, please?

Will
