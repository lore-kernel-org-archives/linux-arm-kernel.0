From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  7 Jul 2015 17:08:23 +0200
Subject: [PATCH v2 0/4] mtd: pxa3xx_nand: rework the timing setup
Message-ID: <1436281707-20106-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series was part of a bigger one[1], which was split into smaller
ones as asked by Ezequiel[2]. When we take this into account, this is
v7. In addition, there was absolutely no comment for more than 1 month
(since June 2nd). Given this, I really expect the series to be merge
soon as other series are based on this.

The aim here is to use the nand framework to setup the timings,
while keeping the old in-driver way of configuration timings for
compatibility reasons.

Since v1:
	- Rebased on top of v4.2-rc1

Since the series was split up:
        - reworked the ndcr setup
        - removed the read_id_bytes update after device detection

[1] https://lkml.org/lkml/2015/5/11/495
[2] https://lkml.org/lkml/2015/5/16/309

Antoine Tenart (4):
  mtd: pxa3xx_nand: add a default chunk size
  mtd: pxa3xx_nand: add helpers to setup the timings
  mtd: pxa3xx_nand: rework flash detection and timing setup
  mtd: pxa3xx_nand: clean up the pxa3xx timings

 drivers/mtd/nand/pxa3xx_nand.c                | 251 ++++++++++++++------------
 include/linux/platform_data/mtd-nand-pxa3xx.h |  11 +-
 2 files changed, 143 insertions(+), 119 deletions(-)

-- 
2.4.5
