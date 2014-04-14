From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 14 Apr 2014 17:53:37 +0200
Subject: [PATCH v2 0/5] Support for Marvell AHCI interface on Armada 38x
In-Reply-To: <1397486055-16303-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397486055-16303-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <16639486.i0jTGsaDYr@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, April 14, 2014 04:34:10 PM Thomas Petazzoni wrote:
> Hello,
> 
> The Marvell Armada 38x ARM processors use an AHCI compatible interface
> for SATA (in replacement of the Marvell-specific SATA interface,
> handled by the sata_mv driver). However, like all DMA-capable Marvell
> interfaces, some specific MBus window configuration must be done, so a
> small specific glue layer is needed, which relies on the recently
> introduced libahci_platform.c.
> 
> Changes since v1:
> 
>  * Rebased on top of v3.15-rc1
> 
>  * Added a preliminary patch that orders alphabetically the list of
>    compatible strings in the DT binding document
>    ahci-platform.txt. Suggested by Andrew Lunn.
> 
>  * Made the availability of MBus DRAM window informations
>    mandatory. Suggested by Andrew Lunn.
> 
>  * Fixed the module alias name. Suggested by Bartlomiej
>    Zolnierkiewicz.

Well, you could have also added a comment explaining the lack of
the Power Management support..

> Details of the patches:
> 
>  * The first patch is a DT binding documentation cleanup. I believe it
>    should be taken by the ATA maintainer, because the second patch
>    (driver patch) depends on it.
> 
>  * The second patch of this series contains the driver itself, which
>    is fairly straight-forward. It should be taken by Tejun Heo as the
>    ATA maintainer.
> 
>  * The last three patches add the Device Tree and defconfig
>    changes. They should be taken by the respective ARM maintainers
>    (mvebu maintainers for the DT and mvebu_v7_defconfig, and arm-soc
>    maintainers for the multi_v7_defconfig change).

Anyway, all patches look OK to me.

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> Thanks!
> 
> Thomas
> 
> Thomas Petazzoni (5):
>   Documentation: dt-bindings: reformat and order list of ahci-platform
>     compatibles
>   ata: ahci_mvebu: new driver for Marvell Armada 380 AHCI interfaces
>   ARM: mvebu: add Device Tree description of AHCI interfaces on Armada
>     38x
>   ARM: configs: add ahci_mvebu to mvebu_v7_defconfig
>   ARM: configs: add ahci_mvebu to multi_v7_defconfig
> 
>  .../devicetree/bindings/ata/ahci-platform.txt      |  13 ++-
>  arch/arm/boot/dts/armada-385-db.dts                |   8 ++
>  arch/arm/boot/dts/armada-38x.dtsi                  |  16 +++
>  arch/arm/configs/multi_v7_defconfig                |   1 +
>  arch/arm/configs/mvebu_v7_defconfig                |   1 +
>  drivers/ata/Kconfig                                |   9 ++
>  drivers/ata/Makefile                               |   1 +
>  drivers/ata/ahci_mvebu.c                           | 107 +++++++++++++++++++++
>  8 files changed, 152 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/ata/ahci_mvebu.c

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
