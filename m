From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 14 Dec 2015 08:25:29 +0100
Subject: [PATCH 08/10] drivers/pci: make host/pcie-xilinx.c explicitly
 non-modular
In-Reply-To: <1449970917-12633-9-git-send-email-paul.gortmaker@windriver.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
 <1449970917-12633-9-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <566E6EE9.6000101@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.12.2015 02:41, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/pci/host/Kconfig:config PCIE_XILINX
> drivers/pci/host/Kconfig:       bool "Xilinx AXI PCIe host bridge support"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.  This
> makes xilinx_pcie_free_irq_domain orphaned so we remove it too.

Right.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
