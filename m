From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 21 Jun 2013 12:23:44 +0200
Subject: [PATCHv3 07/11] arm: pci: add ->add_bus() and ->remove_bus()
 hooks to hw_pci
In-Reply-To: <1371660979-21588-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130621102343.GE12441@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 06:56:15PM +0200, Thomas Petazzoni wrote:
> Some PCI drivers may need to adjust the pci_bus structure after it has
> been allocated by the Linux PCI core. The PCI core allows
> architectures to implement the pcibios_add_bus() and
> pcibios_remove_bus() for this purpose. This commit therefore extends
> the hw_pci and pci_sys_data structures of the ARM PCI core to allow
> PCI drivers to register ->add_bus() and ->remove_bus() in hw_pci,
> which will get called when a bus is added or removed from the system.
> 
> This will be used for example by the Marvell PCIe driver to connect a
> particular PCI bus with its corresponding MSI chip to handle Message
> Signaled Interrupts.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/include/asm/mach/pci.h |  4 ++++
>  arch/arm/kernel/bios32.c        | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)

Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/19a95846/attachment-0001.sig>
