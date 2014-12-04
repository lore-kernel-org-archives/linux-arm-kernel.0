From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 04 Dec 2014 08:57:47 +0000
Subject: [PATCH 13/16] ARM: shmobile: remove use of
 gic_arch_extn.irq_set_wake
In-Reply-To: <20141204063909.GF19568@verge.net.au>
References: <1417539497-20101-1-git-send-email-marc.zyngier@arm.com>
 <1417539497-20101-14-git-send-email-marc.zyngier@arm.com>
 <20141204063909.GF19568@verge.net.au>
Message-ID: <5480220B.1020909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On 04/12/14 06:39, Simon Horman wrote:
> On Tue, Dec 02, 2014 at 04:58:14PM +0000, Marc Zyngier wrote:
>> shmobile only uses gic_arch_extn.irq_set_wake to prevent the GIC
>> from returning -ENXIO when receiving a wake-up configuration request.
>>
>> It is a lot simpler to tell the irq layer that we don't need any
>> configuration by using the IRQCHIP_SKIP_SET_WAKE, thanks to the
>> new gic_set_irqchip_flags function.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Hi Marc,
> 
> this looks reasonable to me. Should I take it through my tree
> (in v3.20) or did you have another path in mind?

As you can see, there is a dependency on the GIC itself, and other
platforms are affected to. So I'd think that an arm-soc branch
containing all the required patches would be more appropriate, assuming
that you're happy to Ack this patch.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
