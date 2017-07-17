From: panand@redhat.com (Pratyush Anand)
Date: Mon, 17 Jul 2017 19:30:54 +0530
Subject: [PATCH] arm64: perf: Allow more than one cycle counter to be used
In-Reply-To: <20170717131635.GK26488@arm.com>
References: <5817e4915963d7fae5928a77d85f7e0c4dca290c.1498890614.git.panand@redhat.com>
 <32b8658a-e48d-308d-4c89-9d22161ec1a8@redhat.com>
 <20170717131635.GK26488@arm.com>
Message-ID: <a1d63d7e-a902-7017-c08c-87aa18a0af70@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 17 July 2017 06:46 PM, Will Deacon wrote:
> On Mon, Jul 17, 2017 at 08:56:10AM +0530, Pratyush Anand wrote:
>> On Saturday 01 July 2017 12:03 PM, Pratyush Anand wrote:
>>> Currently:
>>> $ perf stat -e cycles:u -e cycles:k  true
>>>
>>> Performance counter stats for 'true':
>>>
>>>          2,24,699      cycles:u
>>>     <not counted>      cycles:k	(0.00%)
>>>
>>>       0.000788087 seconds time elapsed
>>>
>>> We can not count more than one cycle counter in one instance,because we
>>> allow to map cycle counter into PMCCNTR_EL0 only. However, if I did not
>>> miss anything then specification do not prohibit to use PMEVCNTR<n>_EL0
>>> for cycle count as well.
>>>
>>> Modify the code so that it still prefers to use PMCCNTR_EL0 for cycle
>>> counter, however allow to use PMEVCNTR<n>_EL0 if PMCCNTR_EL0 is already
>>> in use.
>>>
>>> After this patch:
>>>
>>> $ perf stat -e cycles:u -e cycles:k   true
>>>
>>> Performance counter stats for 'true':
>>>
>>>          2,17,310      cycles:u
>>>          7,40,009      cycles:k
>>>
>>>       0.000764149 seconds time elapsed
>>>
>>
>> Any comment/feedback?
>
> I'll pick this one up.
>

Thanks Will.

-- 
Pratyush
