From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 29 Jan 2013 10:20:06 +0100
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130129094143.1aad9377@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <5106F9F9.3010905@wwwdotorg.org> <20130129094143.1aad9377@skate>
Message-ID: <20130129092006.GA16377@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 09:41:43AM +0100, Thomas Petazzoni wrote:
> On Mon, 28 Jan 2013 15:21:45 -0700, Stephen Warren wrote:
[...]
> > > +static int mvebu_pcie_init(void)
> > > +{
> > > +	return platform_driver_probe(&mvebu_pcie_driver,
> > > +				     mvebu_pcie_probe);
> > > +}
> > > +
> > > +subsys_initcall(mvebu_pcie_init);
> > 
> > Why isn't that just platform_driver_register()?
> 
> I didn't test recently, but with my first version of the patch set,
> having an initialization as late as module_init() was too late. Some
> PCI fixup code was being executed *before* we get the opportunity of
> initializing the PCI driver, and it was crashing the kernel. I can
> provide more details if you want.

Does this patch perhaps fix this crash?

	http://patchwork.ozlabs.org/patch/210870/

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130129/579b43da/attachment.sig>
