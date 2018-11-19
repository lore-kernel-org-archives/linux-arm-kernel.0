From: wendy.liang@xilinx.com (Wendy Liang)
Date: Mon, 19 Nov 2018 13:25:59 -0800
Subject: [PATCH v6 0/2] Xilinx ZynqMP IPI Mailbox Controller Driver
Message-ID: <1542662761-31158-1-git-send-email-wendy.liang@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce mailbox controller driver for ZynqMP IPI(Inter-processor
interrupt) IP core.

As the device tree bindings have been updated. Do not have "Reviewed-by"
nor "Acked-by" in the dt-bindings commit.

v6:
 - dts-binding, remove compatible property from IPI subnode

v5:
 - fix check patch warning on write a paragraph to describe the kconfig
   symbol.

v4:
 - make IPI mailboxes as subnodes to the IPI agent device node to properly
   describe the hardware.

v3:
 - add NULL entry to of_device_id of IPI controller

v2:
 - change SPDX-License-Identifier license text style in .c file
 - replace xlnx-ipi-ids with xlnx,ipi-ids


Wendy Liang (2):
  mailbox: ZynqMP IPI mailbox controller
  dt-bindings: mailbox: Add Xilinx IPI Mailbox

 .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 127 ++++
 drivers/mailbox/Kconfig                            |   9 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/zynqmp-ipi-mailbox.c               | 762 +++++++++++++++++++++
 include/linux/mailbox/zynqmp-ipi-message.h         |  24 +
 5 files changed, 924 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
 create mode 100644 drivers/mailbox/zynqmp-ipi-mailbox.c
 create mode 100644 include/linux/mailbox/zynqmp-ipi-message.h

-- 
2.7.4
