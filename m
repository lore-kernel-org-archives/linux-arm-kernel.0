From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 15 Aug 2016 17:14:02 +0100
Subject: [PATCH v3 02/15] dt/bindings: Update binding for PM domain idle
 states
In-Reply-To: <20160815160857.GE1401@linaro.org>
References: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
 <1470351902-43103-3-git-send-email-lina.iyer@linaro.org>
 <99e35b6c-6698-6d27-f4d7-fa032796869e@arm.com>
 <20160810164034.GA1401@linaro.org>
 <5e59874c-bbb7-270a-199c-da1ff5932554@arm.com>
 <20160811211023.GC1401@linaro.org>
 <697d8ac2-34ee-db3e-940b-5ce3365c5aa1@arm.com>
 <20160815160857.GE1401@linaro.org>
Message-ID: <2033f384-7ea3-6713-4def-80bf4251fd67@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15/08/16 17:08, Lina Iyer wrote:
> On Fri, Aug 12 2016 at 04:08 -0600, Sudeep Holla wrote:
>>
>>
>> On 11/08/16 22:10, Lina Iyer wrote:
>>> On Wed, Aug 10 2016 at 12:09 -0600, Sudeep Holla wrote:
>>>>
>>
>> [...]
>>
>>>> cluster0
>>>>    CLUSTER_RET(Retention)
>>>>    CLUSTER_PG(Power Gate)
>>>>    core0
>>>>        CORE_RET
>>>>        CORE_PG
>>>>    core1
>>>>        CORE_RET
>>>>        CORE_PG
>>>>
>>>> cluster1
>>>>    CLUSTER_RET
>>>>    CLUSTER_PG
>>>>    core0
>>>>        CORE_RET
>>>>        CORE_PG
>>>>    core1
>>>>        CORE_RET
>>>>        CORE_PG
>>>>
>>>> Platform Co-ordinate supports the following states and we should be
>>>> able to determine that from the binding:
>>>>
>>>> CORE_RET
>>>> CORE_PG
>>>> CORE_RET + CLUSTER_RET
>>>
>>> The problem that we have to sove here is knowing that CORE_RET +
>>> CLUSTER_PG (hypothetically) an invalid combination. Kevin and
>>> I debated it in the earlier RFC and we dont have a good way to solve
>>> this generically for all devices.
>>>
>>
>> Yes, I agree it's complex. But that needs to be solved IMO.
>>
>> I can think of 2 possible solutions:
>>
>> 1. Index the states(which people have not liked, but as along as we
>>   don't use it in the code as it for any other purpose, it should be
>>   fine) and then have each state mentioning what parent state can be
>>   entered at this child state(i.e. starting index and all states below
>>   it)
>>
> This is how QCOM solved it downstream.
>

Yes even ACPI has indices to solve this.

>> 2. Something similar to (1) but without index instead phandles.
>>
>
> The problem is when you have non-CPU devices in the device tree and
> since they do not have a way to represent states like CPU, we did not
> have a clear path to that. Hence we punted that to later. Whatever we
> do, we should solve it for a generic PM domain, not just CPU domains.
>

Yes bindings defined here should be applicable for devices to, but only
CPU's will have this hierarchy while the devices need not bother about
hierarchy. However the parent power domain can ever the state which is
least common denominator of all it's children power domain. That's my
understanding. No ?

-- 
Regards,
Sudeep
