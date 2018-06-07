From: cpandya@codeaurora.org (Chintan Pandya)
Date: Thu, 7 Jun 2018 13:33:20 +0530
Subject: [PATCH v13 0/3] Fix issues with huge mapping in ioremap for ARM64
In-Reply-To: <20180606154520.GM6631@arm.com>
References: <1528268481-19299-1-git-send-email-cpandya@codeaurora.org>
 <20180606154520.GM6631@arm.com>
Message-ID: <6aaf3db7-3cbb-f4ba-7983-f235e3bad92e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 6/6/2018 9:15 PM, Will Deacon wrote:
> Hi Chintan,
Hi Will,

> 
> Thanks for sticking with this. I've reviewed the series now and I'm keen
> for it to land in mainline. Just a couple of things below.
> 

Thanks for all the reviews so far.

> On Wed, Jun 06, 2018 at 12:31:18PM +0530, Chintan Pandya wrote:
>> This series of patches re-bring huge vmap back for arm64.

...

>> These patches can also go into '-stable' branch (if accepted)
>> for 4.6 onwards.
> 
> Not sure we need to target -stable, since we solved the crash by disabling
> the use of huge io mappings.

If disabling of huge io mappings have gone into stable trees, then I
won't push for these changes there.

> 
>>   arch/arm64/include/asm/tlbflush.h |  7 ++++++
>>   arch/arm64/mm/mmu.c               | 48 +++++++++++++++++++++++++++++++++++----
>>   arch/x86/mm/pgtable.c             |  8 ++++---
>>   include/asm-generic/pgtable.h     |  8 +++----
>>   lib/ioremap.c                     |  4 ++--
> 
> If you get an ack from the x86 folks, then I could take all of this via
> arm64. Alternatively, now that I've reviewed the series this could happily
> go via another tree (e.g. akpm).

Sure. I would wait for few days before either of them take notice of
this. If required, I will communicated with them.

> 
> Thanks,
> 
> Will
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
