From: lionel.debieve@st.com (Lionel Debieve)
Date: Thu, 13 Jul 2017 15:32:25 +0200
Subject: [PATCH 0/2] STM32 HASH crypto driver
Message-ID: <1499952747-16423-1-git-send-email-lionel.debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches adds a new crypto driver for STMicroelectronics stm32 HW.
This drivers uses the crypto API and provides with HW-enabled md5, sha1,
sha224, sha256 hash based algorithms.
It makes use of the crypto engine to support ahash requests.

This driver was successfully tested with tcrypt / testmgr.

Note:
Since two other set of patches (update of STM32 CRC32 and addition of STM32
CRYP) are being proposed, it may happen that there are some minor conflicts in
'Kconfig' and 'Makefile'. In that case, I will fix the issue in due course.

Lionel Debieve (2):
  dt-bindings: Document STM32 HASH bindings
  crypto: stm32 - Support for STM32 HASH module

 .../devicetree/bindings/crypto/st,stm32-hash.txt   |   30 +
 drivers/crypto/stm32/Kconfig                       |   13 +
 drivers/crypto/stm32/Makefile                      |    1 +
 drivers/crypto/stm32/stm32-hash.c                  | 1576 ++++++++++++++++++++
 4 files changed, 1620 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/st,stm32-hash.txt
 create mode 100644 drivers/crypto/stm32/stm32-hash.c

-- 
2.7.4
