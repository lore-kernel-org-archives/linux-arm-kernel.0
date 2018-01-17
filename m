From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 17 Jan 2018 12:27:27 +0000
Subject: [PATCH 1/3] arm64: perf: Make PMU interrupt NMI safe
In-Reply-To: <20180117122014.GM2228@hirez.programming.kicks-ass.net>
References: <1516190685-20048-1-git-send-email-julien.thierry@arm.com>
 <1516190685-20048-2-git-send-email-julien.thierry@arm.com>
 <20180117122014.GM2228@hirez.programming.kicks-ass.net>
Message-ID: <000372ce-8739-14ed-c403-1651c5c1501d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/01/18 12:20, Peter Zijlstra wrote:
> On Wed, Jan 17, 2018 at 12:04:43PM +0000, Julien Thierry wrote:
>> Before using an NMI, we must make sure the IRQ handler uses no locks and
>> only calls NMI safe functions.
>>
>> Get rid of PMU lock, saving and restoring the PMU counter selector in the
>> PMU interrupt handler
> 
> You fail to explain why its safe to do so. Presumably that lock was
> there for a reason, why can you remove it and expect things to keep
> working?
> 

Right, this was poorly worded. The lock was there to prevent the PMU 
interrupt modifying the counter selector register while the interrupted 
context was using it.

So the lock was not simply removed, but replaced with the saving and 
restoring the selector register value in the interrupt handler.

I'll reword that when I submit a new iteration of that series.

Thanks,

-- 
Julien Thierry
