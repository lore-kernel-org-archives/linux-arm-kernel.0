From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 9 May 2013 15:34:53 +0800
Subject: [PATCH 0/2] atmel_nand: remove cpu_is_xxx() in nand driver
Message-ID: <1368084895-18266-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

avoid to use cpu_is_xxx() macro in driver, we use platform data and dts
for the different cpu.

Josh Wu (2):
  atmel_nand: at91/avr32/: Replace cpu_is_at32ap7000() with a nand
    platform data
  mtd: atmel_nand: add a new dt binding item for nand dma support

 .../devicetree/bindings/mtd/atmel-nand.txt         |    1 +
 arch/avr32/mach-at32ap/at32ap700x.c                |    3 +++
 drivers/mtd/nand/atmel_nand.c                      |   24 ++++++++------------
 include/linux/platform_data/atmel.h                |    4 ++++
 4 files changed, 17 insertions(+), 15 deletions(-)

-- 
1.7.9.5
