From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Fri, 14 Nov 2014 08:25:52 +0800
Subject: [Patch V1 0/6] Refine generic/PCI MSI irqodmian interfaces
In-Reply-To: <54651BE2.9080008@arm.com>
References: <1415879029-20098-1-git-send-email-jiang.liu@linux.intel.com>
 <54651BE2.9080008@arm.com>
Message-ID: <54654C10.2040102@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/11/14 5:00, Marc Zyngier wrote:
> On 13/11/14 11:43, Jiang Liu wrote:
>> This patch set is based on tip/irq/irqdomain and tries to refine
>> interfaces to support irqdomain for generic MSI and PCI MSI.
>>
>> With this patch set applied, the generic MSI and PCI MSI interfaces
>> are much easier to use. For extreme case, you only need to define
>> a "struct msi_domain_info" and don't need to implement any callbacks,
>> just using the default callbacks is OK:)
>>
>> This patch set is also a preparation for:
>> 1) Kill all weak functions in drivers/pci/msi.c
>> 2) Implement support for non-PCI-compliant MSI device
> 
> I've rebased (once more!) the GICv3 ITS driver on top of this, and this
> is definitely a major improvement. This is basically the first version
> I can use without having to hack into the core code (apart from the
> couple of nits I've mentioned earlier).
Sorry for the rebasing, but I hope it worthy rebasing:)

> 
> Now, Thomas' idea of putting the irq_domain close to the bus is very
> appealing, and I've tweaked an earlier patch in order to do this:
I feel that's the right direction. There are other threads discussing
associating an MSI controller structure with each PCI bus (at least
root bus).
http://www.spinics.net/lists/arm-kernel/msg376328.html
Regards!
Gerry
