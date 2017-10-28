From: gengdongjiu@huawei.com (gengdongjiu)
Date: Sat, 28 Oct 2017 13:22:36 +0800
Subject: [PATCH v2] KVM: arm/arm64: Fix external abort type matching
In-Reply-To: <86a80ca1in.fsf@arm.com>
References: <0184EA26B2509940AA629AE1405DD7F2016E999C@DGGEMA503-MBS.china.huawei.com>
 <86a80ca1in.fsf@arm.com>
Message-ID: <756c3914-232a-4cb7-d614-a96146185c99@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2017/10/28 2:28, Marc Zyngier wrote:
>> kvm_vcpu_trap_get_fault_type() will clear the low two bits to zero. So
>> I use FSC_SEA_TTW represent "Synchronous external abort on translation
>> table walk"
> I understand that, and I certainly not keen on adding another "fault
> type" for this.
 Ok,  thanks.

> 
>> As we can see the Translation fault type "FSC_FAULT", which does not
>> define the "FSC_FAULT0" "FSC_FAULT1" "FSC_FAULT2" "FSC_FAULT3".
>> Because the fault type " FSC_FAULT " include the four cases. 
> Indeed, and I'm still not convinced this is the best thing we have in
> the code.
Ok, thanks.


> 
>> static inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
>> {
>> 	return kvm_vcpu_get_hsr(vcpu) & 0x3f;
>> }
> Here you go. This should give you a pretty good idea of how to provide a
> proper fix.
OK, got it, thanks

> 
> Thanks,
