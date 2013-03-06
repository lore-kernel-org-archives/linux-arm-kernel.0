From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 6 Mar 2013 12:09:40 -0700
Subject: [PATCH 06/10] arm: mach-kirkwood: convert to use mvebu-mbus driver
In-Reply-To: <1362577426-12804-7-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362577426-12804-7-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130306190940.GB4689@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 02:43:42PM +0100, Thomas Petazzoni wrote:
> +void __init kirkwood_setup_wins(void)
> +{
> +	/*
> +	 * The PCIe windows will no longer be statically allocated
> +	 * here once Kirkwood is migrated to the pci-mvebu driver.
> +	 */
> +	mvebu_mbus_add_window_remap_flags("pcie0.0",
> +					  KIRKWOOD_PCIE_IO_PHYS_BASE,
> +					  KIRKWOOD_PCIE_IO_SIZE,
> +					  KIRKWOOD_PCIE_IO_BUS_BASE,
> +					  MVEBU_MBUS_PCI_IO);
> +	mvebu_mbus_add_window_remap_flags("pcie0.0",
> +					  KIRKWOOD_PCIE_MEM_PHYS_BASE,
> +					  KIRKWOOD_PCIE_MEM_SIZE,
> +					  MVEBU_MBUS_NO_REMAP,
> +					  MVEBU_MBUS_PCI_MEM);
> +	mvebu_mbus_add_window_remap_flags("pcie1.0",
> +					  KIRKWOOD_PCIE1_IO_PHYS_BASE,
> +					  KIRKWOOD_PCIE1_IO_SIZE,
> +					  KIRKWOOD_PCIE1_IO_BUS_BASE,
> +					  MVEBU_MBUS_PCI_IO);
> +	mvebu_mbus_add_window_remap_flags("pcie1.0",
> +					  KIRKWOOD_PCIE1_MEM_PHYS_BASE,
> +					  KIRKWOOD_PCIE1_MEM_SIZE,
> +					  MVEBU_MBUS_NO_REMAP,
> +					  MVEBU_MBUS_PCI_MEM);

I would like to see these PCI related items move to the kirkwood pcie.c
file, for clarity.

Jason
