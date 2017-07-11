From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 11 Jul 2017 14:30:30 +0200
Subject: [PATCH 0/3] Add support for STM32 vrefbuf regulator
Message-ID: <1499776233-29116-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some STM32 devices embed a voltage reference buffer which can be used as
voltage reference for ADCs, DACs and also as voltage reference
for external components through the dedicated VREF+ pin.

This patchset adds vrefbuf regulator driver, device tree bindings and
vrefbuf device tree node for STM32H7 SoC.

Fabrice Gasnier (3):
  dt-bindings: regulator: Add STM32 Voltage Reference Buffer
  regulator: Add support for stm32-vrefbuf
  ARM: dts: stm32: add vrefbuf to stm32h743

 .../bindings/regulator/st,stm32-vrefbuf.txt        |  20 ++
 arch/arm/boot/dts/stm32h743.dtsi                   |   9 +
 drivers/regulator/Kconfig                          |  12 ++
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/stm32-vrefbuf.c                  | 215 +++++++++++++++++++++
 5 files changed, 257 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.txt
 create mode 100644 drivers/regulator/stm32-vrefbuf.c

-- 
1.9.1
