From: fabien.dessenne@st.com (Fabien Dessenne)
Date: Thu, 13 Jul 2017 11:59:36 +0200
Subject: [PATCH 0/3] STM32 CRYP crypto driver
Message-ID: <1499939979-8623-1-git-send-email-fabien.dessenne@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches adds a new crypto driver for STMicroelectronics stm32 HW.
This drivers uses the crypto API and provides with HW-enabled AEAD and block
cipher algorithms.
It makes use of the crypto engine which is upgraded in order to support AEAD
requests.

This driver was successfully tested with tcrypt / testmgr.

Note:
Since two other set of patches (update of STM32 CRC32 and addition of STM32
HASH) are being proposed, it may happen that there are some minor conflicts in
'Kconfig' and 'Makefile'. In that case, I will fix the issue in due course.

Fabien Dessenne (3):
  crypto: engine - permit to enqueue aead_request
  dt-bindings: Document STM32 CRYP bindings
  crypto: stm32 - Support for STM32 CRYP crypto module

 .../devicetree/bindings/crypto/st,stm32-cryp.txt   |   20 +
 crypto/crypto_engine.c                             |  101 +
 drivers/crypto/stm32/Kconfig                       |    9 +
 drivers/crypto/stm32/Makefile                      |    1 +
 drivers/crypto/stm32/stm32-cryp.c                  | 1962 ++++++++++++++++++++
 include/crypto/engine.h                            |   16 +
 6 files changed, 2109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/st,stm32-cryp.txt
 create mode 100644 drivers/crypto/stm32/stm32-cryp.c

-- 
2.7.4
