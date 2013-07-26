From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 26 Jul 2013 10:13:05 +0200
Subject: [PATCHv5 08/11] ARM: pci: add ->add_bus() and ->remove_bus()
 hooks to hw_pci
In-Reply-To: <20130725165659.GB27802@dhcp-172-17-186-34.nvidia.com>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1373889167-27878-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130725165659.GB27802@dhcp-172-17-186-34.nvidia.com>
Message-ID: <20130726101305.22a5c892@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Thierry Reding,

On Thu, 25 Jul 2013 09:57:00 -0700, Thierry Reding wrote:
> On Mon, Jul 15, 2013 at 01:52:44PM +0200, Thomas Petazzoni wrote:
> > Some PCI drivers may need to adjust the pci_bus structure after it has
> > been allocated by the Linux PCI core. The PCI core allows
> > architectures to implement the pcibios_add_bus() and
> > pcibios_remove_bus() for this purpose. This commit therefore extends
> > the hw_pci and pci_sys_data structures of the ARM PCI core to allow
> > PCI drivers to register ->add_bus() and ->remove_bus() in hw_pci,
> > which will get called when a bus is added or removed from the system.
> > 
> > This will be used for example by the Marvell PCIe driver to connect a
> > particular PCI bus with its corresponding MSI chip to handle Message
> > Signaled Interrupts.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
> > ---
> >  arch/arm/include/asm/mach/pci.h |  4 ++++
> >  arch/arm/kernel/bios32.c        | 16 ++++++++++++++++
> >  2 files changed, 20 insertions(+)
> 
> Hi Russell,
> 
> Can we have your Acked-by on this patch so that it can be moved to a
> stable branch along with some of the other patches in this branch that
> both Marvell and Tegra PCIe drivers need?

I've pinged Russell a few times about this patch already, but haven't
received feedback from him. Do you think I can just go ahead and submit
the patch to Russell's patch system, after fixing the minor nits you
mentioned?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
