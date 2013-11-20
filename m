From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Wed, 20 Nov 2013 18:24:56 +0200
Subject: [PATCH 0/3] Reuse davinci-nand driver for Keystone arch
Message-ID: <1384964699-15134-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains updates of Davinci nand driver, in order to be
reused for Keystone platform.

Depends on:
- Davinci nand driver fixes and updates:
  https://lkml.org/lkml/2013/11/20/271

- Introduce AEMIF driver for Davinci/Keystone archs:
  http://lkml.org/lkml/2013/11/11/352

V1:
https://lkml.org/lkml/2013/11/11/352

Ivan Khoronzhuk (3):
  mtd: nand: davinci: reuse driver for Keystone arch
  mtd: nand: davinci: don't set timings if AEMIF is used
  mtd: nand: davinci: don't request AEMIF address range

 .../devicetree/bindings/mtd/davinci-nand.txt       |    8 +--
 drivers/mtd/nand/Kconfig                           |    6 +--
 drivers/mtd/nand/davinci_nand.c                    |   57 +++++++++++++-------
 3 files changed, 45 insertions(+), 26 deletions(-)

-- 
1.7.9.5
