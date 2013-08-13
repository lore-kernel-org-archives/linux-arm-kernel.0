From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 13 Aug 2013 10:01:30 -0400
Subject: [PATCH v2 0/5] ARM: dove: DT PCIe support
In-Reply-To: <1376396724-32048-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376396724-32048-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130813140130.GA25111@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bjorn,

On Tue, Aug 13, 2013 at 02:25:19PM +0200, Sebastian Hesselbarth wrote:
> This patch set adds support for the PCIe controllers found on Marvell
> Dove SoCs. It depends on mvebu-pci patches sent by Thomas Petazzoni.

Well, when it rains, it pours.  If this series looks good to you, I'll
go ahead and add it on top of Thomas' patches.

> The ARM Dove related patches have already been taken by Jason Cooper
> and have been removed from v2 of this patch set. Changelog is added
> to the individual patch emails.
> 
> Patches 1 and 2 fix some minor issues with pci-mvebu by moving
> clk_prepare_enable before accessing any controller registers and
> counting sucessfully registered ports only.
> 
> Patch 3 converts pci-mvebu from subsys_initcall registration to
> normal platform driver registration to allow it to fail with
> EPROBE_DEFER later.
> 
> Patch 4 adds DT parsing for reset (PERST#) GPIO pins and delay to
> wait for PCIe devices after reset de-assertion.
> 
> Patch 5 finally adds a compatible to pci-mvebu for Dove SoCs.
> 
> [Patch 6-9 have already been taken by Jason Cooper]

These were the dts files.

> Sebastian Hesselbarth (5):
>   PCI: mvebu: move clock enable before register access
>   PCI: mvebu: increment nports only for registered ports
>   PCI: mvebu: remove subsys_initcall
>   PCI: mvebu: add support for reset on GPIO
>   PCI: mvebu: add support for Marvell Dove SoCs
> 
>  .../devicetree/bindings/pci/mvebu-pci.txt          |    7 ++
>  drivers/pci/host/Kconfig                           |    2 +-
>  drivers/pci/host/pci-mvebu.c                       |   99 +++++++++++++-------
>  3 files changed, 71 insertions(+), 37 deletions(-)

Should be pretty isolated.

thx,

Jason.
