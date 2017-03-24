From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Fri, 24 Mar 2017 10:36:16 -0600
Subject: [PATCH] arm64: kconfig: allow support for memory failure handling
In-Reply-To: <1dc99ff7-65ac-4858-6008-8ee8d0f6f336@arm.com>
References: <1485985115-27274-1-git-send-email-tbaicar@codeaurora.org>
 <58D3DCA1.5090006@arm.com> <1dc99ff7-65ac-4858-6008-8ee8d0f6f336@arm.com>
Message-ID: <c76008af-4061-f44c-5643-77070406364e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/23/2017 10:12 AM, Punit Agrawal wrote:
>
>
> On 23/03/17 14:33, James Morse wrote:
>> Hi Punit,
>>
>> On 01/02/17 21:38, Tyler Baicar wrote:
>>> From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
>>>
>>> If ACPI_APEI and MEMORY_FAILURE is configured, select
>>> ACPI_APEI_MEMORY_FAILURE. This enables memory failure recovery
>>> when such memory failure is reported through ACPI APEI. APEI
>>> (ACPI Platform Error Interfaces) provides a means for the
>>> platform to convey error information to the kernel.
>>>
>>> Declare ARCH_SUPPORTS_MEMORY_FAILURE, as arm64 does support
>>> memory failure recovery attempt.
>>
>> Am I right in thinking we should wait for the hugepage issue you 
>> found with
>> hwpoison [0] to be fixed before arm64 can have 
>> ARCH_SUPPORTS_MEMORY_FAILURE?
>
> We should at the least fix the huge_pte_offset() issue discovered in [0]
> before we enable memory failure handling. Earlier today I posted a
> RFC[1] fix for it based on Catalin's suggestion.
>
>>
>> (If so, can this patch become part of that series to they are 
>> obviously related!)
>
> Good point - I can include the patches enabling memory failure handling
> on ARM64 if Tyler's fine with it.
That's fine with me!

Thanks,
Tyler
>
> Thanks,
> Punit
>
> [1] https://lkml.org/lkml/2017/3/23/293
>
>>
>> Thanks,
>>
>> James
>>
>> [0] https://www.spinics.net/lists/arm-kernel/msg568995.html
>>
>>
>>
>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index f92778d..4cd12a0 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -15,6 +15,8 @@ config ARM64
>>>      select ARCH_HAS_SG_CHAIN
>>>      select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>>>      select ARCH_USE_CMPXCHG_LOCKREF
>>> +    select ACPI_APEI_MEMORY_FAILURE if ACPI_APEI && MEMORY_FAILURE
>>> +    select ARCH_SUPPORTS_MEMORY_FAILURE
>>>      select ARCH_SUPPORTS_ATOMIC_RMW
>>>      select ARCH_SUPPORTS_NUMA_BALANCING
>>>      select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
>>>
>>
>>
>>
> IMPORTANT NOTICE: The contents of this email and any attachments are 
> confidential and may also be privileged. If you are not the intended 
> recipient, please notify the sender immediately and do not disclose 
> the contents to any other person, use it for any purpose, or store or 
> copy the information in any medium. Thank you.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
