From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 23 Sep 2014 16:07:33 +0200
Subject: [PATCH v3 0/3] mtd: nand: gpmi: add proper raw access support
Message-ID: <1411481256-29141-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Huang, Brian,

This is just a new proposal to support raw accesses in a more standard way
in the GPMI driver.
This series has been tested on an imx28 board.

Any suggestions are welcome.

Best Regards,

Boris

Changes since v2:
 - fixed a bug in gpmi_move_bits
 - add a raw_buffer field to be used when using raw access methods
   (experienced memory corruptions when directly using page_buffer_virt
   buffer)
 - add raw OOB access functions

Boris BREZILLON (3):
  mtd: nand: gpmi: add gpmi_move_bits function
  mtd: nand: gpmi: add proper raw access support
  mtd: nand: gpmi: add raw oob access functions

 drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |  88 ++++++++++++++++++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 144 +++++++++++++++++++++++++++++++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |   6 ++
 3 files changed, 238 insertions(+)

-- 
1.9.1
