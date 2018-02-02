From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 2 Feb 2018 11:43:49 +0800
Subject: [PATCH v2 16/16] arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP
 hardening support
In-Reply-To: <8183e28a-39e7-e4f0-d704-35a0beb14ef0@arm.com>
References: <20180129174559.1866-1-marc.zyngier@arm.com>
 <20180129174559.1866-17-marc.zyngier@arm.com>
 <476d111e-6fb0-9bef-2448-a94d0cc03f45@huawei.com>
 <49853e5e-f093-2e79-1cfb-182f51fcd6a0@arm.com>
 <CAKv+Gu-XidYPh0hi1nzG5m0AO7EfRE6bnKfxCToG+9zsmvzmNg@mail.gmail.com>
 <CAKv+Gu-L0WOLSUbcHSTQ_FVDNSJoXQv25ExUmtv8ZEYhkCSQ-Q@mail.gmail.com>
 <501451b6-cc84-e8d3-b7b6-49a7de953976@arm.com>
 <f6579ab5-8d52-3f62-e538-515b28376d59@huawei.com>
 <8183e28a-39e7-e4f0-d704-35a0beb14ef0@arm.com>
Message-ID: <7e62d00e-df3b-1fb8-8e5e-83e1cf0e86bf@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/2/1 16:53, Marc Zyngier wrote:
[...]
>>>> ... and actually, perhaps it makes sense for the
>>>> SMCCC_ARCH_WORKAROUND_1 check to be completely independent of MIDR
>>>> based errata matching?
>>>>
>>>> I.e., if SMCCC v1.1 and SMCCC_ARCH_WORKAROUND_1 are both implemented,
>>>> we should probably invoke it even if the MIDR is not known to belong
>>>> to an affected implementation.
>>>
>>> This would have an impact on big-little systems, for which there is
>>> often a bunch of unaffected CPUs.
>>
>> I think it's what we are doing now, SMCCC v1.1 didn't provide the ability
>> to report per-cpu SMCCC_ARCH_WORKAROUND_1, and it said:
>>  - The discovery call must return the same result on all PEs in the system.
>>  - In heterogeneous systems with some PEs that require mitigation and others
>>    that do not, the firmware must provide a safe implementation of this
>>    function on all PEs.
>>
>> So from the spec that it's the firmware to take care of unaffected CPUs,
>> to the kernel it's the same.
> 
> The spec makes it safe. The MIDR list makes it fast.

Got it, thank you for clarifying this.

Thanks
Hanjun
