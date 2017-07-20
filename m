From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Thu, 20 Jul 2017 09:42:29 +0000
Subject: [PATCH v3 0/5] Add STM32 DMAMUX support
In-Reply-To: <1499343623-5964-1-git-send-email-pierre-yves.mordret@st.com>
References: <1499343623-5964-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <f84dd329-43e7-6d8a-81c9-841ba8e97db4@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/06/2017 02:20 PM, Pierre-Yves MORDRET wrote:
> This patchset adds support for the STM32 DMA multiplexer.
> It allows to map any peripheral DMA request to any channel of the product
> DMAs.
> This IP has been introduced with STM32H7 SoC.
> 

Gentle ping for driver review since DT Bindings has been acked by Rob
Herring.

Thanks
Py

> ---
>   Version history:
>      v3:
>          * change compatible to st,stm32h7-dmamux to be mode Soc specific
>          * add verbosity in dma-cells
> ---
> 
> Pierre-Yves MORDRET (5):
>    dt-bindings: Document the STM32 DMAMUX bindings
>    dmaengine: Add STM32 DMAMUX driver
>    dt-bindings: stm32-dma: Add property to handle STM32 DMAMUX
>    dmaengine: stm32-dma: Add support for STM32 DMAMUX
>    ARM: configs: stm32: Add DMAMUX support in STM32 defconfig
> 
>   .../devicetree/bindings/dma/stm32-dma.txt          |   5 +-
>   .../devicetree/bindings/dma/stm32-dmamux.txt       |  60 +++++
>   arch/arm/configs/stm32_defconfig                   |   1 +
>   drivers/dma/Kconfig                                |   9 +
>   drivers/dma/Makefile                               |   1 +
>   drivers/dma/stm32-dma.c                            |  44 ++--
>   drivers/dma/stm32-dmamux.c                         | 253 +++++++++++++++++++++
>   include/linux/dma/stm32-dmamux.h                   |  21 ++
>   8 files changed, 380 insertions(+), 14 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/dma/stm32-dmamux.txt
>   create mode 100644 drivers/dma/stm32-dmamux.c
>   create mode 100644 include/linux/dma/stm32-dmamux.h
> 
