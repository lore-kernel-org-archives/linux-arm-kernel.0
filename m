From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Tue, 11 Aug 2015 19:30:42 +0300
Subject: [PATCH v5 2/6] x86/kasan, mm: introduce generic
 kasan_populate_zero_shadow()
In-Reply-To: <20150811154117.GH23307@e104818-lin.cambridge.arm.com>
References: <1439259499-13913-1-git-send-email-ryabinin.a.a@gmail.com>
 <1439259499-13913-3-git-send-email-ryabinin.a.a@gmail.com>
 <20150811154117.GH23307@e104818-lin.cambridge.arm.com>
Message-ID: <55CA2332.7040206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/11/2015 06:41 PM, Catalin Marinas wrote:
> On Tue, Aug 11, 2015 at 05:18:15AM +0300, Andrey Ryabinin wrote:
>> --- /dev/null
>> +++ b/mm/kasan/kasan_init.c
> [...]
>> +#if CONFIG_PGTABLE_LEVELS > 3
>> +pud_t kasan_zero_pud[PTRS_PER_PUD] __page_aligned_bss;
>> +#endif
>> +#if CONFIG_PGTABLE_LEVELS > 2
>> +pmd_t kasan_zero_pmd[PTRS_PER_PMD] __page_aligned_bss;
>> +#endif
>> +pte_t kasan_zero_pte[PTRS_PER_PTE] __page_aligned_bss;
> 
> Is there any problem if you don't add the #ifs here? Wouldn't the linker
> remove them if they are not used?
> 

AFAIK such optimization is possible if we build with -fdata-sections flag and
use --gc-sections flag in linker, but we don't do this.
