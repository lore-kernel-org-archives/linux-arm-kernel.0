From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Thu, 21 May 2015 16:37:27 -0700
Subject: [PATCH 0/3] Adding driver for Xilinx LogiCORE IP mailbox.
Message-ID: <1432251450-26352-1-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds mailbox framework integration for the Xilinx LogiCORE IP
mailbox.  The Xilinx LogiCORE IP mailbox is a fpga softcore that allows
interprocessor communication between AXI4 stream / memory mapped
processors.

It has been tested with the version 2.1 of the core built with
Vivado 2014.4, running on a Zynq 7020.

If Michal or S?ren could look it over that would be great.

Cheers,

Moritz



Moritz Fischer (3):
  mailbox: Adding driver for Xilinx LogiCORE IP mailbox.
  dts: Adding docs for Xilinx LogiCORE IP mailbox driver.
  MAINTAINERS: Add entry for xilinx mailbox driver.

 .../bindings/mailbox/xilinx-mailbox.txt         |  40 +++
 MAINTAINERS                                     |   7 +
 drivers/mailbox/Kconfig                         |   8 +
 drivers/mailbox/Makefile                        |   2 +
 drivers/mailbox/mailbox-xilinx.c                | 339 +++++++++++++++++++
 5 files changed, 396 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
 create mode 100644 drivers/mailbox/mailbox-xilinx.c

-- 
2.4.1
