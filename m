From: john.stultz@linaro.org (John Stultz)
Date: Fri, 18 Jul 2014 17:14:26 -0700
Subject: [PATCH] sched_clock: Avoid corrupting hrtimer tree during suspend
In-Reply-To: <53C9ACCA.3070306@codeaurora.org>
References: <1405721392-30795-1-git-send-email-sboyd@codeaurora.org>
 <53C99EC5.2060602@linaro.org> <53C9A1EC.8060905@codeaurora.org>
 <53C9A2E7.8020307@linaro.org> <53C9ACCA.3070306@codeaurora.org>
Message-ID: <53C9B862.5050106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2014 04:24 PM, Stephen Boyd wrote:
> On 07/18/14 15:42, John Stultz wrote:
>> If its a regression (and needs -stable backports) it needs to go in via
>> tip/timers/urgent, and not via the regular merge window.
>>
>> Whats the additional risk -stable wise for canceling the timer during
>> suspend and starting it back up during resume?
>>
> I'd say close to zero given that we'd only be making the timer run a
> little bit later and we have slack in there already. Here's that version.

Ok, thanks. I'll try to do a closer review it and get it queued. Is
there anyone who might be able to validate this and provide a Tested-by: ?

thanks
-john
