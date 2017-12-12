From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 12 Dec 2017 19:02:23 +0100
Subject: [PATCH 0/3] Enable DMA on STM32 MCU based on cortex-M7
Message-ID: <1513101746-18030-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enable DMA on several STM32 MCU based on cortex-M7.
To make it possible, a dedicated dma pool memory area has to be
created. This patchset activate also ARM_MPU flag which will configure 
MPU (Memory Protection Unit) according to devicetree information (mem
and dma-pool). Note that on cortex-M7 DMA has to use a NO cache-able 
memory region.

Regards
Alex


Alexandre Torgue (3):
  ARM: dts: stm32: add DMA memory pool on MCU which embed a cortex-M7
  ARM: configs: stm32: Enable ARM_MPU
  ARM: dts: stm32: enable dma on MCU which embed a cortex-M7

 arch/arm/boot/dts/stm32746g-eval.dts   | 21 +++++++++++++++++++++
 arch/arm/boot/dts/stm32f769-disco.dts  | 21 +++++++++++++++++++++
 arch/arm/boot/dts/stm32h743i-disco.dts | 21 +++++++++++++++++++++
 arch/arm/boot/dts/stm32h743i-eval.dts  | 21 +++++++++++++++++++++
 arch/arm/configs/stm32_defconfig       |  1 +
 5 files changed, 85 insertions(+)

-- 
2.7.4
