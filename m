From: fabien.dessenne@st.com (Fabien Dessenne)
Date: Tue, 14 Mar 2017 17:37:22 +0100
Subject: [PATCH 0/4] STM32 CRC crypto driver
Message-ID: <1489509446-32283-1-git-send-email-fabien.dessenne@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches adds a new crypto driver for STMicroelectronics stm32f746.
The drivers uses the crypto API and provides with an HW-enabled CRC32 algorithm.
It was developed and tested (tcrypt / testmgr) on evaluation board stm32746g.

Fabien Dessenne (4):
  dt-bindings: Document STM32 CRC bindings
  crypto: stm32 - Support for STM32 CRC32 crypto module
  ARM: dts: stm32: Add CRC support to stm32f746
  ARM: dts: stm32: enable CRC on stm32746g-eval board

 .../devicetree/bindings/crypto/st,stm32-crc.txt    |  16 +
 arch/arm/boot/dts/stm32746g-eval.dts               |   4 +
 arch/arm/boot/dts/stm32f746.dtsi                   |   7 +
 drivers/crypto/Kconfig                             |   2 +
 drivers/crypto/Makefile                            |   1 +
 drivers/crypto/stm32/Kconfig                       |   8 +
 drivers/crypto/stm32/Makefile                      |   2 +
 drivers/crypto/stm32/stm32_crc32.c                 | 325 +++++++++++++++++++++
 8 files changed, 365 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/st,stm32-crc.txt
 create mode 100644 drivers/crypto/stm32/Kconfig
 create mode 100644 drivers/crypto/stm32/Makefile
 create mode 100644 drivers/crypto/stm32/stm32_crc32.c

-- 
2.7.4
