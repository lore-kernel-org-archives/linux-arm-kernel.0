From: robherring2@gmail.com (Rob Herring)
Date: Mon, 22 Apr 2013 15:46:48 -0500
Subject: [PATCH 0/4] ARM 64 bit sched_clock take #2
In-Reply-To: <51756CB6.5060607@linaro.org>
References: <51709FD7.8050408@gmail.com>
 <1366417746-24990-1-git-send-email-sboyd@codeaurora.org>
 <51756CB6.5060607@linaro.org>
Message-ID: <5175A1B8.1090202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2013 12:00 PM, John Stultz wrote:
> On 04/19/2013 05:29 PM, Stephen Boyd wrote:
>> This is what I was thinking. I don't see why we can't move this to
>> generic code and have arm64 use it too. Those patches will follow once
>> I find an arm64
>> compiler.
> 
> I think moving this to generic code sounds like a good idea. You could
> probably also prototype and test the 64bit code with x86_64, using the
> TSC counter.

I agree this should all be common, but I'd like to see the common
version first. That is not going to make it for 3.10. For 3.10, the
immediate need is to fix suspend and initial time for the arch timer. I
think this should be fixed locally in arch timer code for 3.10. The
alternative is to revert linux-next commit 023796b9be3a77481cd5 (ARM:
arch_timer: use full 64-bit counter for sched_clock) which will cause
the arch timer to not be used as sched_clock if another higher frequency
sched_clock is registered.

Rob
