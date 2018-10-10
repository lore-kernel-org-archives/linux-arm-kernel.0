From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 10 Oct 2018 12:22:40 +0800
Subject: [PATCH v2 2/2] arm/arm64: KVM: enable 32 bits kvm vcpu events
 support
In-Reply-To: <3e6a7a5f-3ff9-b7db-b1f6-87a8fdf5c20c@arm.com>
References: <1539002088-21215-1-git-send-email-gengdongjiu@huawei.com>
 <1539002088-21215-3-git-send-email-gengdongjiu@huawei.com>
 <3e6a7a5f-3ff9-b7db-b1f6-87a8fdf5c20c@arm.com>
Message-ID: <f733b63b-b949-9082-3b23-aba47774d734@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki

On 2018/10/10 1:22, Suzuki K Poulose wrote:
> 
> 
> On 08/10/18 13:34, Dongjiu Geng wrote:
>> The commit 539aee0edb9f ("KVM: arm64: Share the parts of
>> get/set events useful to 32bit") shares the get/set events
>> helper for arm64 and arm32, it is better also share the check
>> for vcpu events capability to enable 32 bit kvm vcpu events
>> support.
>>
>> User space will check whether KVM supports vcpu events through
>> KVM_CAP_VCPU_EVENTS IOCTL.
> 
> nit: User space will check whether KVM supports vcpu events by checking
> the KVM_CAP_VCPU_EVENTS extension.

  Thanks for the pointing out, I will update it.

> 
>>
>> Cc: James Morse <james.morse@arm.com>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> 
> Reviewed-by : Suzuki K Poulose <suzuki.poulose@arm.com>
> 
>> ---
>> For the 32 bits kvm migration, it needs to enable the vcpu events,
>> this patch will enable it. The user space QEMU patch is here:
>> https://patchwork.ozlabs.org/patch/975615/
>> ---
>> ? arch/arm64/kvm/reset.c | 1 -
>> ? virt/kvm/arm/arm.c???? | 1 +
>> ? 2 files changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index fd37c53..e50245e 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -82,7 +82,6 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>> ????????? break;
>> ????? case KVM_CAP_SET_GUEST_DEBUG:
>> ????? case KVM_CAP_VCPU_ATTRIBUTES:
>> -??? case KVM_CAP_VCPU_EVENTS:
>> ????????? r = 1;
>> ????????? break;
>> ????? default:
>> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
>> index 40e79ea..64e5d97 100644
>> --- a/virt/kvm/arm/arm.c
>> +++ b/virt/kvm/arm/arm.c
>> @@ -212,6 +212,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>> ????? case KVM_CAP_READONLY_MEM:
>> ????? case KVM_CAP_MP_STATE:
>> ????? case KVM_CAP_IMMEDIATE_EXIT:
>> +??? case KVM_CAP_VCPU_EVENTS:
>> ????????? r = 1;
>> ????????? break;
>> ????? case KVM_CAP_ARM_SET_DEVICE_ADDR:
>>
> 
> .
> 
