From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 6 Jun 2016 10:31:48 +0530
Subject: [PATCH 00/18]  Add support for FDMA DMA controller and xp70
 rproc found on STi chipsets
In-Reply-To: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
References: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160606050148.GX16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 05:06:33PM +0100, Peter Griffin wrote:
> 
> Peter Griffin (18):
>   dmaengine: st_fdma: Add STMicroelectronics FDMA DT binding
>     documentation
>   dmaengine: st_fdma:  Add STMicroelectronics FDMA driver header file
>   dmaengine: st_fdma: Add STMicroelectronics FDMA engine driver support
>   dmaengine: st_fdma: Add xp70 firmware loading mechanism.
>   dmaengine: st_fdma: Add fdma suspend and resume callbacks.

I do not see the latter two patches in this series. Something is missed here
from cover to actual patches which is bit bizarre as one tends to generate
patches and cover together

>   ARM: STi: DT: STiH407: Add FDMA driver dt nodes.
>   MAINTAINERS: Add FDMA driver files to STi section.
>   ARM: multi_v7_defconfig: Enable STi FDMA driver
>   ASoC: sti: Update DT example to match the driver code
>   ASoC: sti: Update example to include assigned-clocks and mclk-fs
>   ARM: multi_v7_defconfig: Enable STi and simple-card drivers.
>   ARM: DT: STiH407: Add i2s_out pinctrl configuration
>   ARM: DT: STiH407: Add i2s_in pinctrl configuration
>   ARM: DT: STiH407: Add spdif_out pinctrl config
>   ARM: STi: DT: STiH407: Add sti-sasg-codec dt node
>   ARM: STi: DT: STiH407: Add uniperif player dt nodes
>   ARM: STi: DT: STiH407: Add uniperif reader dt nodes
>   ARM: DT: STi: stihxxx-b2120: Add DT nodes for STi audio card
> 
>  Documentation/devicetree/bindings/dma/st_fdma.txt  |   87 ++
>  .../devicetree/bindings/sound/st,sti-asoc-card.txt |   22 +-
>  MAINTAINERS                                        |    1 +
>  arch/arm/boot/dts/stih407-family.dtsi              |  164 +++
>  arch/arm/boot/dts/stih407-pinctrl.dtsi             |   55 +
>  arch/arm/boot/dts/stihxxx-b2120.dtsi               |   40 +
>  arch/arm/configs/multi_v7_defconfig                |    4 +
>  drivers/dma/Kconfig                                |   12 +
>  drivers/dma/Makefile                               |    1 +
>  drivers/dma/st_fdma.c                              | 1203 ++++++++++++++++++++
>  drivers/dma/st_fdma.h                              |  281 +++++
>  11 files changed, 1863 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/st_fdma.txt
>  create mode 100644 drivers/dma/st_fdma.c
>  create mode 100644 drivers/dma/st_fdma.h

-- 
~Vinod
