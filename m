From: ludovic.barre@st.com (Ludovic BARRE)
Date: Fri, 29 Jun 2018 15:51:10 +0200
Subject: [PATCH 00/19] mmc: mmci: add stm32 sdmmc variant
In-Reply-To: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <f475a8c7-5a48-bf40-bbd9-a7a513f8a70f@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Ulf

I know that you very busy on other task,
but did you have time to look my serie.
do you have first feedback ?

BR
Ludo

On 06/12/2018 03:14 PM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch series adapts mmci driver to add support for stm32
> sdmmc variant. stm32h7 SoC integrates the first revision of
> stm32 sdmmc.
> 
> This series is composed of 3 parts:
> -Prepare mmci driver to manage dma interfaces by adding property.
>   New mmci dma API is defined according to the legacy needs.
> -Adapt mmci driver to dedicated constraints of stm32 sdmmc variant,
>   defined under some specific properties.
> -Add stm32 sdmmc variant. As Internal DMA way satisfies data
> transfer, the mmci driver hasn't been modified for pio_read/write.
> Specific adds-ons to stm32 sdmmc:
>   + registers
>   + clk/power functions
>   + idma interface
> 
> Ludovic Barre (19):
>    mmc: mmci: regroup and define dma operations
>    mmc: mmci: merge qcom dml feature into mmci dma
>    mmc: mmci: add datactrl block size variant property
>    mmc: mmci: expand startbiterr to irqmask and error check
>    mmc: mmci: allow to overwrite clock/power procedure to specific
>      variant
>    mmc: mmci: add variant properties to define cpsm & cmdresp bits
>    mmc: mmci: add variant property to define dpsm bit
>    mmc: mmci: add variant property to define irq pio mask
>    mmc: mmci: add variant property to write datactrl before command
>    mmc: mmci: add variant property to allow remain data
>    mmc: mmci: add variant property to check specific data constraint
>    mmc: mmci: add variant property to request a reset
>    mmc: mmci: send stop cmd if a data command fail
>    mmc: mmci: add clock divider for stm32 sdmmc
>    mmc: mmci: add stm32 sdmmc registers
>    mmc: mmci: add DT bindings for STM32 sdmmc
>    mmc: mmci: add stm32 sdmmc idma support
>    mmc: mmci: add specific clk/pwr procedure for stm32 sdmmc
>    mmc: mmci: add stm32 sdmmc variant
> 
>   Documentation/devicetree/bindings/mmc/mmci.txt |  11 +
>   drivers/mmc/host/Makefile                      |   3 +-
>   drivers/mmc/host/mmci.c                        | 846 +++++++++++--------------
>   drivers/mmc/host/mmci.h                        | 237 ++++++-
>   drivers/mmc/host/mmci_dma.c                    | 780 +++++++++++++++++++++++
>   drivers/mmc/host/mmci_dma.h                    |  33 +
>   drivers/mmc/host/mmci_qcom_dml.c               | 177 ------
>   drivers/mmc/host/mmci_qcom_dml.h               |  31 -
>   8 files changed, 1410 insertions(+), 708 deletions(-)
>   create mode 100644 drivers/mmc/host/mmci_dma.c
>   create mode 100644 drivers/mmc/host/mmci_dma.h
>   delete mode 100644 drivers/mmc/host/mmci_qcom_dml.c
>   delete mode 100644 drivers/mmc/host/mmci_qcom_dml.h
> 
