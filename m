From: robherring2@gmail.com (Rob Herring)
Date: Thu, 21 Mar 2013 17:15:06 -0500
Subject: [PATCH 2/3] ARM: sched_clock: support 64-bit counters
In-Reply-To: <514B1311.20308@codeaurora.org>
References: <1363055197-17296-1-git-send-email-robherring2@gmail.com>
 <1363055197-17296-3-git-send-email-robherring2@gmail.com>
 <514B1311.20308@codeaurora.org>
Message-ID: <514B866A.3010308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2013 09:02 AM, Christopher Covington wrote:
> Hi Rob,
> 
> On 03/11/2013 10:26 PM, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> With architected timers, we now have 64-bit counters which can be used
>> directly for sched_clock. However, the ARM sched_clock code currently just
>> uses the lower 32-bits and handles wrapping in software. Add support for
>> using the full 64-bit counter values. If multiple counters are registered,
>> a 64-bit counter is preferred.
> 
> To be more precise, architected timers are anywhere between 56 and 64 bits
> wide, zero-extended to 64-bits. See section B8.1.1 of the ARM ARM rev C.b. I
> don't know if the code really needs to change until someone has a need to
> distinguish more finely between timers, but if you're using access size as an
> approximation for counter width, I feel like it at least deserves a mention in
> the comments.

Is there a defined way to determine the number of active bits?
setup_sched_clock could be generalized to take any sizes >32 - 64 bits,
but then we need some threshold as to when we need to worry about
wrapping or not.

Rob
