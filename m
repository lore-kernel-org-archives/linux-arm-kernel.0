From: rsahu@apm.com (Rameshwar Prasad Sahu)
Date: Thu, 30 Jul 2015 17:47:40 +0530
Subject: [PATCH v1 0/4] dmaengine: Add supports for APM X-Gene SoC CRC32C
 accerlerator driver
Message-ID: <1438258660-3207-1-git-send-email-rsahu@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements support for APM X-Gene SoC CRC32C h/w accelerator driver
and adds CRC32C support in dmaengine framework. APM X-Gene SoC has DMA engine
capable of performing CRC32C.

Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
---

Rameshwar Prasad Sahu (4):
  dmaengine: Add support for new feature CRC32C
  dmaengine: xgene-dma: Add support for CRC32C calculation via DMA
    engine
  Crypto: Add support for APM X-Gene SoC CRC32C h/w accelerator driver
  Crypto: tcrypt: Add test case for APM X-Gene SoC CRC32C algo

 crypto/tcrypt.c               |   4 +
 crypto/testmgr.c              |   9 ++
 drivers/crypto/Kconfig        |   8 ++
 drivers/crypto/Makefile       |   1 +
 drivers/crypto/xgene-crc32c.c | 244 ++++++++++++++++++++++++++++++++
 drivers/dma/dmaengine.c       |   2 +
 drivers/dma/xgene-dma.c       | 317 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/dmaengine.h     |   5 +
 8 files changed, 575 insertions(+), 15 deletions(-)
 create mode 100755 drivers/crypto/xgene-crc32c.c

--
1.8.2.1
