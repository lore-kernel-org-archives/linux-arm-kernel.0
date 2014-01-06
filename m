From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  6 Jan 2014 15:36:36 +0100
Subject: [PATCH 0/7] Xilinx Zynq SLCR changes
Message-ID: <cover.1389018985.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have rebased and added together patches I have got from Steffen some time ago.
Steffen: I kept there your SoB. Please let me know if there is any problem
with it.

The point of this series is to use slcr as system controller
to be able to create other drivers like pinmux, etc.

These patches are based on zynq/cleanup and zynq/dt branches merged
together. (They are available in arm-soc git tree).
Let me know if you want to add the branch somewhere.

Arnd: We talked at KS about syscon early initialization which
will be really helpful for this case. Has someone done any work
around it?

Thanks,
Michal


Michal Simek (4):
  ARM: zynq: Split slcr in two parts
  ARM: zynq: Map I/O memory on clkc init
  ARM: zynq: Add and use zynq_slcr_read/write() helper functions
  ARM: zynq: Introduce zynq_slcr_unlock()

Steffen Trumtrar (3):
  ARM: zynq: Move clock_init from slcr to common
  ARM: zynq: Hang iomapped slcr address on device_node
  ARM: zynq: Make zynq_slcr_base static

 .../devicetree/bindings/clock/zynq-7000.txt        |  4 +-
 arch/arm/boot/dts/zynq-7000.dtsi                   | 42 +++++-----
 arch/arm/mach-zynq/Kconfig                         |  1 +
 arch/arm/mach-zynq/common.c                        |  6 +-
 arch/arm/mach-zynq/common.h                        |  2 +-
 arch/arm/mach-zynq/slcr.c                          | 98 +++++++++++++++++++---
 drivers/clk/zynq/clkc.c                            | 89 ++++++++++++++------
 include/linux/clk/zynq.h                           |  2 +-
 8 files changed, 179 insertions(+), 65 deletions(-)

--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140106/9c62af17/attachment.sig>
