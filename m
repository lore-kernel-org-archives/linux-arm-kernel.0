From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 13 Nov 2014 22:11:26 +0100 (CET)
Subject: [Patch V1 0/6] Refine generic/PCI MSI irqodmian interfaces
In-Reply-To: <54651BE2.9080008@arm.com>
References: <1415879029-20098-1-git-send-email-jiang.liu@linux.intel.com>
 <54651BE2.9080008@arm.com>
Message-ID: <alpine.DEB.2.11.1411132207470.3935@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Nov 2014, Marc Zyngier wrote:
> With the new stacked irq domains, it becomes pretty tempting
> to allocate an MSI domain per PCI bus, which would remove
> the requirement of either relying on arch-specific code, or
> a default PCI MSI domain.

Right. That's what I roughly had in mind. And that would solve the
multi-iommu issue on x86 nicely as well. We establish the association
at the time where the bus gets populated. So the whole lookup magic
simply goes away.

Thanks,

	tglx

 
