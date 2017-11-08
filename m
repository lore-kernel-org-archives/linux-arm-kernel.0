From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 8 Nov 2017 15:14:39 +0000
Subject: [PATCH v5 25/26] KVM: arm/arm64: GICv4: Enable VLPI support
In-Reply-To: <2d20a22e-214d-3835-7f61-29fc5e88413a@redhat.com>
References: <20171027142855.21584-1-marc.zyngier@arm.com>
 <20171027142855.21584-26-marc.zyngier@arm.com>
 <2d20a22e-214d-3835-7f61-29fc5e88413a@redhat.com>
Message-ID: <ba1b912b-e15b-1c76-f8e7-b9f7c5d6dc38@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/17 08:44, Auger Eric wrote:
> Hi Marc,
> 
> On 27/10/2017 16:28, Marc Zyngier wrote:
>> All it takes is the has_v4 flag to be set in gic_kvm_info
>> as well as "kvm-arm.vgic_v4_enable=1" being passed on the
>> command line for GICv4 to be enabled in KVM.
> 
> What did you motivate your choice of having an enable option instead of
> a disable option?

Currently, SW MSI injection works really well. It's been validated,
plenty of people are using it. On the other hand, GICv4 is new and
probably buggy. I only know of 2 other people having tried it. I'm also
not sure it gives the best possible performance in the general use case
(oversubscribed host with freely migrating vcpus).

Given that, I'm not keen on making it the default. But if you can report
that it is better and more reliable than SW injection, I'll switch the
default the other way around! ;-)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
