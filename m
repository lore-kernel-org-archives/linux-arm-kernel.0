From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 06 May 2015 17:32:53 +0200
Subject: [RFC v2 0/4] chip/vgic adaptations for forwarded irq
In-Reply-To: <20150506142748.GC6796@cbox>
References: <1423642857-24240-1-git-send-email-eric.auger@linaro.org>
 <20150506142748.GC6796@cbox>
Message-ID: <554A3425.7070909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2015 04:27 PM, Christoffer Dall wrote:
> Hi Eric,
> 
> On Wed, Feb 11, 2015 at 09:20:53AM +0100, Eric Auger wrote:
>> This series proposes some fixes that appeared to be necessary
>> to integrate IRQ forwarding in KVM/VFIO.
>>
>> - deactivation of the forwarded IRQ in irq_disabled case
>> - a specific handling of forwarded IRQ into the VGIC state machine.
>> - deactivation of physical IRQ and unforwarding on vgic destruction
>> - rb_tree lock in vgic.c
>>
>> Integrated pieces can be found at
>> ssh://git.linaro.org/people/eric.auger/linux.git
>> on branch irqfd_integ_v9
>>
> What are the dependencies for this at this point?
> 
> I assume it relies at least on the split EOI/priority drop changes?

Yes it now only depends on split EOI/priority drop changes since
"genirq: Saving/restoring the irqchip state of an irq line" now is
upstreamed.

> 
> Are you going to respin this when there are newer versions of the
> dependencies out, or what are the plans?

Yes I will respin according to new versions. I am currently using a
rebased version of Marc's original RFC "ARM: Forwarding physical
interrupts to a guest VM" (http://lwn.net/Articles/603514/) which is a
superset of [PATCH] genirq: Add support for priority-drop/deactivate
interrupt controllers.

- Eric
> 
> Thanks,
> -Christoffer
> 
