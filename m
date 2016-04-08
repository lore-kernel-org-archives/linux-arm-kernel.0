From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 8 Apr 2016 15:39:53 +0100
Subject: [PATCH 07/17] kvm-arm: arm32: Introduce stage2 page table helpers
In-Reply-To: <20160408124332.GL8961@cbox>
References: <1459787177-12767-1-git-send-email-suzuki.poulose@arm.com>
 <1459787177-12767-8-git-send-email-suzuki.poulose@arm.com>
 <20160408124332.GL8961@cbox>
Message-ID: <5707C2B9.1020000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/16 13:43, Christoffer Dall wrote:
> On Mon, Apr 04, 2016 at 05:26:07PM +0100, Suzuki K Poulose wrote:
>> Define the page table helpers for walking the stage2 pagetable
>> for arm. Since both hyp and stage2 have the same number of levels,
>> as that of the host we reuse the host helpers.
>>
>> The exceptions are the p.d_addr_end routines which have to deal
>> with IPA > 32bit, hence we use the open coded version of their host helpers
>> which supports 64bit.
>>


>> +#ifndef __ARM_S2_PGTABLE_H_
>> +#define __ARM_S2_PGTABLE_H_
>> +
>> +#define stage2_pgd_none(pgd)				pgd_none(pgd)
>> +#define stage2_pgd_clear(pgd)				pgd_clear(pgd)
>> +#define stage2_pgd_present(pgd)				pgd_present(pgd)
>> +#define stage2_pgd_populate(mm, pgd, pud)		pgd_populate(mm, pgd, pud)
>> +#define stage2_pud_offset(pgd, address)			pud_offset(pgd, address)
>> +#define stage2_pud_free(mm, pud)			pud_free(mm, pud)
>> +
>> +#define stage2_pud_none(pud)				pud_none(pud)
>> +#define stage2_pud_clear(pud)				pud_clear(pud)
>> +#define stage2_pud_present(pud)				pud_present(pud)
>> +#define stage2_pud_populate(mm, pud, pmd)		pud_populate(mm, pud, pmd)
>> +#define stage2_pmd_offset(pud, address)			pmd_offset(pud, address)
>> +#define stage2_pmd_free(mm, pmd)			pmd_free(mm, pmd)
>> +
>> +#define stage2_pud_huge(pud)				pud_huge(pud)
>
> could we get rid of the mm parameter to all these stage2_ versions above
> and simply implement them with the generic functions passing NULL in the
> definitions instead?

We could, I retained it just to match the corresponding host version. Will change
it in the next version.

>
> Otherwise:
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>


Thanks
Suzuki
