From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Fri, 22 May 2015 11:03:09 -0700
Subject: [PATCHv1 0/2] Adding driver for Xilinx LogiCORE IP mailbox.
Message-ID: <1432317791-26851-1-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds mailbox framework integration for the Xilinx LogiCORE IP
mailbox.  The Xilinx LogiCORE IP mailbox is a fpga softcore that allows
interprocessor communication between AXI4 stream / memory mapped
processors.

Changes from v0:
---------------------

- Several stylistic issues
- Dropped superfluous intr_mode member
- Really masking the IRQs on mailbox_shutdown
- No longer using polling by accident in non-IRQ mode
- Swapped doc and driver commits

Thanks to Michal and Shubrajyoti for the feedback.

Cheers,

Moritz

Moritz Fischer (2):
  dts: Adding docs for Xilinx LogiCORE IP mailbox driver.
  mailbox: Adding driver for Xilinx LogiCORE IP mailbox.

 .../bindings/mailbox/xilinx-mailbox.txt         |  40 +++
 MAINTAINERS                                     |   7 +
 drivers/mailbox/Kconfig                         |   8 +
 drivers/mailbox/Makefile                        |   2 +
 drivers/mailbox/mailbox-xilinx.c                | 332 +++++++++++++++++++
 5 files changed, 389 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
 create mode 100644 drivers/mailbox/mailbox-xilinx.c

-- 
2.4.1
