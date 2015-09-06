From: yalin.wang2010@gmail.com (yalin wang)
Date: Sun, 6 Sep 2015 12:05:01 +0800
Subject: [PATCH] arm64: add kc_offset_to_vaddr and kc_vaddr_to_offset macro
In-Reply-To: <20150902102454.GG25720@arm.com>
References: <1440915599-18485-1-git-send-email-yalin.wang2010@gmail.com>
 <20150902102454.GG25720@arm.com>
Message-ID: <2771ED00-BE84-4734-BE90-C0A600964F1E@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ok

i will send a V2 patch for this change.
> On Sep 2, 2015, at 18:24, Will Deacon <will.deacon@arm.com> wrote:
> 
> On Sun, Aug 30, 2015 at 07:19:59AM +0100, yalin wang wrote:
>> This patch add kc_offset_to_vaddr() and kc_vaddr_to_offset(),
>> the default version doesn't work on arm64, because arm64 kernel address
>> is below the PAGE_OFFSET, like module address and vmemmap address are
>> all below PAGE_OFFSET address.
>> 
>> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
>> ---
>> arch/arm64/include/asm/pgtable.h | 2 ++
>> 1 file changed, 2 insertions(+)
>> 
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index d374191..ef1ed5c 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -660,6 +660,8 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>> 
>> #define update_mmu_cache_pmd(vma, address, pmd) do { } while (0)
>> 
>> +#define	kc_vaddr_to_offset(v) ((v) & ((1UL << VA_BITS) - 1))
>> +#define	kc_offset_to_vaddr(o) ((o) | ~((1UL << VA_BITS) - 1))
> 
> I think it would be cleaner to define something like VIRTUAL_BASE, and
> then define the vmalloc area in terms of that as well as these kcore
> macros.
> 
> Will
