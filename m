From: bp@suse.de (Borislav Petkov)
Date: Wed, 1 Nov 2017 14:50:37 +0100
Subject: [RFC/RFT PATCH 6/6] ACPI / APEI: Remove arch_apei_flush_tlb_one()
In-Reply-To: <20171031153832.17746-7-james.morse@arm.com>
References: <20171031153832.17746-1-james.morse@arm.com>
 <20171031153832.17746-7-james.morse@arm.com>
Message-ID: <20171101135037.zwyzcpcyucqzjjme@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 03:38:32PM +0000, James Morse wrote:
> Nothing calls arch_apei_flush_tlb_one() anymore, instead relying on
> __set_pte_vaddr() to do the invalidation when called from clear_fixmap()
> Remove arch_apei_flush_tlb_one().
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/acpi/apei.c | 5 -----
>  include/acpi/apei.h         | 1 -
>  2 files changed, 6 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

Very nice cleanup. Thanks for doing this!

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)
-- 
