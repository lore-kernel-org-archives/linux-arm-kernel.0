From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  2 Dec 2015 12:01:04 +0100
Subject: [PATCH v2 0/3] mtd: nand: add randomizer support
Message-ID: <1449054067-16751-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series is a proposal to add support for randomizers (either software
or hardware) to NAND flash controller drivers.

The last patch is the sunxi HW randomizer implementation and is just given
as an example (it won't apply on the MTD tree, because it depends on other
stuff not yet posted on the MTD ML, but if you want a full overview of the
NAND Flash controller driver you can take a look at this series [2]).

I can also provide a software implementation based on LFSR (Left Feedback
Shift Register) algorithm, thought I haven't tested it yet, hence why it's
not part of this series. Let me know if you're interested in this
implementation.

This series depends on the "per-partition ECC" series [1], because I need
the randomizer seed to be different depending on the partition (for the
same reason I needed ECC config to be different for each partition: the
bootrom config might not fit the NAND chip requirements).

I'd like to have feedback from both MTD maintainers and driver
developers who might need to implement (or use) a randomizer in their
system, so feel free to comment on this series.

Best Regards,

Boris

[1] https://lkml.org/lkml/2014/2/12/627
[2] https://groups.google.com/forum/#!msg/linux-sunxi/s3lBb01I0Js/z2NoCFJ83g4J 

Changes since v1:
- add some comments to explain how the sunxi randomizer works
- fix a few minor bugs and coding style issues

Boris Brezillon (3):
  mtd: nand: add NAND_NEED_SCRAMBLING option flag
  mtd: nand: add NAND_NEED_SCRAMBLING flag to the H27UCG8T2ATR-BC
    definition
  mtd: nand: sunxi: add randomizer support

 drivers/mtd/nand/nand_ids.c   |   4 +-
 drivers/mtd/nand/sunxi_nand.c | 287 ++++++++++++++++++++++++++++++++++++++----
 include/linux/mtd/nand.h      |   6 +
 3 files changed, 269 insertions(+), 28 deletions(-)

-- 
2.1.4
