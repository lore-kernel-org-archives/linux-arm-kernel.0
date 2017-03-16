From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 16 Mar 2017 09:35:57 +0100
Subject: [PATCH v2 0/3] mtd: nand: atmel: Add ->setup_data_interface() + PM ops
Message-ID: <1489653360-17973-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Sorry for the noise, but I forgot to remove old patches before using
git send-email on the directory containing the patches generated with
git format-patch :-/.

This patch series is adding to important features to the new Atmel NAND
controller driver:
1/ automatic SMC timings configuration based on information retrieved
   during NAND detection
2/ proper ->suspend()/->resume(). Timings are properly restored when
   resuming the system

This series depends on [1] and [2].

Regards,

Boris

Changes since v1:
- check if tdf value is at least equal to ATMEL_SMC_MODE_TDF_MIN

[1]https://www.spinics.net/lists/arm-kernel/msg563780.html
[2]https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1337235.html

Boris Brezillon (3):
  mtd: nand: Pass the CS line to ->setup_data_interface()
  mtd: nand: atmel: Add ->setup_data_interface() hooks
  mtd: nand: atmel: Add PM ops

 drivers/mtd/nand/Kconfig                 |   1 +
 drivers/mtd/nand/atmel/nand-controller.c | 347 ++++++++++++++++++++++++++++++-
 drivers/mtd/nand/mxc_nand.c              |  12 +-
 drivers/mtd/nand/nand_base.c             |  22 +-
 drivers/mtd/nand/s3c2410.c               |   5 +-
 drivers/mtd/nand/sunxi_nand.c            |   7 +-
 drivers/mtd/nand/tango_nand.c            |   7 +-
 include/linux/mtd/nand.h                 |  12 +-
 8 files changed, 380 insertions(+), 33 deletions(-)

-- 
2.7.4
