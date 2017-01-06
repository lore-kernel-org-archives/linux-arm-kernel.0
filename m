From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  6 Jan 2017 10:42:04 +0100
Subject: [PATCH 0/3] mtd: nand: sunxi: Perfs improvements
Message-ID: <1483695727-17415-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

These 3 patches aims at improving the sunxi NAND driver perfs and
avoiding busy waits on long operations to improve system reactivity.

Regards,

Boris

Boris Brezillon (3):
  mtd: nand: sunxi: Fix the non-polling case in sunxi_nfc_wait_events()
  mtd: nand: sunxi: Stop using polling mode when waiting for long
    operations
  mtd: nand: sunxi: Improve sunxi_nfc_cmd_ctrl()

 drivers/mtd/nand/sunxi_nand.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

-- 
2.7.4
