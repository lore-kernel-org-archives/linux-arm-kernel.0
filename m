From: cpandya@codeaurora.org (Chintan Pandya)
Date: Mon, 30 Apr 2018 13:00:59 +0530
Subject: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
In-Reply-To: <1524948829.2693.547.camel@hpe.com>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-3-toshi.kani@hpe.com>
 <20180426141926.GN15462@8bytes.org> <1524759629.2693.465.camel@hpe.com>
 <20180426172327.GQ15462@8bytes.org> <1524764948.2693.478.camel@hpe.com>
 <20180426200737.GS15462@8bytes.org> <1524781764.2693.503.camel@hpe.com>
 <20180427073719.GT15462@8bytes.org> <1524839460.2693.531.camel@hpe.com>
 <20180428090217.n2l3w4vobmtkvz6k@8bytes.org>
 <1524948829.2693.547.camel@hpe.com>
Message-ID: <c8c5e78a-2cb2-ca46-6521-928b6c0114c6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 4/29/2018 2:24 AM, Kani, Toshi wrote:
> On Sat, 2018-04-28 at 11:02 +0200, joro at 8bytes.org wrote:
>> On Fri, Apr 27, 2018 at 02:31:51PM +0000, Kani, Toshi wrote:
>>> So, we can add the step 2 on top of this patch.
>>>   1. Clear pud/pmd entry.
>>>   2. System wide TLB flush <-- TO BE ADDED BY NEW PATCH
>>>   3. Free its underlining pmd/pte page.
>>
>> This still lacks the page-table synchronization and will thus not fix
>> the BUG_ON being triggered.
> 
> The BUG_ON issue is specific to PAE that it syncs at the pmd level.
> x86/64 does not have this issue since it syncs at the pgd or p4d level.
> 
>>> We do not need to revert this patch.  We can make the above change I
>>> mentioned.
>>
>> Please note that we are not in the merge window anymore and that any fix
>> needs to be simple and obviously correct.
> 
> Understood.  Changing the x86/32 sync point is risky.  So, I am going to
> revert the free page handling for PAE.

Will this affect pmd_free_pte_page() & pud_free_pmd_page() 's existence
or its parameters ? I'm asking because, I've similar change for arm64
and ready to send v9 patches.

I'm thinking to share my v9 patches in any case. If you are going to do
TLB invalidation within these APIs, my first patch will help.

> 
> Thanks,
> -Toshi
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
