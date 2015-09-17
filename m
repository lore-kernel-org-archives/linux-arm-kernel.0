From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Thu, 17 Sep 2015 14:47:30 +0800
Subject: [PATCH v2 00/22] KVM: ARM64: Add guest PMU support
In-Reply-To: <55FA5626.7040105@redhat.com>
References: <1441961715-11688-1-git-send-email-zhaoshenglong@huawei.com>
 <55F9D9FC.6010905@redhat.com> <55FA1832.3040008@linaro.org>
 <55FA5626.7040105@redhat.com>
Message-ID: <55FA6202.5090906@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei,

On 2015/9/17 13:56, Wei Huang wrote:
> 
> 
> On 09/16/2015 08:32 PM, Shannon Zhao wrote:
>> Hi Wei,
>>
>> On 2015/9/17 5:07, Wei Huang wrote:
>>> I am testing this series. 
>> Thanks for your time and help.
>>
>>> The first question is: do you plan to add ACPI
>>> support in QEMU?
> 
> I saw "KVM_{SET/GET}_DEVICE_ATTR failed: Invalid argument" while using
> your QEMU tree (PMU_v2 branch). A quick debugging:
> 
>From this log, it might fail at below check:
+               if (reg < VGIC_NR_SGIS || reg > dev->kvm->arch.vgic.nr_irqs)
+                       return -EINVAL;

> (1) dmesg on host kernel didn't show any vPMU initialization errors. So
> I suspect the problem is related to QEMU.
> (2) Commit 58771bc2a78 worked fine. So probably the problem was
> introduced by new PMU code.
> 
> Have you seen it before?
> 

Oh, I didn't see this. And I checkout the code on git.linaro.org, it's
same with my local code.

Could you add some print in kvm_arm_pmu_set_irq of hw/misc/arm_pmu_kvm.c
and kvm_arm_pmu_set_attr, kvm_arm_pmu_set_irq of virt/kvm/arm/pmu.c.

Thanks,

-- 
Shannon
