From: helgaas@kernel.org (Bjorn Helgaas)
Date: Sat, 28 Jan 2017 15:10:29 -0600
Subject: [PATCH V7 00/11] IOMMU probe deferral support
In-Reply-To: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <20170128211029.GI20550@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 09:48:02PM +0530, Sricharan R wrote:
> This series calls the dma ops configuration for the devices
> at a generic place so that it works for all busses.
> The dma_configure_ops for a device is now called during
> the device_attach callback just before the probe of the
> bus/driver is called. Similarly dma_deconfigure is called during
> device/driver_detach path.
> ...

>  arch/arm64/mm/dma-mapping.c       | 132 ++++----------------------------------
>  drivers/acpi/arm64/iort.c         |  40 +++++++++++-
>  drivers/acpi/glue.c               |   5 --
>  drivers/acpi/scan.c               |   7 +-
>  drivers/base/dd.c                 |   9 +++
>  drivers/base/dma-mapping.c        |  41 ++++++++++++
>  drivers/iommu/arm-smmu-v3.c       |  46 +------------
>  drivers/iommu/arm-smmu.c          |  58 +++--------------
>  drivers/iommu/of_iommu.c          | 114 +++++++++++++++++++++++---------
>  drivers/of/address.c              |  20 +++++-
>  drivers/of/device.c               |  36 ++++++-----
>  drivers/of/platform.c             |  10 +--
>  drivers/pci/probe.c               |  28 --------
>  include/acpi/acpi_bus.h           |   2 +-
>  include/asm-generic/vmlinux.lds.h |   1 -
>  include/linux/acpi.h              |   7 +-
>  include/linux/acpi_iort.h         |   3 -
>  include/linux/dma-mapping.h       |   3 +
>  include/linux/of_device.h         |  10 ++-
>  19 files changed, 252 insertions(+), 320 deletions(-)

I'm assuming this will go via some other tree, maybe the IOMMU tree?
I acked the PCI parts, so let me know if you need anything more from me.
