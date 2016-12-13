From: ryder.lee@mediatek.com (Ryder Lee)
Date: Tue, 13 Dec 2016 09:31:14 +0800
Subject: [PATCH v2 0/2] Add MediaTek crypto accelerator driver
Message-ID: <1481592676-2248-1-git-send-email-ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This adds support for the MediaTek hardware accelerator on
some SoCs.

This driver currently implement: 
- SHA1 and SHA2 family(HMAC) hash algorithms.
- AES block cipher in CBC/ECB mode with 128/196/256 bits keys.

Changes since v2:
- use byteorder conversion macros and type identifiers for descriptors
- revise register definition macros to make it more clear
- revise DT compatiable string

Changes since v1:
- remove EXPORT_SYMBOL
- remove unused PRNG setting
- sort headers in alphabetical order
- add a definition for IRQ unmber
- replace ambiguous definition
- add more annotation and function comment
- add COMPILE_TEST in Kconfig

Ryder Lee (2):
  Add crypto driver support for some MediaTek chips
  crypto: mediatek - add DT bindings documentation

 .../devicetree/bindings/crypto/mediatek-crypto.txt |   32 +
 drivers/crypto/Kconfig                             |   17 +
 drivers/crypto/Makefile                            |    1 +
 drivers/crypto/mediatek/Makefile                   |    2 +
 drivers/crypto/mediatek/mtk-aes.c                  |  766 +++++++++++
 drivers/crypto/mediatek/mtk-platform.c             |  604 ++++++++
 drivers/crypto/mediatek/mtk-platform.h             |  238 ++++
 drivers/crypto/mediatek/mtk-regs.h                 |  194 +++
 drivers/crypto/mediatek/mtk-sha.c                  | 1437 ++++++++++++++++++++
 9 files changed, 3291 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/mediatek-crypto.txt
 create mode 100644 drivers/crypto/mediatek/Makefile
 create mode 100644 drivers/crypto/mediatek/mtk-aes.c
 create mode 100644 drivers/crypto/mediatek/mtk-platform.c
 create mode 100644 drivers/crypto/mediatek/mtk-platform.h
 create mode 100644 drivers/crypto/mediatek/mtk-regs.h
 create mode 100644 drivers/crypto/mediatek/mtk-sha.c

-- 
1.9.1
