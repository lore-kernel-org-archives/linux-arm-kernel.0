From: samuel@sholland.org (Samuel Holland)
Date: Tue, 27 Feb 2018 20:27:11 -0600
Subject: [PATCH 0/3] Allwinner sunxi message box support
Message-ID: <20180228022714.30068-1-samuel@sholland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the "hardware message box" in recent
Allwinner sunxi SoCs, used for communication with the ARISC management
processor (the platform's equivalent of the ARM SCP). The end goal is to
use the arm_scpi driver as a client, communicating with firmware running
on the ARISC CPU.

This driver has been tested with the base arm_scpi driver (which sends
the SCPI_CMD_SCPI_CAPABILITIES command at probe time) and an in-progress
firmware application running on the ARISC CPU. Because no firmware for
the other end of the mailbox is complete at the moment, I have not
included changes to the SoC device trees.

The second patch in the series fixes an issue in the mailbox framework
discovered while writing this driver. It is a re-send of a patch I
originally sent by itself in January.

Samuel Holland (3):
  dt-bindings: Add a binding for the sunxi message box
  mailbox: Avoid NULL dereference in mbox_chan_received_data
  mailbox: sunxi-msgbox: Add a new mailbox driver

 .../devicetree/bindings/mailbox/sunxi-msgbox.txt   |  40 +++
 drivers/mailbox/Kconfig                            |   7 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/mailbox.c                          |   6 +-
 drivers/mailbox/sunxi-msgbox.c                     | 323 +++++++++++++++++++++
 5 files changed, 376 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
 create mode 100644 drivers/mailbox/sunxi-msgbox.c

-- 
2.13.6
