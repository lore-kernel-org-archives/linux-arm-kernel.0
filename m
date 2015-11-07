From: rsahu@apm.com (Rameshwar Prasad Sahu)
Date: Sat,  7 Nov 2015 22:07:03 +0530
Subject: [PATCH v2 0/3] dmaengine: Add supports for APM X-Gene SoC CRC32C
 accerlerator driver
Message-ID: <1446914226-23402-1-git-send-email-rsahu@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements support for APM X-Gene SoC CRC32C h/w accelerator driver
and adds CRC32C computations support in dmaengine framework. APM X-Gene SoC has
DMA engine capable of performing CRC32C computations.

v2 changes:
	1. Added helper function in dmaengine framework
	2. Documented CRC32C support in Documentations/dmaengine/provider.txt
	3. Fixed algo name
	4. Fixed coding style issues

Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
---

Rameshwar Prasad Sahu (3):
  dmaengine: Add support for new feature CRC32C computations
  dmaengine: xgene-dma: Add support for CRC32C computations via DMA
    engine
  Crypto: Add support for APM X-Gene SoC CRC32C h/w accelerator driver

 Documentation/dmaengine/provider.txt |    3 +
 drivers/crypto/Kconfig               |    8 +
 drivers/crypto/Makefile              |    1 +
 drivers/crypto/xgene-crc32c.c        |  234 +++++++++++++++++++++++++
 drivers/dma/dmaengine.c              |    2 +
 drivers/dma/xgene-dma.c              |  314 ++++++++++++++++++++++++++++++++--
 include/linux/dmaengine.h            |   13 ++
 7 files changed, 560 insertions(+), 15 deletions(-)
 create mode 100755 drivers/crypto/xgene-crc32c.c
