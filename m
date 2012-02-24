From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Feb 2012 17:24:21 +0000
Subject: [PATCH] msm: timer: Support sched_clock()
In-Reply-To: <20120224170901.GA9312@codeaurora.org>
References: <1329874777-12758-1-git-send-email-sboyd@codeaurora.org>
 <20120222215533.GA31480@codeaurora.org> <4F476242.2020909@arm.com>
 <20120224170901.GA9312@codeaurora.org>
Message-ID: <4F47C7C5.4090806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/02/12 17:09, David Brown wrote:
> On Fri, Feb 24, 2012 at 10:11:14AM +0000, Marc Zyngier wrote:
>> On 22/02/12 21:55, David Brown wrote:
>>> On Tue, Feb 21, 2012 at 05:39:37PM -0800, Stephen Boyd wrote:
>>>> Now that sched_clock is mandatory on ARM it's simple to add
>>>> sched_clock support to the MSM timer code. Add it so that we get
>>>> more accurate sched_clock output than the jiffies based version
>>>> that's provided by default.
>>>>
>>>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>> Cc: David Brown <davidb@codeaurora.org>
>>>
>>> Marc, are you able to pull this into your series, so they can all go
>>> in together?  If so:
>>>
>>>   Acked-by: David Brown <davidb@codeaurora.org>
>>
>> David, Stephen,
>>
>> Russell already pulled my sched_clock() patch series, so I'm not sure it
>> is actually useful for me to carry it (and there is actually no
>> dependency between this patch and the series). Maybe putting it in the
>> patch system or via armsoc would be best?
>>
>> Otherwise:
>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> I'll keep an eye on it then, and push it into the ARM soc tree when
> the dependencies are there.

The whole thing is that there's no dependency. The sched_clock() stuff
has hit mainline during the merge window. This patch could go in right
now, without any harm.

What Russell pulled is just a cleanup to convert the last two platforms
having their own sched_clock() and not relying on our framework.

	M.
-- 
Jazz is not dead. It just smells funny...
