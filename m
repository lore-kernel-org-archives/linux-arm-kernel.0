From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 1 Feb 2017 10:08:01 +0000
Subject: [RFC v2 05/10] KVM: arm/arm64: Initialize the emulated EL1
 physical timer
In-Reply-To: <20170130190450.GF16459@cbox>
References: <1485479100-4966-1-git-send-email-jintack@cs.columbia.edu>
 <1485479100-4966-6-git-send-email-jintack@cs.columbia.edu>
 <86wpde83xn.fsf@arm.com> <20170130145816.GC16459@cbox>
 <57b57b31-b8ad-f5c8-a1fc-4cde9a564dd2@arm.com> <20170130190450.GF16459@cbox>
Message-ID: <619cc856-b268-df3b-d064-e511fa54afe0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/01/17 19:04, Christoffer Dall wrote:
> On Mon, Jan 30, 2017 at 05:44:20PM +0000, Marc Zyngier wrote:

>> Wventually, we'll have to support an offset-able
>> physical counter to support nested virtualization, but this can come at
>> a later time.
>>
> Why do we need the offset-able physical counter for nested
> virtualization?  I would think for nested virt we just need to support
> respecting how the guest hypervisor programs CNTVOFF?

Ah, I see what you mean. Yes, once the guest hypervisor is in control of
its own CNTVOFF, we get everything we need. So let's just ignore this
for the time being, and we should be pretty good for this series.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
