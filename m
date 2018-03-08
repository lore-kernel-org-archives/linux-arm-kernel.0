From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 8 Mar 2018 15:34:18 +0000
Subject: [PATCH v2 0/2] PCI: armada8k: Fix clock resource for Armada 7K/8K
In-Reply-To: <20180228163530.25389-1-gregory.clement@bootlin.com>
References: <20180228163530.25389-1-gregory.clement@bootlin.com>
Message-ID: <20180308153418.GA2780@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 05:35:28PM +0100, Gregory CLEMENT wrote:
> Hi,
> 
> This short series fixes the way the clocks are used for the PCIe host
> controller embedded in the Marvell Armada 7K/8K SoCs. On these SoCs a
> second one is needed in order to clock the registers. It was not
> noticed until now because we relied on the bootloader and also because
> the clock driver was wrong.
> 
> Thanks to this fix, it would be possible to fix the clock driver
> without introducing a regression.
> 
> The first patch is just a small cleanup found when I wrote the main
> patch.
> 
> Changelog:
> v1 -> v2:
> 
>  - Removed a unneeded new line in the binding documentation, pointed
>    by Thomas Petazzoni.
> 
>  - Added a new line in driver code, pointed by Thomas Petazzoni.
> 
>  - Managed the failure of clk_prepare_enable for the clk_reg in a
>    separate case, pointed by Thomas Petazzoni.
> 
>  - Simplified the -EPROBE_DEFER case for the clk_reg, suggested by
>    Russell King
> 
>  - Added backed the line getting the reg clock that disappeared in the
>    first version.
> 
> Gregory CLEMENT (2):
>   PCI: armada8k: Remove useless test before clk_disable_unprepare
>   PCI: armada8k: Fix clock resource by adding a register clock
> 
>  .../devicetree/bindings/pci/pci-armada8k.txt        |  5 ++++-
>  drivers/pci/dwc/pcie-armada8k.c                     | 21 +++++++++++++++++----
>  2 files changed, 21 insertions(+), 5 deletions(-)

Applied to pci/armada8k for v4.17, thank you.

Lorenzo
