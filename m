From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 8 Sep 2015 00:42:47 +0900
Subject: [RFC PATCH 0/3] Implement IRQ stack on ARM64
In-Reply-To: <55EDA040.90208@arm.com>
References: <1441376587-12979-1-git-send-email-jungseoklee85@gmail.com>
 <55EDA040.90208@arm.com>
Message-ID: <AFDD2C50-682E-4A66-89FB-BD32108D9298@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sep 7, 2015, at 11:33 PM, James Morse wrote:
> On 04/09/15 15:23, Jungseok Lee wrote:
>> ARM64 kernel allocates 16KB kernel stack when creating a process. In case
>> of low memory platforms with tough workloads on userland, this order-2
>> allocation request reaches to memory pressure and performance degradation
>> simultaenously since VM page allocator falls into slowpath frequently,
>> which triggers page reclaim and compaction.
>> 
>> I believe that one of the best solutions is to reduce kernel stack size.
>> According to the following data from stack tracer with some fixes, [1],
>> a separate IRQ stack would greatly help to decrease a kernel stack depth.
>> 
> 
> Hi Jungseok Lee,

Hi James Morse,

> I was working on a similar patch for irq stack, (patch as a follow up email).
> 
> I suggest we work together on a single implementation. I think the only
> major difference is that you're using sp_el0 as a temporary register to
> store a copy of the stack-pointer to find struct thread_info, whereas I was
> copying it between stacks (ends up as 2x ldp/stps), which keeps the change
> restricted to irq_stack setup code.
> 
> We should get some feedback as to which approach is preferred.

Great idea!
I'd really like to figure out the most ideal implementation of this feature.

Best Regards
Jungseok Lee
