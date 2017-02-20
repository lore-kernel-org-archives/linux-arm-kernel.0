From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 20 Feb 2017 22:12:26 +0100
Subject: [RESEND PATCH 0/3] mtd: nand: atmel: Add ->setup_data_interface() +
 PM ops
Message-ID: <1487625149-7234-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Hopefully the last resend. I double checked everything this time :-).

This patch series is adding to important features to the new Atmel NAND
controller driver:
1/ automatic SMC timings configuration based on information retrieved
   during NAND detection
2/ proper ->suspend()/->resume(). Timings are properly restored when
   resuming the system

This series depends on [1] and [2].

Regards,

Boris

[1]https://www.spinics.net/lists/arm-kernel/msg563780.html
[2]https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1337235.html

Boris Brezillon (3):
  mtd: nand: Pass the CS line to ->setup_data_interface()
  mtd: nand: atmel: Add ->setup_data_interface() hooks
  mtd: nand: atmel: Add PM ops

 drivers/mtd/nand/atmel/nand-controller.c | 351 ++++++++++++++++++++++++++++++-
 drivers/mtd/nand/mxc_nand.c              |  12 +-
 drivers/mtd/nand/nand_base.c             |  22 +-
 drivers/mtd/nand/s3c2410.c               |   5 +-
 drivers/mtd/nand/sunxi_nand.c            |   7 +-
 drivers/mtd/nand/tango_nand.c            |   7 +-
 include/linux/mtd/nand.h                 |  12 +-
 7 files changed, 380 insertions(+), 36 deletions(-)

-- 
2.7.4
