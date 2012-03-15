From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Mar 2012 16:57:16 +0100
Subject: [PATCH 0/6] AT91 drivers Kconfig cleanup
Message-ID: <cover.1331826095.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a series which deals with AT91 drivers Kconfig entries. Its goal is
to remove too restrictive dependencies on SoC names.
This will allow to add support for newer SoC seamlessly.

One question remains: should I submit those patches through dedicated
sub-maintainer's git trees or can I queue the whole series in arm-soc?

Nicolas Ferre (6):
  dmaengine: Kconfig: fix Atmel at_hdmac entry
  mmc: Kconfig: remove choice between at91_mci and atmel-mci
  mmc: atmel-mci: remove the need for CONFIG_MMC_ATMELMCI_DMA
  rtc: Kconfig: remove dependency for AT91 rtc driver
  Input: Kconfig: remove dependency for atmel_tsadcc driver
  hwrng: Kconfig: remove dependency for atmel-rng driver

 drivers/char/hw_random/Kconfig    |    2 +-
 drivers/dma/Kconfig               |    5 ++---
 drivers/input/touchscreen/Kconfig |    4 ++--
 drivers/mmc/host/Kconfig          |   23 ++---------------------
 drivers/mmc/host/atmel-mci.c      |    2 --
 drivers/rtc/Kconfig               |    2 +-
 6 files changed, 8 insertions(+), 30 deletions(-)

Best regards,
-- 
1.7.9
