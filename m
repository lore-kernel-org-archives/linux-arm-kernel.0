From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 10 Aug 2016 19:13:36 +0100
Subject: [PATCH v3 02/15] dt/bindings: Update binding for PM domain idle
 states
In-Reply-To: <5e59874c-bbb7-270a-199c-da1ff5932554@arm.com>
References: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
 <1470351902-43103-3-git-send-email-lina.iyer@linaro.org>
 <99e35b6c-6698-6d27-f4d7-fa032796869e@arm.com>
 <20160810164034.GA1401@linaro.org>
 <5e59874c-bbb7-270a-199c-da1ff5932554@arm.com>
Message-ID: <e6f3e751-3619-15c0-bf5f-070f90328e2c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/08/16 19:09, Sudeep Holla wrote:
>
>
> On 10/08/16 17:40, Lina Iyer wrote:
>> Hi Sudeep,
>>
>> On Wed, Aug 10 2016 at 09:15 -0600, Sudeep Holla wrote:
>>> Hi Lina,
>>>
>>> I have few concerns mainly due to the lack of description and not the
>>> binding per say.
>
> [...]
>
>>>> +- domain-idle-states : A phandle of an idle-state that shall be
>>>> soaked into a
>>>> +                generic domain power state. The idle state
>>>> definitions are
>>>> +                compatible with arm,idle-state specified in [1].
>>>> +
>>>
>>> So I assume these can be used for the genpd states. Either we rename
>>> it domain-power-states or make it clear that these domain-idle-states
>>> can also represent the power-states for normal devices.
>>>
>> These are the domains' idle states. These states are only used when the
>> domain goes into idle, not when the domain is active. These are not
>> power states that the domain can operate on either. Hence the idle-state
>> moniker.
>
> I am not sure if we can tell that the device is running in all it's
> power states. E.g. in ACPI IIUC, only D0 state represent running state,
> while D{1,2,3} are power states which consume less power than D0/running
> state. I think genpd is designed on those lines.
>

I didn't complete this section earlier.

Just to clarify we can label them as idle states or whatever. Strictly
speaking today even cpu-idle-states have power off state, so the term is
not important.

What I intended to say is that it should be able to describe even device
idle(power states minus the active running) states.

-- 
Regards,
Sudeep
