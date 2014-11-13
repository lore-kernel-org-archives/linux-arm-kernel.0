From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 13 Nov 2014 21:28:30 +0000
Subject: [Patch V1 0/6] Refine generic/PCI MSI irqodmian interfaces
In-Reply-To: <alpine.DEB.2.11.1411132207470.3935@nanos>
References: <1415879029-20098-1-git-send-email-jiang.liu@linux.intel.com>
 <54651BE2.9080008@arm.com> <alpine.DEB.2.11.1411132207470.3935@nanos>
Message-ID: <5465227E.6000309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/14 21:11, Thomas Gleixner wrote:
> On Thu, 13 Nov 2014, Marc Zyngier wrote:
>> With the new stacked irq domains, it becomes pretty tempting
>> to allocate an MSI domain per PCI bus, which would remove
>> the requirement of either relying on arch-specific code, or
>> a default PCI MSI domain.
> 
> Right. That's what I roughly had in mind. And that would solve the
> multi-iommu issue on x86 nicely as well. We establish the association
> at the time where the bus gets populated. So the whole lookup magic
> simply goes away.

Great. I've pushed the whole thing out with this patch, the couple
of fixes I mentioned earlier, as well as the whole ITS code:

git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/stacked-its-v2

Time to go home.

	M.
-- 
Jazz is not dead. It just smells funny...
