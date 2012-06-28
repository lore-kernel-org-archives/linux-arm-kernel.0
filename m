From: frankyl@broadcom.com (Franky Lin)
Date: Wed, 27 Jun 2012 17:41:56 -0700
Subject: Panda ES board hang when using GPIO as interrupt
In-Reply-To: <87txxxs9we.fsf@ti.com>
References: <4FE8CF77.5080400@broadcom.com> <87txxxs9we.fsf@ti.com>
Message-ID: <4FEBA854.5010508@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2012 08:37 PM, Kevin Hilman wrote:
> "Franky Lin" <frankyl@broadcom.com> writes:
>> I noticed Kevin raised some similar cases on other platforms and also
>> provided two patches in the patch mail thread. But unfortunately those
>> two patches doesn't help in our case. I tested the driver with 3.5-rc3
>> mainline kernel and the issue is still there. I can only "fix" the
>> hang by either reverting the commit or disabling
>> CONFIG_PM_RUNTIME. Also, the hang only happens on Panda ES board. Old
>> Panda with 4430 works good.
>>
>> Any thoughts and suggestions?
>
> If reverting the patch fixes your problem, can you isolate down to which
> part of that patch causes the problem?  IOW, can you fix your problem if
> you undo just the hunk added in runtime_suspend or undo just the moved
> hunk runtime_resume?  Or is reverting both required?
>
> I suspect the added runtime_suspend hunk is causing the problems, so can
> you see if just undoing that part works[1].  If that works, I will give
> a bit more of a thinking on it tomorrow.

runtime_suspend hunk is fine. The hang still exist after reverting it. 
The culprit is the moved hunk in runtime_resume. Reverting it makes the 
hang disappear.

>
> Thanks for reporting the problem!   Bug reports like this that have
> clearly been thoroughly researched and bisected are greatly appreciated!
>
> Kevin
>

You are welcome.

Regards,
Franky
