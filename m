From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 6 Nov 2013 13:23:18 +0100
Subject: address translation for PCIe-to-localbus bridge
In-Reply-To: <527A1983.6020603@keymile.com>
References: <527A1983.6020603@keymile.com>
Message-ID: <20131106122317.GA8806@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 11:27:15AM +0100, Gerlando Falauto wrote:
> Hi everyone,
> 
> I am currently trying to describe an external device within a device
> tree in a Kirkwood design.
> Such device is accessed through a local (parallel) bus. Since
> Kirkwood does not provide such an interface, we added a custom FPGA
> (PCIe device) which implements a PCIe-to-localbus bridge.
> So essentially BAR0 provides the configuration space for such a
> bridge, and BAR1 provides a remapped area where accesses to the
> localbus can be performed. BAR2 and BAR3 provide other functions.
> 
> So with the appropriate reg encoding of the PCI device, the PCI
> driver for the FPGA will automatically get an of_node.
> 
> My question is: is there any way I can describe this external device
> (I believe as a child node of the PCI device), so that a call to
> of_address_to_resource() (or equivalent) from its driver will
> automatically translate a localbus address (e.g. 0x0000abcd) to
> whatever address was assigned to BAR1 (in my case 0xe0000000 ->
> 0xe000abcd)?

Perhaps I don't understand properly, but what good is the local bus
address to any driver? I mean you'll have to have a PCI driver to bind
to the PCI device, right? And that PCI driver will only need to obtain
the register addresses from BAR1, then access that region.

Why would you need to have it translated via DT?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131106/8a37f85c/attachment.sig>
