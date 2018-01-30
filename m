From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Jan 2018 14:52:50 +0000
Subject: [PATCH v2 04/16] arm/arm64: KVM: Add PSCI_VERSION helper
In-Reply-To: <818aa8cd-9fa3-3234-297b-dea8540e1bb2@arm.com>
References: <20180129174559.1866-1-marc.zyngier@arm.com>
 <20180129174559.1866-5-marc.zyngier@arm.com>
 <818aa8cd-9fa3-3234-297b-dea8540e1bb2@arm.com>
Message-ID: <09b4dff2-4c8b-e9c5-a238-a10a9bce4f45@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/01/18 13:15, Robin Murphy wrote:
> On 29/01/18 17:45, Marc Zyngier wrote:
>> As we're about to trigger a PSCI version explosion, it doesn't
>> hurt to introduce a PSCI_VERSION helper that is going to be
>> used everywhere.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>   include/kvm/arm_psci.h | 5 +++--
>>   virt/kvm/arm/psci.c    | 2 +-
>>   2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
>> index 2042bb909474..3a408c846c09 100644
>> --- a/include/kvm/arm_psci.h
>> +++ b/include/kvm/arm_psci.h
>> @@ -18,8 +18,9 @@
>>   #ifndef __KVM_ARM_PSCI_H__
>>   #define __KVM_ARM_PSCI_H__
>>   
>> -#define KVM_ARM_PSCI_0_1	1
>> -#define KVM_ARM_PSCI_0_2	2
>> +#define PSCI_VERSION(x,y)	((((x) & 0x7fff) << 16) | ((y) & 0xffff))
> 
> I see virt/kvm/arm/psci.c already pulls in uapi/linux/psci.h, so maybe 
> this guy could go in there alongside the other PSCI_VERSION_* gubbins?

Good point. Moved.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
