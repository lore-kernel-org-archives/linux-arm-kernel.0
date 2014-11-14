From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 14 Nov 2014 02:31:23 +0100 (CET)
Subject: [Patch V1 0/6] Refine generic/PCI MSI irqodmian interfaces
In-Reply-To: <54655632.2040209@huawei.com>
References: <1415879029-20098-1-git-send-email-jiang.liu@linux.intel.com>
 <54651BE2.9080008@arm.com> <54654C10.2040102@linux.intel.com>
 <54655632.2040209@huawei.com>
Message-ID: <alpine.DEB.2.11.1411140211480.3935@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Nov 2014, Yijing Wang wrote:

Could you please use a mail client which does proper line wraps or
configure yours to do so?

> Associate the irq domain and PCI bus is not necessary, because all
> PCI buses under same host bridge always share same MSI chip/irq
> domain, we only need associate them and pci host bridge.
>
> I'm refactoring the pci_host_bridge, make it be a generic one, rip
> out of the pci root bus creation, so we could put the irq domain and
> pci domain etc.. in it. Finally, we could eliminate lots platform
> arch functions. I will post it out within one week.

That's a completely orthogonal problem. From the MSI/interrupt
handling POV it does not matter at all where that information is
stored. All we care about is that it is retrievable via the (pci)
device which tries to setup MSI[X].

So we can store/retrieve it via generic functions into/from whatever
is available right now. If the irq side has generic interfaces to do
so then this wont conflict with your decisions to change the final
storage point because all it takes is to tweak the storage/retrieve
functions.

So all we need at the moment is an agreed on way to store/retrieve
that information which is based on the current shared infrastructure,
aka. Linus tree. If we can utilize that you are completely free to
change the association mechanism underneath.

Thanks,

	tglx
