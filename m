From: fabien.dessenne@st.com (Fabien Dessenne)
Date: Tue, 21 Mar 2017 16:13:26 +0100
Subject: [PATCH v2 0/5] STM32 CRC crypto driver
Message-ID: <1490109211-4869-1-git-send-email-fabien.dessenne@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches adds a new crypto driver for STMicroelectronics stm32f746.
The drivers uses the crypto API and provides with an HW-enabled CRC32 algorithm.
It was developed and tested (tcrypt / testmgr) on evaluation board stm32746g.

v2 changes:
- remove useless check of crc / crc->clk
- enable crypto in stm32 defconfig
- typo fix in dt-bindings

Fabien Dessenne (5):
  dt-bindings: Document STM32 CRC bindings
  crypto: stm32 - Support for STM32 CRC32 crypto module
  ARM: dts: stm32: Add CRC support to stm32f746
  ARM: dts: stm32: enable CRC on stm32746g-eval board
  ARM: configs: stm32: Add crypto support

 .../devicetree/bindings/crypto/st,stm32-crc.txt    |  16 +
 arch/arm/boot/dts/stm32746g-eval.dts               |   4 +
 arch/arm/boot/dts/stm32f746.dtsi                   |   7 +
 arch/arm/configs/stm32_defconfig                   |   2 +
 drivers/crypto/Kconfig                             |   2 +
 drivers/crypto/Makefile                            |   1 +
 drivers/crypto/stm32/Kconfig                       |   8 +
 drivers/crypto/stm32/Makefile                      |   2 +
 drivers/crypto/stm32/stm32_crc32.c                 | 324 +++++++++++++++++++++
 9 files changed, 366 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/st,stm32-crc.txt
 create mode 100644 drivers/crypto/stm32/Kconfig
 create mode 100644 drivers/crypto/stm32/Makefile
 create mode 100644 drivers/crypto/stm32/stm32_crc32.c

-- 
2.7.4
