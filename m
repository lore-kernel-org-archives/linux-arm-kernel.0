From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 6 Mar 2013 20:31:39 +0100
Subject: [PATCH 06/10] arm: mach-kirkwood: convert to use mvebu-mbus driver
In-Reply-To: <20130306190940.GB4689@obsidianresearch.com>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362577426-12804-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306190940.GB4689@obsidianresearch.com>
Message-ID: <20130306203139.322c013f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Wed, 6 Mar 2013 12:09:40 -0700, Jason Gunthorpe wrote:
> On Wed, Mar 06, 2013 at 02:43:42PM +0100, Thomas Petazzoni wrote:
> > +void __init kirkwood_setup_wins(void)
> > +{
> > +	/*
> > +	 * The PCIe windows will no longer be statically allocated
> > +	 * here once Kirkwood is migrated to the pci-mvebu driver.
> > +	 */
> > +	mvebu_mbus_add_window_remap_flags("pcie0.0",
> > +					  KIRKWOOD_PCIE_IO_PHYS_BASE,
> > +					  KIRKWOOD_PCIE_IO_SIZE,
> > +					  KIRKWOOD_PCIE_IO_BUS_BASE,
> > +					  MVEBU_MBUS_PCI_IO);
> > +	mvebu_mbus_add_window_remap_flags("pcie0.0",
> > +					  KIRKWOOD_PCIE_MEM_PHYS_BASE,
> > +					  KIRKWOOD_PCIE_MEM_SIZE,
> > +					  MVEBU_MBUS_NO_REMAP,
> > +					  MVEBU_MBUS_PCI_MEM);
> > +	mvebu_mbus_add_window_remap_flags("pcie1.0",
> > +					  KIRKWOOD_PCIE1_IO_PHYS_BASE,
> > +					  KIRKWOOD_PCIE1_IO_SIZE,
> > +					  KIRKWOOD_PCIE1_IO_BUS_BASE,
> > +					  MVEBU_MBUS_PCI_IO);
> > +	mvebu_mbus_add_window_remap_flags("pcie1.0",
> > +					  KIRKWOOD_PCIE1_MEM_PHYS_BASE,
> > +					  KIRKWOOD_PCIE1_MEM_SIZE,
> > +					  MVEBU_MBUS_NO_REMAP,
> > +					  MVEBU_MBUS_PCI_MEM);
> 
> I would like to see these PCI related items move to the kirkwood pcie.c
> file, for clarity.

I agree it should be done in pcie.c, but I don't want to do that in
this series. In the previous code, those windows were created
unconditionally, regardless of whether PCIe was actually used or not.
The purpose of the patch is to just migrate the code to use the
mvebu-mbus driver, not to fix all the problems related to the setup of
address decoding windows. So what you suggest should be done as a
follow-up patch.

Since I'm planning on testing the pci-mvebu driver on Kirkwood, I'll
have to do that, but it will be the topic of another patch series.

Let's try to keep the patch series in their original scope. I'd like to
see things being merged at some point, and not being constantly ask to
fix the entire world before any of this mvebu-mbus and pci-mvebu stuff
gets in. I think I've already shown a lot of good-willing in this
entire effort, so the requirements of the community reviewers also have
to be reasonable.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
