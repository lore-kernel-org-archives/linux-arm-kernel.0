From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  2 Sep 2016 14:42:27 +0200
Subject: mtd: nand: automate NAND timings selection
Message-ID: <1472820149-24241-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series aims at automating the NAND timings selection which is
currently supposed to be done in each NAND controller driver, thus
simplifying drivers implementation.

Patch 1 also opens the door to DDR NAND support, though setting DDR
timings is currently not supported.

I picked this up from earlier work from Boris Brezillon
(https://lkml.org/lkml/2015/10/23/179). Changes since the initial
posting from Boris:

- Integrate Feedback from Ezequiel Garcia
- When iterating over the chips calling onfi_set_features() for each
  bail out when any of the calls fail, not only the last one.
- When one of the onfi_set_features() calls fail then reset the chip
  afterwards.
- Drop Sunxi example, add patch for the mxc_nand controller instead.

Sascha
