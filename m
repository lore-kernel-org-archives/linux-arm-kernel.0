From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 29 Apr 2017 10:52:33 +0200
Subject: [PATCH v2 0/3] mtd: nand: fsmc: support SDR timing configuration
Message-ID: <1493455956-18362-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series add support for configuring the FSMC NAND controller
timings according to the SDR timings exposed by the NAND chip.

Changes since v1:

 - Dropped all patches from the series that have already been merged
   in nand/next.

 - Rework the implementation as suggested by Boris Brezillon, i.e by
   implementing ->setup_data_interface() only when we are going to use
   the NAND SDR timings. If there is a "timings" DT property, we keep
   using the old strategy without ->setup_data_interface().

The patch series is based on the nand/next branch.

Best regards,

Thomas

Thomas Petazzoni (3):
  mtd: nand: fsmc: reduce number of arguments of fsmc_nand_setup()
  mtd: nand: fsmc: add support for SDR timings
  mtd: nand: fsmc: remove default timings

 drivers/mtd/nand/fsmc_nand.c | 120 +++++++++++++++++++++++++++++++++----------
 1 file changed, 94 insertions(+), 26 deletions(-)

-- 
2.7.4
