From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Mar 2015 18:17:29 +0000
Subject: [PATCH] arm64: dts: Fix GIC reg sizes for APM X-Gene
In-Reply-To: <CAL85gmDVfop1_roHyLTRzFY3BahzTWs7nwbpmZD7emFKcFHyLg@mail.gmail.com>
References: <1422342206-4750-1-git-send-email-psawargaonkar@apm.com>	<550056FD.8060804@arm.com>	<CAL85gmCuB4LfNp+6B8cL9+emFqWPM6W9gevTzibyaAzL+7jVdg@mail.gmail.com>	<55007BE3.30300@arm.com>
 <CAL85gmDVfop1_roHyLTRzFY3BahzTWs7nwbpmZD7emFKcFHyLg@mail.gmail.com>
Message-ID: <550086B9.4010001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/15 17:57, Feng Kan wrote:
> On Wed, Mar 11, 2015 at 10:31 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 11/03/15 17:19, Feng Kan wrote:
>>> On Wed, Mar 11, 2015 at 7:53 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>> On 27/01/15 07:03, Pranavkumar Sawargaonkar wrote:
>>>>> In APM X-Gene, GIC register space is 64K aligned while the sizes mentioned
>>>>> in the dt are 4K aligned. This breaks KVM when kernel is built with 64K page
>>>>> size due to size alignment checking in vgic driver for VCPU Control and
>>>>> VCPU register.
>>>>>
>>>>> This patch corrects the sizes to be inline with the hardware spec.
>>>>
>>>> This patch may be correct, but it is useless. The firmware on my APM
>>>> system (some version of u-boot) repaints the DT at boot time, negating
>>>> the effect of this patch.
>>> We have updated u-boot to reflect this change. I can supply you with a updated
>>> image if you wish.
>>
>> That would be useful, thanks.
>>
>> But more importantly, why bother upstreaming your DT into the kernel
>> tree if your firmware is going to overwrite whatever we provide?
> We did tried to submit a version upstream but was rejected.
> 
>>
>> Either the firmware let the user provide its own DT (and doesn't touch
>> it other than to change the CPU enable method, insert a /memreserve/ or
>> similar things), or the firmware always provide its own DT, and doesn't
>> let the user provide its own. Corrupting the user DT is a disaster, as
>> we just found.
> Yes, the intent of the change is listed in the link below. It is not a
> justification by any means,
> just the effects of things appearing in layers.
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/288574.html

Yeah. This is as wrong as it can possibly be. Oh well...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
