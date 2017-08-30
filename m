From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 30 Aug 2017 17:55:26 +0200
Subject: [PATCH v2 0/3] Add support for STM32 vrefbuf regulator
Message-ID: <1504108529-31727-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some STM32 devices embed a voltage reference buffer which can be used as
voltage reference for ADCs, DACs and also as voltage reference
for external components through the dedicated VREF+ pin.

This patchset adds vrefbuf regulator driver, device tree bindings and
vrefbuf device tree node for STM32H7 SoC.

---
Changes in v2:
- Update regulator driver following Mark's remarks

Fabrice Gasnier (3):
  dt-bindings: regulator: Add STM32 Voltage Reference Buffer
  regulator: Add support for stm32-vrefbuf
  ARM: dts: stm32: add vrefbuf to stm32h743

 .../bindings/regulator/st,stm32-vrefbuf.txt        |  20 ++
 arch/arm/boot/dts/stm32h743.dtsi                   |   9 +
 drivers/regulator/Kconfig                          |  12 ++
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/stm32-vrefbuf.c                  | 202 +++++++++++++++++++++
 5 files changed, 244 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.txt
 create mode 100644 drivers/regulator/stm32-vrefbuf.c

-- 
1.9.1
