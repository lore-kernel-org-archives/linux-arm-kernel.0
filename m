From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 5 Jan 2012 11:45:47 +0100
Subject: [PATCH v2 00/15] Make SMP timers standalone
In-Reply-To: <4F057C7C.6050509@arm.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
 <20111222193216.GO2577@n2100.arm.linux.org.uk> <4F048EC4.40900@arm.com>
 <20120104214748.GH11810@n2100.arm.linux.org.uk> <4F057C7C.6050509@arm.com>
Message-ID: <CAMQu2gzDX2RLTeEbSnexTCSfhDrKdcAN0e2-VOZyHfTdoRh04g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 5, 2012 at 11:33 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 04/01/12 21:47, Russell King - ARM Linux wrote:
>> On Wed, Jan 04, 2012 at 05:39:16PM +0000, Marc Zyngier wrote:
>>> On 22/12/11 19:32, Russell King - ARM Linux wrote:
>>>> You're also aware I assume that local timers are different from the global
>>>> timer itself, and require to have additional callbacks for broadcasting
>>>> the global timer tick?
>>>
>>> I was under the impression that we either have the global timer together
>>> with broadcasting or the local timers. Completely removing the broadcast
>>> callback doesn't seem to generate any ill effect as long as the local
>>> timers are used instead of the global timer (which of course requires
>>> broadcast in the SMP configuration).
>>
>> I believe even if you have local timers, there are situations where the
>> these will be disabled and the kernel will switch to broadcasting from a
>> global timer tick. ?I think such a scenario would be like that encountered
>> with OMAP, where suspending a CPU stops its TWD - meaning that the TWD
>> can't be used to wake the CPU from one of the deeper idle states.
>
> Yes, being able to wake up is definitely a good reason to keep a global
> timer around, not to mention other artifacts (TWD calibration being one,
> though on its way out thanks to LinusW patch series).
>
Catching up bit late on this tread.
I just want to echo the fact that we always need the wakeup capable
clock-event till the local timers themselves can wakup the CPU
from low power states.

Regards
Santosh
