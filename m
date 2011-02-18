From: leiwen@marvell.com (Lei Wen)
Date: Fri, 18 Feb 2011 16:57:02 +0800
Subject: [PATCH V4 0/6] pxa3xx_nand update series set version 4
Message-ID: <1298019428-7809-1-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change from previous version:
rework the patch set accroding to Eric's suggestion.
Move the recode judgement to the after command execution.

Lei Wen (6):
  pxa3xx_nand: make scan procedure more clear
  pxa3xx_nand: rework irq logic
  pxa3xx_nand: discard wait_for_event,write_cmd,__readid function
  pxa3xx_nand: unify prepare command
  pxa3xx_nand: mtd scan id process could be defined by driver itself
  pxa3xx_nand: clean the keep configure code

 arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |    1 +
 drivers/mtd/nand/pxa3xx_nand.c               | 1010 ++++++++++++--------------
 2 files changed, 473 insertions(+), 538 deletions(-)
