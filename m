From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 15 Jan 2013 22:14:41 +0100
Subject: [PATCH 10/14] PCI: tegra: Move PCIe driver to drivers/pci/host
In-Reply-To: <20130115154038.GA11241@arm.com>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <20130114095706.GA23467@arm.com>
 <20130115120855.GA5637@avionic-0098.adnet.avionic-design.de>
 <201301151244.12767.arnd@arndb.de> <20130115154038.GA11241@arm.com>
Message-ID: <20130115211441.GA13139@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 03:40:38PM +0000, Andrew Murray wrote:
> On Tue, Jan 15, 2013 at 12:44:12PM +0000, Arnd Bergmann wrote:
> > On Tuesday 15 January 2013, Thierry Reding wrote:
> > > I'm not sure I follow you're reasoning here. Is it possible to use MSIs
> > > without PCI? If not then I think there's little sense in keeping the
> > > implementations separate.
> > 
> > Conceptually, you can use MSI for any device, but the Linux interfaces
> > for MSI are tied to PCI. If you use an MSI controller for a non-PCI
> > device, it would probably just appear as a regular interrupt controller.
> > 
> > > Furthermore, if MSI controller and PCI host bridge are separate entities
> > > how do you look up the MSI controller given a PCI device?
> > 
> > The host bridge can contain a pointer ot the MSI controller. You can
> > have multiple host bridges sharing a single MSI controller or you
> > can have separate ones for each host.
> 
> Yes and I hoped this relationship would be described by a device tree phandle
> as is done for relating devices to their interrupt-parent (where device trees
> are used). This would provide (arguably unnecessarily) greater flexibility,
> e.g. if you have two PCI/MSI controller pairs, the MSIs only offer limited MSIs
> and you only use one PCI fabric - you could service different parts of the
> fabric by different MSI controllers (assuming you relate MSI controllers to
> part of the fabric and that you'd want to). Perhaps there would be benefits for
> virtualisation as well?

Is there actually hardware that supports this? I assumed that the MSI
controller would have to be tightly coupled to the PCI host bridge in
order to raise an interrupt when an MSI is received via PCI.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130115/dc83e7be/attachment-0001.sig>
