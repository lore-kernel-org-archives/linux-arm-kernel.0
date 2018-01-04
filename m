From: wendy.liang@xilinx.com (Wendy Liang)
Date: Thu, 4 Jan 2018 15:51:29 -0800
Subject: [PATCH v3 0/2] Xilinx ZynqMP IPI Mailbox Controller Driver
Message-ID: <1515109891-17133-1-git-send-email-jliang@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce mailbox controller driver for ZynqMP IPI(Inter-processor
interrupt) IP core.

There is previous discussion on the DT bindings:
https://patchwork.kernel.org/patch/10012755/

v3:
 - add NULL entry to of_device_id of IPI controller

v2:
 - change SPDX-License-Identifier license text style in .c file
 - replace xlnx-ipi-ids with xlnx,ipi-ids

Wendy Liang (2):
  mailbox: ZynqMP IPI mailbox controller
  dt-bindings: mailbox: Add Xilinx IPI Mailbox

 .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 104 ++++
 drivers/mailbox/Kconfig                            |   8 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/zynqmp-ipi-mailbox.c               | 635 +++++++++++++++++++++
 include/linux/mailbox/zynqmp-ipi-message.h         |  24 +
 5 files changed, 773 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
 create mode 100644 drivers/mailbox/zynqmp-ipi-mailbox.c
 create mode 100644 include/linux/mailbox/zynqmp-ipi-message.h

-- 
2.7.4
