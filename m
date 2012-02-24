From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Feb 2012 17:37:57 +0000
Subject: [PATCH] msm: timer: Support sched_clock()
In-Reply-To: <4F47C9AA.5060806@codeaurora.org>
References: <1329874777-12758-1-git-send-email-sboyd@codeaurora.org>
 <20120222215533.GA31480@codeaurora.org> <4F476242.2020909@arm.com>
 <20120224170901.GA9312@codeaurora.org> <4F47C7C5.4090806@arm.com>
 <4F47C9AA.5060806@codeaurora.org>
Message-ID: <4F47CAF5.4000709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/02/12 17:32, Stephen Boyd wrote:
> Hi Marc,
> 
> On 02/24/12 09:24, Marc Zyngier wrote:
>> On 24/02/12 17:09, David Brown wrote:
>>> I'll keep an eye on it then, and push it into the ARM soc tree when
>>> the dependencies are there.
>> The whole thing is that there's no dependency. The sched_clock() stuff
>> has hit mainline during the merge window. This patch could go in right
>> now, without any harm.
>>
>> What Russell pulled is just a cleanup to convert the last two platforms
>> having their own sched_clock() and not relying on our framework.
>>
>>
> 
> This patch relies on the fact that the HAVE_SCHED_CLOCK config option no
> longer exists. We could push it in if the patch had that option added to
> the Kconfig, but then it would conflict with the removal of the Kconfig
> by 6905a65 (ARM: Make the sched_clock framework mandatory, 2012-01-18).

Ah! Indeed, you're perfectly right.

> So I guess we send it through the arm-soc tree?

I don't think arm-soc tracks rmk/for-next, so this has to go via
Russell's tree. I'll take the patch and send Russell another pull
request then.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
