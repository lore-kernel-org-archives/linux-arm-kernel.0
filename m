From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 01 Jul 2015 09:26:59 +0100
Subject: [PATCH 10/10] KVM: arm/arm64: vgic: Allow non-shared device HW
 interrupts
In-Reply-To: <20150630201903.GX11332@cbox>
References: <1433783045-8002-1-git-send-email-marc.zyngier@arm.com>
 <1433783045-8002-11-git-send-email-marc.zyngier@arm.com>
 <20150630201903.GX11332@cbox>
Message-ID: <5593A453.4090903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/06/15 21:19, Christoffer Dall wrote:
> On Mon, Jun 08, 2015 at 06:04:05PM +0100, Marc Zyngier wrote:
>> So far, the only use of the HW interrupt facility is the timer,
>> implying that the active state is context-switched for each vcpu,
>> as the device is is shared across all vcpus.
>>
>> This does not work for a device that has been assigned to a VM,
>> as the guest is entierely in control of that device (the HW is
>> not shared). In that case, it makes sense to bypass the whole
>> active state switchint, and only track the deactivation of the
>> interrupt.
>>
> The discinction here between shared and non-shared feels a bit arbitrary
> (it may not be, but just feel that way) and I can't easily convince
> myself that this is the logical/correct/all-encompassing word to
> describe the nature of the two devices.

Does the idea of global vs private resource feel more correct?

	M.
-- 
Jazz is not dead. It just smells funny...
