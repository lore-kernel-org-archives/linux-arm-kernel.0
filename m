From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 21 Jun 2013 09:23:18 +0200
Subject: [PATCHv3 07/11] arm: pci: add ->add_bus() and ->remove_bus()
 hooks to hw_pci
In-Reply-To: <1371660979-21588-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130621092318.410465eb@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Wed, 19 Jun 2013 18:56:15 +0200, Thomas Petazzoni wrote:
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

Do you have any comments ? Any chance to get this merged for 3.11 ? It
is independent of the previous patches of the patch series, so it can
be merged independently.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
