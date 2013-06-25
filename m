From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Jun 2013 15:11:55 +0200
Subject: [GIT PULL] ux500 DMA40 fixes for next/drivers
Message-ID: <CACRpkdY_RyTW1kEUpUKbP9hpt-9pvG=e00mCMDvr5fyYuQFU7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here are some fixes for the DMA40 patch stack that is currently
boiling in next/drivers. They are of such type that they can go in
per immediately or at -rc1.

I tested to merge this into next/drivers and it seems to go in
smoothly.

Please pull it in at your convenience.

Yours,
Linus Walleij

The following changes since commit 499c2bc3cc89dcbbf08aa526cd4a984b92a4d2a8:

  dmaengine: ste_dma40: Fetch disabled channels from DT (2013-06-04
11:12:12 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-dma40-for-arm-soc-3

for you to fetch changes up to 06568483297739f6ce8f2d25983f88dd8b563a9d:

  crypto: ux500: use dmaengine_submit API (2013-06-25 14:51:34 +0200)

----------------------------------------------------------------
DMA40 fixes for earlier submitted driver patches:
- Fix various error path and sparse bugs in the DMA40 driver
- Fix various compile errors in the ux500 crypto driver
  (dependent on the DMA40 changes).

----------------------------------------------------------------
Fabio Baltieri (7):
      dmaengine: ste_dma40: Declare memcpy config as static
      crypto: ux500/hash: use readl on iomem addresses
      crypto: ux500/hash: add missing static qualifiers
      crypto: ux500/crypt: add missing __iomem qualifiers
      crypto: ux500: use dmaengine_device_control API
      crypto: ux500: use dmaengine_prep_slave_sg API
      crypto: ux500: use dmaengine_submit API

Wei Yongjun (1):
      dmaengine: ste_dma40: fix error return code in d40_probe()

 drivers/crypto/ux500/cryp/cryp.c      |  4 ++--
 drivers/crypto/ux500/cryp/cryp_core.c | 26 +++++++++++++-------------
 drivers/crypto/ux500/hash/hash_core.c | 33 ++++++++++++++++-----------------
 drivers/dma/ste_dma40.c               | 18 +++++++++---------
 4 files changed, 40 insertions(+), 41 deletions(-)
