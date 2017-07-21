From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 21 Jul 2017 12:06:12 +0530
Subject: [PATCH v2 0/4] Add STM32 MDMA driver
In-Reply-To: <1fda0cc8-0b3c-70b0-0b34-b9b9a3ca6121@st.com>
References: <1499343941-6375-1-git-send-email-pierre-yves.mordret@st.com>
 <1fda0cc8-0b3c-70b0-0b34-b9b9a3ca6121@st.com>
Message-ID: <20170721063612.GN3053@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 09:37:48AM +0000, Pierre Yves MORDRET wrote:
> 
> 
> On 07/06/2017 02:25 PM, Pierre-Yves MORDRET wrote:
> > This patchset adds support for the STM32 MDMA controller.
> > The Master Direct memory access (MDMA) provides high-speed data transfer
> > between memory and memory or between peripherals and memory.
> > Contrary to STM32 DMA, the STM32 MDMA controller supports hardware LLI and
> > uses a larger integrated FIFO (128 vs 16 bytes)
> 
> Gentle ping for driver review since DT Bindings has been acked by Rob
> Herring.

Please allow reasonable time for review, this was sent during merge window
and I dont apply patches during that time.

> 
> Thanks
> Py
> 
> > ---
> >    Version history:
> >       v2:
> >           * change compatible into st,stm32h7-mdma to be more SoC specific
> >           * Add MDMA support in DT for H7
> >           * Add MDMA support in STM32 defconfig
> > ---
> > Pierre-Yves MORDRET (4):
> >    dt-bindings: Document the STM32 MDMA bindings
> >    dmaengine: Add STM32 MDMA driver
> >    ARM: dts: stm32: Add MDMA support for STM32H743 SoC
> >    ARM: configs: stm32: Add MDMA support in STM32 defconfig
> > 
> >   .../devicetree/bindings/dma/stm32-mdma.txt         |   94 ++
> >   arch/arm/boot/dts/stm32h743.dtsi                   |   10 +
> >   arch/arm/configs/stm32_defconfig                   |    1 +
> >   drivers/dma/Kconfig                                |   12 +
> >   drivers/dma/Makefile                               |    1 +
> >   drivers/dma/stm32-mdma.c                           | 1536 ++++++++++++++++++++
> >   6 files changed, 1654 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/dma/stm32-mdma.txt
> >   create mode 100644 drivers/dma/stm32-mdma.c
> > 

-- 
~Vinod
