From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Fri, 30 Nov 2012 21:19:16 -0500
Subject: [PATCH v4 03/13] ARM: KVM: Initial VGIC infrastructure support
In-Reply-To: <20121128124955.GE21671@mudshark.cambridge.arm.com>
References: <20121110154358.3061.16338.stgit@chazy-air>
 <20121110154437.3061.76180.stgit@chazy-air>
 <20121128124955.GE21671@mudshark.cambridge.arm.com>
Message-ID: <CANM98qLNrfuVKdAsUDQM5Dd77Z+1En8ZDqqnaSE4kOCS0vE8ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index 2fb7319..665af96 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -1880,12 +1880,13 @@ static long kvm_vcpu_ioctl(struct file *filp,
>>       if (vcpu->kvm->mm != current->mm)
>>               return -EIO;
>>
>> -#if defined(CONFIG_S390) || defined(CONFIG_PPC)
>> +#if defined(CONFIG_S390) || defined(CONFIG_PPC) || defined(CONFIG_ARM)
>>       /*
>>        * Special cases: vcpu ioctls that are asynchronous to vcpu execution,
>>        * so vcpu_load() would break it.
>>        */
>> -     if (ioctl == KVM_S390_INTERRUPT || ioctl == KVM_INTERRUPT)
>> +     if (ioctl == KVM_S390_INTERRUPT || ioctl == KVM_INTERRUPT ||
>> +         ioctl == KVM_IRQ_LINE)
>>               return kvm_arch_vcpu_ioctl(filp, ioctl, arg);
>>  #endif
>
> Separate patch?
>
KVM_IRQ_LINE is a VM ioctl, not a vcpu ioctl, so this is leftover from
the duplicate VCPU/VM same ioctl mess.

It's gone!

-Christoffer
