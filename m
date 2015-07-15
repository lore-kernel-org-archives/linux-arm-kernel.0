From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Tue, 14 Jul 2015 18:00:20 -0700
Subject: [PATCHv7 0/2] Adding driver for Xilinx LogiCORE IP mailbox.
Message-ID: <1436922022-17564-1-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Thanks for hanging in there, hopefully the last round of review ...

This patchset adds mailbox framework integration for the Xilinx LogiCORE IP
mailbox.  The Xilinx LogiCORE IP mailbox is a fpga softcore that allows
interprocessor communication between AXI4 stream / memory mapped
processors.

Cheers,

Moritz

Changes from v6:
- As suggested by Jassi and S?ren use #mbox-cells = <1>

Changes from v5:
- Fixed constness for ops struct
- Removed redundant checks
- Moved ops assignment
- Removed MODULE_ALIAS

Changes from v4:
- Have separate mbox_ops structs for polling / irq mode
- Moved clk handling to startup / shutdown
- Embedded struct mbox_chan in struct xilinx_mbox
- Fixed mbox-cells in devicetree documentation
- Misc stylistic issues

Changes from v3:
- Stylistic changes
- Changed reg size in dts to 0x100

Changes from v2:
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

 .../devicetree/bindings/mailbox/xilinx-mailbox.txt |  44 +++
 MAINTAINERS                                        |   7 +
 drivers/mailbox/Kconfig                            |   7 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/mailbox-xilinx.c                   | 367 +++++++++++++++++++++
 5 files changed, 427 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
 create mode 100644 drivers/mailbox/mailbox-xilinx.c

-- 
2.4.3
