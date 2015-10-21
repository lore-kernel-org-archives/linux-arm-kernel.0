From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 21 Oct 2015 10:28:59 +0200
Subject: [PATCH v4 0/5] mtd: pxa3xx_nand: rework the timing setup
Message-ID: <1445416144-9194-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Let's try one more time to get this merged.

This series was part of a bigger one[1], which was split into smaller
ones as asked by Ezequiel[2]. When we take this into account this is
v9; with a v1 sent in January, 9 months ago.

Another series, introducing the Berlin nand support, depends on this.

The aim here is to use the nand framework to setup the timings,
while keeping the old in-driver way of configuration timings for
compatibility reasons.

You can find the series at:
https://github.com/atenart/linux.git berlin/4.3/nand-timings

Antoine

Since v3:
        - Moved back a chunk into the right patch.
        - Called pxa3xx_nand_config_flash() before KEEP_CONFIG.
        - Rebased on top of l2-mtd.git master.

Since v2:
        - Added back the support for keep-config 16 bits devices
        - Fixed wrong unit in a calculation
        - Reworked the pxa3xx_nand_init_timings() logic
        - Allowed compile test the pxa3xx driver

Since v1:
        - Rebased on top of v4.2-rc1

Since the series was split up:
        - Reworked the ndcr setup
        - Removed the read_id_bytes update after device detection

Antoine Tenart (5):
  mtd: pxa3xx: prepare allowing compile test
  mtd: nand: allow compile test of MTD_NAND_PXA3xx
  mtd: pxa3xx_nand: add helpers to setup the timings
  mtd: pxa3xx_nand: rework flash detection and timing setup
  mtd: pxa3xx_nand: clean up the pxa3xx timings

 drivers/mtd/nand/Kconfig       |   2 +-
 drivers/mtd/nand/pxa3xx_nand.c | 274 +++++++++++++++++++++++++----------------
 2 files changed, 168 insertions(+), 108 deletions(-)

-- 
2.6.2
