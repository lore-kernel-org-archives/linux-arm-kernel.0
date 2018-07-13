From: james.morse@arm.com (James Morse)
Date: Fri, 13 Jul 2018 16:27:37 +0100
Subject: [PATCH v7 3/4] KVM: arm64: Share the parts of get/set events
 useful to 32bit
In-Reply-To: <b392c9e1-d0e4-9674-a223-351b381db76c@huawei.com>
References: <20180710164952.23736-1-james.morse@arm.com>
 <20180710164952.23736-4-james.morse@arm.com>
 <b392c9e1-d0e4-9674-a223-351b381db76c@huawei.com>
Message-ID: <77fa3cb5-ef9c-962a-0d0c-b7cac19c1ce7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi gengdongjiu,

On 11/07/18 08:16, gengdongjiu wrote:
> On 2018/7/11 0:49, James Morse wrote:
>> The get/set events helpers to do some work to check reserved
>> and padding fields are zero. This is useful on 32bit too.
>>
>> Move this code into virt/kvm/arm/arm.c, and give the arch
>> code some underscores.
>>
>> This is temporarily hidden behind __KVM_HAVE_VCPU_EVENTS until
>> 32bit is wired up.

>> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
>> index a94eab71e5c7..f70d24e1751d 100644
>> --- a/virt/kvm/arm/arm.c
>> +++ b/virt/kvm/arm/arm.c
>> @@ -1044,6 +1044,34 @@ static int kvm_arm_vcpu_has_attr(struct kvm_vcpu *vcpu,

>> +#ifdef __KVM_HAVE_VCPU_EVENTS	/* temporary: until 32bit is wired up */

[..]

>> +#endif /* __KVM_HAVE_VCPU_EVENTS */

> In [PATCH v7 4/4] KVM: arm: Add 32bit get/set events support, I see you> remove "__KVM_HAVE_VCPU_EVENTS" in kvm_arch_vcpu_ioctl()
> but here it adds, it looks like strange.
> so maybe it is better keep it in both place, or remove them both.
> 
> From the comments /* temporary: until 32bit is wired up */, do you forget
> to remove the __KVM_HAVE_VCPU_EVENTS	after wiring up the 32bit?

Indeed I did, the 'temporary' note was meant to remind me!
(and I forgot about the documentation too)


Thanks!

James
