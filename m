From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Sep 2014 15:57:35 +0200
Subject: [PATCH 2/2] PCI: Layerscape: Add Layerscape PCIe driver
In-Reply-To: <3055252.byHHPbPjpA@wuerfel>
References: <1409856338-1730-1-git-send-email-Minghuan.Lian@freescale.com>
 <2799937.bNtU9KXR6t@wuerfel> <3055252.byHHPbPjpA@wuerfel>
Message-ID: <7601888.KPBqiDOLoa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 September 2014 15:51:22 Arnd Bergmann wrote:
> On Thursday 04 September 2014 14:14:48 Arnd Bergmann wrote:
> > 
> > My impression is that you have two distinct MSI controller
> > implementations, one for LS1021A and the other one for everything
> > else. How about using separate pcie_host_ops for them, possibly
> > also moving them into separate files?
> > 
> 
> One more thing: you should really use the msi-parent property to
> find the MSI controller: Sooner or later this PCI block is likely
> to end up in a real product that has GICv2m or GICv3 support, so
> you will have to pick which of the two MSI controllers to use.

Ah, I missed the fact that LS1021A is a real product already, I was
confusing it with the LS2085A patches that are also on the list
at the moment and that only work in a simulator at present.

Note that LS2085A does have GICv3. I don't know if it has a similar
PCIe implementation, but if it does, the DT representation should
definitely provide a way to pick the MSI controller (you will always
want the GIC in practice).

	Arnd
