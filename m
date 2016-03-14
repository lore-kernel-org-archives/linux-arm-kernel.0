From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 14 Mar 2016 17:22:29 +0000
Subject: [RFC PATCH 04/12] kvm-arm: Rename kvm_pmd_huge to huge_pmd
In-Reply-To: <20160314170602.GD5920@leverpostej>
References: <1457974391-28456-1-git-send-email-suzuki.poulose@arm.com>
 <1457974391-28456-5-git-send-email-suzuki.poulose@arm.com>
 <20160314170602.GD5920@leverpostej>
Message-ID: <56E6F355.5050804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/03/16 17:06, Mark Rutland wrote:
> On Mon, Mar 14, 2016 at 04:53:03PM +0000, Suzuki K Poulose wrote:
>> kvm_pmd_huge doesn't have any dependency on the page table
>> where the pmd lives (i.e, hyp vs. stage2). So, rename it to
>> huge_pmd() to make it explicit.


>>   #define hyp_pgd_order get_order(PTRS_PER_PGD * sizeof(pgd_t))
>>
>> -#define kvm_pmd_huge(_x)	(pmd_huge(_x) || pmd_trans_huge(_x))
>> +#define huge_pmd(_x)		(pmd_huge(_x) || pmd_trans_huge(_x))
>
> I note that in arch/arm we have pmd_thp_or_huge() for this in
> arch/arm/include/asm/pgtable-{2,3}level.h.
>
> If we're going to rename this, it's probably best to align on that name,
> which will also avoid and confusion as to the difference between
> pmd_huge and huge_pmd.
>
> Similarly, it might best live in pgtable.h if it isn't KVM-specific.

Thanks for that pointer, will define one for arm64 and use that in kvm.

Cheers
Suzuki
