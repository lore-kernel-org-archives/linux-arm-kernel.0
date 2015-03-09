From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 9 Mar 2015 15:14:06 +0200
Subject: [PATCH 0/6] dmaengine/dra7x: DMA router (crossbar support)
In-Reply-To: <1424787683-19151-1-git-send-email-peter.ujfalusi@ti.com>
References: <1424787683-19151-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <54FD9C9E.8000405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/24/2015 04:21 PM, Peter Ujfalusi wrote:
> Hi,
> 
> The series adds support for DMA router type of devices. They are used in SoCs
> which has more peripherals with DMA request lines than the DMA controller can
> handle.
> The router itself is not part of the DMA controller and it's operation should be
> transparent (as it is in the HW) for the SW stack.
> 
> This series takes into accound the comments Sricharan received for his version
> of the crossbar driver:
> https://lkml.org/lkml/2014/3/7/199
> 
> This implementation is not tied to any DMA driver so it is possible to use the
> framework by other vendors, also ACPI version of binding can be easy enough to
> be added.
> 
> The omap-dma part of changes are based on the dma property name change series:
> https://lkml.org/lkml/2015/2/20/182
> 
> but the code has fallback so it is working w/o the changes in that series.

Gentle ping on this series before I send the V2 with the comments from Russell
and Paul addressed.

Kind Regards,
P?ter

> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (6):
>   dmaengine: of_dma: Support for DMA routers
>   dmaengine: Add driver for TI DMA crossbar on DRA7x
>   dmaengine: omap-dma: Use defines for dma channels and request count
>   dmaengine: omap-dma: Take DMA request number from DT if it is
>     available
>   dmaengine: omap-dma: Remove mapping between virtual channels and
>     requests
>   ARM: DTS: dra7x: Integrate sDMA crossbar
> 
>  Documentation/devicetree/bindings/dma/dma.txt |  27 ++++
>  arch/arm/boot/dts/dra7.dtsi                   |  57 ++++----
>  drivers/dma/Kconfig                           |   4 +
>  drivers/dma/Makefile                          |   1 +
>  drivers/dma/dmaengine.c                       |   7 +
>  drivers/dma/of-dma.c                          |  92 +++++++++++++
>  drivers/dma/omap-dma.c                        |  24 +++-
>  drivers/dma/ti-dma-crossbar.c                 | 191 ++++++++++++++++++++++++++
>  include/linux/dmaengine.h                     |  17 +++
>  include/linux/of_dma.h                        |  21 +++
>  10 files changed, 413 insertions(+), 28 deletions(-)
>  create mode 100644 drivers/dma/ti-dma-crossbar.c
> 
