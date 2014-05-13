From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 13 May 2014 10:19:24 -0400
Subject: omap4-panda-es boot issues with v3.15-rc4
In-Reply-To: <5371D35A.2040506@ti.com>
References: <536B7E44.2040303@ti.com> <7hppjos2w2.fsf@paris.lan>
 <CAGa+x84VB3CXDm71JWxHx1-Qk1xVNeXdwUjZnb42_wg+piOzzA@mail.gmail.com>
 <20140508165558.GB2198@atomide.com> <20140508184055.GC2198@atomide.com>
 <7hha4zsyro.fsf@paris.lan> <536C9084.50209@ti.com> <7heh02ms82.fsf@paris.lan>
 <20140511155542.GD28266@atomide.com> <53713FCF.3000006@ti.com>
 <20140512220741.GG5668@atomide.com> <5371D35A.2040506@ti.com>
Message-ID: <537229EC.1050404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 May 2014 04:10 AM, Roger Quadros wrote:
> On 05/13/2014 01:07 AM, Tony Lindgren wrote:
>> * Santosh Shilimkar <santosh.shilimkar@ti.com> [140512 14:41]:
>>> On Sunday 11 May 2014 11:55 AM, Tony Lindgren wrote:
>>>> * Kevin Hilman <khilman@linaro.org> [140509 16:46]:
>>>>> Roger Quadros <rogerq@ti.com> writes:
>>>>>
>>>>>> Kevin,
>>>>>>
>>>>>> On 05/09/2014 01:15 AM, Kevin Hilman wrote:
>>>>>>> Tony Lindgren <tony@atomide.com> writes:
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>>> ..but I think I found the cause for recent hangs on panda, just a wild
>>>>>>>> guess based on looking at the recent cpuidle patches after v3.14.
>>>>>>>>
>>>>>>>> Looks like reverting 0b89e9aa2856 (cpuidle: delay enabling interrupts
>>>>>>>> until all coupled CPUs leave idle) makes booting work reliably again
>>>>>>>> on panda.
>>>>>>>>
>>>>>>>> Can you guys confirm, so far no issues here after few boot tests,
>>>>>>>> but it might be too early to tell.
>>>>>>>
>>>>>>> Reverting that makes things a bit more stable, but it still eventually
>>>>>>> fails in the same way.  For me it took 8 boots for it to eventually
>>>>>>> fail.
>>>>>>>
>>>>>>> However, if I build with CONFIG_CPU_IDLE=n, it becomes much more stable
>>>>>>> (20+ boots in a row and still going.)
>>>>>>>
>>>>>>
>>>>>> Can you please test with CPU_IDLE enabled but C3 disabled as in below patch?
>>>>>> It worked for me 10/10 boots.
>>>>>
>>>>> Yup, it worked for me too for 10/10 boots in a row.
>>>>
>>>> But what has caused this regression, does it work reliably with let's
>>>> say v3.13 or v3.12?
>>>>
>>> IIRC things were stable till some CPUIDLE code consolidation happened.
>>> I don't recall exactly but some one did discuss about it a while back.
>>
>> OK that's good to hear.
>>  
>>> Can you re-run your test-cases with patch at end of the email. This
>>> is just a hunch so don't blame me if I waste your time testing the
>>> patch.
>>
>> Seems to work after adding "#include <linux/clockchips.h>". I did about 10
>> reboots and they all succeeded for me. Without your revert, I'm getting
>> a hang (with sysrq not working) about 1/3 of the boots.
>>
>> Kevin, Roger, does the revert from Santosh work for you too?
>>
> 
> next-20140508 worked for me 10/10 times with Santosh's patch.
> The heartbeat LED behaves normally as well. So I like it :).
> 
Great. Will post the patch with change log updated and cc
you guys.

Regards,
Santosh
