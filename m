From: fabien.dessenne@st.com (Fabien Dessenne)
Date: Thu, 19 Oct 2017 11:03:57 +0200
Subject: [PATCH v4 0/2] STM32 CRYP crypto driver
Message-ID: <1508403839-14131-1-git-send-email-fabien.dessenne@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches adds a new crypto driver for STMicroelectronics stm32 HW.
This drivers uses the crypto API and provides with HW-enabled block cipher
algorithms.

This driver was successfully tested with tcrypt / testmgr.

Changes since v4:
- remove AEAD support from crypto engine as proposed by Herbert : waiting for
  the crypto_engine interface clean up before
  [https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1474434.html]
- remove AES GCM & CCM algorithms

Changes since v3:
- update dt-bindings with Rob Herring remarks

Changes since v2:
- update dt-bindings (interrupts description)
- rebase on STM32 crypto patches (L. Debieve : update CRC32 + add HASH)

Fabien Dessenne (3):
  crypto: engine - permit to enqueue aead_request
  dt-bindings: Document STM32 CRYP bindings
  crypto: stm32 - Support for STM32 CRYP crypto module

Fabien Dessenne (2):
  dt-bindings: Document STM32 CRYP bindings
  crypto: stm32 - Support for STM32 CRYP crypto module

 .../devicetree/bindings/crypto/st,stm32-cryp.txt   |   19 +
 drivers/crypto/stm32/Kconfig                       |    9 +
 drivers/crypto/stm32/Makefile                      |    3 +-
 drivers/crypto/stm32/stm32-cryp.c                  | 1188 ++++++++++++++++++++
 4 files changed, 1218 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/st,stm32-cryp.txt
 create mode 100644 drivers/crypto/stm32/stm32-cryp.c

-- 
2.7.4
