From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sun, 13 Jan 2013 10:58:06 +0100
Subject: [PATCH 10/14] PCI: tegra: Move PCIe driver to drivers/pci/host
In-Reply-To: <201301122112.25772.arnd@arndb.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <20130111154516.GA25335@avionic-0098.adnet.avionic-design.de>
 <20130112123640.GA22505@avionic-0098.adnet.avionic-design.de>
 <201301122112.25772.arnd@arndb.de>
Message-ID: <20130113095806.GA31966@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 12, 2013 at 09:12:25PM +0000, Arnd Bergmann wrote:
> On Saturday 12 January 2013, Thierry Reding wrote:
> > > I already hinted at that in one of the other subthreads. Having such a
> > > multiplex would also allow the driver to be built as a module. I had
> > > already thought about this when I was working on an earlier version of
> > > these patches. Basically these would be two ops attached to the host
> > > bridge, and the generic arch_setup_msi_irq() could then look that up
> > > given the struct pci_dev that is passed to it and call this new per-
> > > host bridge .setup_msi_irq().
> > 
> > struct pci_ops looks like a good place to put these. They'll be
> > available from each struct pci_bus, so should be easy to call from
> > arch_setup_msi_irq().
> > 
> > Any objections?
> > 
> 
> struct pci_ops has a long history of being specifically about
> config space read/write operations, so on the one hand it does
> not feel like the right place to put interrupt specific operations,
> but on the other hand, the name sounds appropriate and I cannot
> think of any other place to put this, so it's fine with me.
> 
> The only alternative I can think of is to introduce a new
> structure next to it in struct pci_bus, but that feels a bit
> pointless. Maybe Bjorn has a preference one way or the other.

The name pci_ops is certainly generic enough. Also the comment above the
structure declaration says "Low-level architecture-dependent routines",
which applies to the MSI functions as well.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130113/5c4fb437/attachment.sig>
