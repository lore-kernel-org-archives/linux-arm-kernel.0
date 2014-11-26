From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 26 Nov 2014 17:53:10 +0100
Subject: [PATCH v5 0/3] mtd: nand: gpmi: add proper raw access support
Message-ID: <1417020793-3354-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series provides an implementation for raw accesses taking care of
hidding the specific layout used by the GPMI controller.

Best Regards,

Boris

Changes since v4:
 - fixed a few corner cases in gpmi_move_bits (tested it with:
   https://github.com/bbrezillon/gpmi-move-bits-test/blob/master/gpmi-move-bits-test.c)
 - add documentation and comments for the new gpmi functions

Changes since v3:
 - add comments to the gpmi_move_bits function
 - extend raw read/write documentation
 - move last part of the raw_page_read function into a conditional block

Changes since v2:
 - fixed a bug in gpmi_move_bits
 - add a raw_buffer field to be used when using raw access methods
   (experienced memory corruptions when directly using page_buffer_virt
   buffer)
 - add raw OOB access functions


Boris Brezillon (3):
  mtd: nand: gpmi: add gpmi_move_bits function
  mtd: nand: gpmi: add proper raw access support
  mtd: nand: gpmi: add raw oob access functions

 drivers/mtd/nand/gpmi-nand/gpmi-lib.c  | 151 +++++++++++++++++++++++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 201 +++++++++++++++++++++++++++++++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |   6 +
 3 files changed, 358 insertions(+)

-- 
1.9.1
