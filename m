From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 18 Jan 2017 13:06:50 +0000
Subject: [PATCH v3 6/9] kvm: arm/arm64: Add host pmu to support VM
 introspection
In-Reply-To: <1a6b8d71-58a5-b29b-3f01-e945deb2baf6@arm.com> (Marc Zyngier's
 message of "Wed, 18 Jan 2017 11:21:21 +0000")
References: <20170110113856.7183-1-punit.agrawal@arm.com>
 <20170110113856.7183-7-punit.agrawal@arm.com>
 <1a6b8d71-58a5-b29b-3f01-e945deb2baf6@arm.com>
Message-ID: <87k29sms9h.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Marc Zyngier <marc.zyngier@arm.com> writes:

> +Mark
>
> On 10/01/17 11:38, Punit Agrawal wrote:
>> Both AArch32 and AArch64 mode of the ARMv8 architecture support trapping
>> certain VM operations, e.g, TLB and cache maintenance
>> operations. Selective trapping of these operations for specific VMs can
>> be used to track the frequency with which these occur during execution.
>> 
>> Add a software PMU on the host that can support tracking VM
>> operations (in the form of PMU events). Supporting new events requires
>> providing callbacks to configure the VM to enable/disable the trapping
>> and read a count of the frequency.
>> 
>> The host PMU events can be controlled by tools like perf that use
>> standard kernel perf interfaces.
>> 
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>>  arch/arm/include/asm/kvm_host.h   |   8 ++
>>  arch/arm/kvm/arm.c                |   2 +
>>  arch/arm64/include/asm/kvm_host.h |   8 ++
>>  virt/kvm/arm/host_pmu.c           | 272 ++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 290 insertions(+)
>>  create mode 100644 virt/kvm/arm/host_pmu.c
>> 

[...]

>> 
>
> This patch really makes me think that there is nothing arm-specific in
> here at all. Why can't it be a generic feature through which
> architectures can expose events in a generic way (or as close as
> possible to being generic)?

I wasn't sure if other architectures are interested in the functionality
- that's the only reason. Having said that, it can be turned off in the
config so there shouldn't be any complaints.

I'll move this to virt/kvm in the next incarnation.

Thanks for taking a look.

>
> Thanks,
>
> 	M.
