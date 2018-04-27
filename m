From: cpandya@codeaurora.org (Chintan Pandya)
Date: Fri, 27 Apr 2018 19:12:57 +0530
Subject: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
In-Reply-To: <20180427124828.GW15462@8bytes.org>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-3-toshi.kani@hpe.com>
 <20180426141926.GN15462@8bytes.org> <1524759629.2693.465.camel@hpe.com>
 <20180426172327.GQ15462@8bytes.org> <1524764948.2693.478.camel@hpe.com>
 <20180426200737.GS15462@8bytes.org> <1524781764.2693.503.camel@hpe.com>
 <20180427073719.GT15462@8bytes.org>
 <5b237058-6617-6af3-8499-8836d95f538d@codeaurora.org>
 <20180427124828.GW15462@8bytes.org>
Message-ID: <fb4771ca-694b-8a52-d239-1c730617600b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 4/27/2018 6:18 PM, joro at 8bytes.org wrote:
> On Fri, Apr 27, 2018 at 05:22:28PM +0530, Chintan Pandya wrote:
>> I'm bit confused here. Are you pointing to race within ioremap/vmalloc
>> framework while updating the page table or race during tlb ops. Since
>> later is arch dependent, I would not comment. But if the race being
>> discussed here while altering page tables, I'm not on the same page.
> 
> The race condition is between hardware and software. It is not
> sufficient to just remove the software references to the page that is
> about to be freed (by clearing the PMD/PUD), also the hardware
> references in the page-walk cache need to be removed with a TLB flush.
> Otherwise the hardware can use the freed (and possibly reused) page to
> establish new TLB entries.

Sure ! This is my understanding too (from arm64 context).

> 
> 
> 
> 	Joerg
> 
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
