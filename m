From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Nov 2014 10:11:02 +0000
Subject: Removal of bus->msi assignment breaks MSI with stacked domains
In-Reply-To: <546E93DC.8010902@huawei.com>
References: <546E1771.4030201@arm.com> <546E93DC.8010902@huawei.com>
Message-ID: <546F0FB6.3050404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/11/14 01:22, Yijing Wang wrote:
> On 2014/11/21 0:31, Marc Zyngier wrote:
>> Bjorn, Yijing,
>>
>> I've just realized that patch c167caf8d174 (PCI/MSI: Remove useless
>> bus->msi assignment) completely breaks MSI on arm64 when using the new
>> MSI stacked domain:
> 
> Sorry, this is my first part to refactor MSI related code, now
> how to get pci msi_controller depends arch functions(pcibios_msi_controller() or
> arch_setup_msi_irq()), we are working on generic pci_host_bridge, after that,
> we could eventually eliminate MSI arch functions and find pci dev 's msi controller
> by pci_host_bridge->get_msi_controller().
> 
> Marc, could you tell me what pci host driver in your test platform ?

I'm using pci-host-generic (with a couple of patches to help it fit the
new "generic pci" infrastructure).

This lives at:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
irq/arm64-pci

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
