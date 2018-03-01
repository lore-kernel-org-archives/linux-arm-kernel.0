From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Thu, 1 Mar 2018 10:43:35 +0100
Subject: [PATCH 0/6] Add mmc support for STM32F7 boards
Message-ID: <1519897421-23803-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

This series adds :
 _ SDIO pins definition for STM32F7 SoCs family
 _ add sdio1 DT entry for STM32F746 Discovery board
 _ add sdio1 DT entry for STM32F746 Evaluation board
 _ add sdio1 DT entry for STM32F769 Discovery board
 _ add SDMMC2 entry in stm32f7-rcc.h
 _ replace sdio2 hard coded value in stm32f746.dtsi

Patrice Chotard (6):
  ARM: dts: stm32: Add sdio pins definition for stm32f7
  ARM: dts: stm32: Enable sdio1 for stm32f746-disco
  ARM: dts: stm32: Enable sdio1 for stm32f746-eval
  ARM: dts: stm32: Enable sdio1 for stm32f769-disco
  dt-bindings: mfd: Add STM32F7 SDMMC2 rcc entry
  ARM: dts: stm32: Fix sdio2 rcc hard coded value

 arch/arm/boot/dts/stm32746g-eval.dts   | 17 ++++++++++
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi | 62 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32f746-disco.dts  | 19 +++++++++++
 arch/arm/boot/dts/stm32f746.dtsi       |  2 +-
 arch/arm/boot/dts/stm32f769-disco.dts  | 19 +++++++++++
 include/dt-bindings/mfd/stm32f7-rcc.h  |  1 +
 6 files changed, 119 insertions(+), 1 deletion(-)

-- 
1.9.1
