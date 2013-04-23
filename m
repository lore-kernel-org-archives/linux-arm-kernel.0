From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 23 Apr 2013 09:34:50 -0700
Subject: [PATCH 0/4] ARM 64 bit sched_clock take #2
In-Reply-To: <5175A1B8.1090202@gmail.com>
References: <51709FD7.8050408@gmail.com>
 <1366417746-24990-1-git-send-email-sboyd@codeaurora.org>
 <51756CB6.5060607@linaro.org> <5175A1B8.1090202@gmail.com>
Message-ID: <5176B82A.9070003@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/13 13:46, Rob Herring wrote:
> On 04/22/2013 12:00 PM, John Stultz wrote:
>> On 04/19/2013 05:29 PM, Stephen Boyd wrote:
>>> This is what I was thinking. I don't see why we can't move this to
>>> generic code and have arm64 use it too. Those patches will follow once
>>> I find an arm64
>>> compiler.
>> I think moving this to generic code sounds like a good idea. You could
>> probably also prototype and test the 64bit code with x86_64, using the
>> TSC counter.
> I agree this should all be common, but I'd like to see the common
> version first. That is not going to make it for 3.10. For 3.10, the
> immediate need is to fix suspend and initial time for the arch timer. I
> think this should be fixed locally in arch timer code for 3.10. The
> alternative is to revert linux-next commit 023796b9be3a77481cd5 (ARM:
> arch_timer: use full 64-bit counter for sched_clock) which will cause
> the arch timer to not be used as sched_clock if another higher frequency
> sched_clock is registered.

This would make sense to me if we were already in the 3.10-rc1 or rc2
phase, but this code isn't even in Linus' tree yet. Why can't we just
fix it properly before sending off to Linus? Obviously this is up to the
maintainers to decide, so if we can't fix it properly with this patch
series I propose we revert like you say.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
