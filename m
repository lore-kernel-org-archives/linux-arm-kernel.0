From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 2 Jul 2018 14:31:13 +0100
Subject: [PATCH v3 15/20] kvm: arm/arm64: Allow tuning the physical
 address size for VM
In-Reply-To: <f7715da8-73ea-28fb-9883-8d0c048e0792@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-16-git-send-email-suzuki.poulose@arm.com>
 <f7715da8-73ea-28fb-9883-8d0c048e0792@arm.com>
Message-ID: <8392ecb1-50ce-c448-54f7-bf3021ae508b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/18 14:13, Marc Zyngier wrote:
> On 29/06/18 12:15, Suzuki K Poulose wrote:
>> Allow specifying the physical address size for a new VM via
>> the kvm_type argument for KVM_CREATE_VM ioctl. This allows
>> us to finalise the stage2 page table format as early as possible
>> and hence perform the right checks on the memory slots without
>> complication. The size is encoded as Log2(PA_Size) in the bits[7:0]
>> of the type field and can encode more information in the future if
>> required. The IPA size is still capped at 40bits.
> 
> Can't we relax this? There is no technical reason (AFAICS) not to allow
> going down to 36bit IPA if the user has requested it.

Sure, we can.

> 
> If we run on a 36bit IPA system, the default would fail. But if the user
> specified "please give me a 36bit IPA VM", we could satisfy that
> requirement and allow them to run their stupidly small guest!

Absolutely. I will fix this in the next version.

Cheers
Suzuki
