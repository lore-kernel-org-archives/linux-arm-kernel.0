From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Thu, 28 May 2015 14:52:06 -0700
Subject: [PATCHv3 0/2] Adding driver for Xilinx LogiCORE IP mailbox.
Message-ID: <1432849928-25457-1-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds mailbox framework integration for the Xilinx LogiCORE IP
mailbox.  The Xilinx LogiCORE IP mailbox is a fpga softcore that allows
interprocessor communication between AXI4 stream / memory mapped
processors.

Changes from v1:
- Fixed error condition for IRQ from >= 0 to > 0
- Fixed clock enable
- Cleaned up docs

Changes from v1:
- Added common clock framework support
- Deal with IRQs that happend before driver load,
  since HW will not let us know about them when we enable IRQs

Changes from v0:
- Several stylistic issues
- Dropped superfluous intr_mode member
- Really masking the IRQs on mailbox_shutdown
- No longer using polling by accident in non-IRQ mode
- Swapped doc and driver commits

Moritz Fischer (2):
  dts: Adding docs for Xilinx LogiCORE IP mailbox driver.
  mailbox: Adding driver for Xilinx LogiCORE IP mailbox.

 .../bindings/mailbox/xilinx-mailbox.txt         |  44 +++
 MAINTAINERS                                     |   7 +
 drivers/mailbox/Kconfig                         |   8 +
 drivers/mailbox/Makefile                        |   2 +
 drivers/mailbox/mailbox-xilinx.c                | 353 +++++++++++++++++++
 5 files changed, 414 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
 create mode 100644 drivers/mailbox/mailbox-xilinx.c

-- 
2.4.1
