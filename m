From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Wed, 27 Sep 2017 14:31:03 +0200
Subject: [RESEND PATCH v5 0/4] Add STM32 DMAMUX support
In-Reply-To: <20170927103631.GL30097@localhost>
References: <1506065492-31478-1-git-send-email-pierre-yves.mordret@st.com>
 <20170927103631.GL30097@localhost>
Message-ID: <3bda21bc-26e9-cc15-7227-8ed1523ab4fa@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Vinod.
The fourth is going to be managed by ARM team.

Regards

On 09/27/2017 12:36 PM, Vinod Koul wrote:
> On Fri, Sep 22, 2017 at 09:31:28AM +0200, Pierre-Yves MORDRET wrote:
>> This patchset adds support for the STM32 DMA multiplexer.
>> It allows to map any peripheral DMA request to any channel of the product
>> DMAs.
>> This IP has been introduced with STM32H7 SoC.
> 
> Applied first three patches, thanks
> 
>> ---
>>  Version history:
>>     v5:
>>         * Set selected channel ID within a lock to avoid race condition.
>>           Release if any error occurs
>>     v4:
>>         * Add multi-master ability for STM32 DMAMUX
>>         * Get rid of st,dmamux property and custom API between STM32
>>           DMAMUX and DMA. Bindings has changed.
>>           DMAMUX will read DMA masters from Device Tree from now on.
>>           Merely one DMAMUX node is needed now.
>>         * Only STM32 DMA are allowed to be connected onto DMAMUX
>>         * channelID is computed locally within the driver and crafted in
>>           dma_psec to be passed toward DMA master.
>>           DMAMUX router sorts out which DMA master will serve the
>>           request automatically.
>>         * This version forbids the use of DMA in standalone and DMAMUX at
>>           the same time : all clients need to be connected either on DMA
>>           or DMAMUX ; no mix up
>>     v3:
>>         * change compatible to st,stm32h7-dmamux to be mode Soc specific
>>         * add verbosity in dma-cells
>> ---
>>
>> Pierre-Yves MORDRET (4):
>>   dt-bindings: Document the STM32 DMAMUX bindings
>>   dmaengine: Add STM32 DMAMUX driver
>>   dt-bindings: stm32-dma: add a property to handle STM32 DMAMUX
>>   ARM: configs: stm32: Add DMAMUX support in STM32 defconfig
>>
>>  .../devicetree/bindings/dma/stm32-dma.txt          |   4 +-
>>  .../devicetree/bindings/dma/stm32-dmamux.txt       |  84 ++++++
>>  arch/arm/configs/stm32_defconfig                   |   1 +
>>  drivers/dma/Kconfig                                |   9 +
>>  drivers/dma/Makefile                               |   1 +
>>  drivers/dma/stm32-dmamux.c                         | 327 +++++++++++++++++++++
>>  6 files changed, 425 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/devicetree/bindings/dma/stm32-dmamux.txt
>>  create mode 100644 drivers/dma/stm32-dmamux.c
>>
>> -- 
>> 2.7.4
>>
> 
