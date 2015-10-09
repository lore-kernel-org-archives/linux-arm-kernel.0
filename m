From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 09 Oct 2015 09:06:42 +0100
Subject: [PATCH] KVM: arm/arm64: Add VGICv3 save/restore API documentation
In-Reply-To: <00e601d10264$61cdafb0$25690f10$@samsung.com>
References: <1444247430-14808-1-git-send-email-christoffer.dall@linaro.org>
 <00e601d10264$61cdafb0$25690f10$@samsung.com>
Message-ID: <56177592.2080702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/15 08:30, Pavel Fedin wrote:
>  Hello!
> 
>> +  KVM_DEV_ARM_VGIC_CPU_SYSREGS
>> +  Attributes:
>> +    The attr field of kvm_device_attr encodes two values:
>> +    bits:     | 63      ....       32 | 31  ....  16 | 15  ....  0 |
>> +    values:   |         mpidr         |      RES     |    instr    |
> 
>  One small clarification: do you really want it to be different from KVM_DEV_ARM_VGIC_GRP_CPU_REGS?

One is memory mapped, the other one is a system register. One is
addressed by a linear index, the other one by affinity.

How do you reconcile the two? What's the point of trying to shoehorn a
different concept into the existing API?

	M.
-- 
Jazz is not dead. It just smells funny...
