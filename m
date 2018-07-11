From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Jul 2018 08:45:11 +0100
Subject: [PATCH v7 1/4] arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
In-Reply-To: <b0eb95f3-7905-8aab-f816-529c17f07e04@huawei.com>
References: <20180710164952.23736-1-james.morse@arm.com>
 <20180710164952.23736-2-james.morse@arm.com>
 <b0eb95f3-7905-8aab-f816-529c17f07e04@huawei.com>
Message-ID: <1cbb0f3f-1bc4-5205-d28c-1843d09a702e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/18 07:48, gengdongjiu wrote:
> Hi, James,
> 
> [...]
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> index d10944e619d3..e3940f8715a5 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -835,11 +835,13 @@ struct kvm_clock_data {
>>  
>>  Capability: KVM_CAP_VCPU_EVENTS
>>  Extended by: KVM_CAP_INTR_SHADOW
>> -Architectures: x86
>> -Type: vm ioctl
>> +Architectures: x86, arm64
> 
>    In my previous patch, I only add the arm64 support, now you add patches to support arm32 platform,
>    so you can add "ARM" to the Architectures, for example: "Architectures: x86, ARM, arm64"

That should be the job of the last patch, shouldn't it? At this point in
the series, there is no 32bit support whatsoever.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
