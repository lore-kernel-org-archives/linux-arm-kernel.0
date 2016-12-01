From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 1 Dec 2016 12:57:53 +0000
Subject: [PATCH] KVM: arm/arm64: vgic: Don't notify EOI for non-SPIs
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA81747812F@lhreml504-mbs>
References: <1480584341-32340-1-git-send-email-marc.zyngier@arm.com>
 <1480584341-32340-2-git-send-email-marc.zyngier@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA817475F7E@lhreml504-mbs>
 <be0586f4-57b7-b732-f97e-34798f57e066@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA81747812F@lhreml504-mbs>
Message-ID: <0c69099a-06b4-cf84-9578-138350c0d5ba@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/16 12:15, Shameerali Kolothum Thodi wrote:

>> For these interrupts, which are purely virtual, there is absolutely
>> nothing to do at the physical distributor level anyway. Furthermore,
>> kvm_notify_acked_irq doesn't know about per-cpu interrupt, which is why
>> we cannot notify them.
> 
> Just to confirm, that means for any phys interrupt(PPI/SPI) to be injected
> to the Guest, the mapping bit has(HW bit set) to be used.

Yup.

	M.
-- 
Jazz is not dead. It just smells funny...
