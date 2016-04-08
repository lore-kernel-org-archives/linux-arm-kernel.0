From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 8 Apr 2016 12:00:10 +0100
Subject: [PATCH] arm64: erratum: Workaround for Kryo reserved system
 register read
In-Reply-To: <5707887E.3030406@arm.com>
References: <1460044456-5297-1-git-send-email-nkaje@codeaurora.org>
 <57069977.5050205@arm.com> <570780D2.3060104@arm.com>
 <570786C9.6020804@arm.com> <5707887E.3030406@arm.com>
Message-ID: <57078F3A.7020406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/16 11:31, Suzuki K Poulose wrote:
> On 08/04/16 11:24, Marc Zyngier wrote:
>> On 08/04/16 10:58, Suzuki K Poulose wrote:
>>> On 07/04/16 18:31, Marc Zyngier wrote:
>>>
>>>>> +	All system register encodings above use the form
>>>>> +
>>>>> +	Op0, Op1, CRn, CRm, Op2.
>>>>> +
>>>>> +	Note that some of the encodings listed above include
>>>>> +	the system register space reserved for the following
>>>>> +	identification registers which may appear in future revisions
>>>>> +	of the ARM architecture beyond ARMv8.0.
>>>>> +	This space includes:
>>>>> +	ID_AA64PFR[2-7]_EL1
>>>>> +	ID_AA64DFR[2-3]_EL1
>>>>> +	ID_AA64AFR[2-3]_EL1
>>>>> +	ID_AA64ISAR[2-7]_EL1
>>>>> +	ID_AA64MMFR[2-7]_EL1
>>>
>>>
>>> AFAIK, the id space is unassigned. So the naming above could cause confusion
>>> if the register is named something else.
>>
>> It is reserved *at the moment*, but already has a defined behaviour. My
> 
> Absolutely, they do need to be RAZ.  My point was assigning names to the reserved
> space where the names are unassigned.

Sorry - I misread your statement. It makes a lot more sense now that the
coffee has trickled in.

We're in violent agreement! ;-)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
