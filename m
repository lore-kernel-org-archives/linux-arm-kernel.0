From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Sat, 29 Nov 2014 21:14:09 +0100
Subject: [PATCH v3 0/3] SoCFPGA: L3 NIC driver
Message-ID: <1417292052-12974-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This series adds support for the SoCFPGA L3 NIC. As the memory range has
a lot of holes, where you can not read from, syscon can not be used for
this IP core. Instead add a new driver, that knows about all the allowed
ranges and guards the access via regmap.

Changes in v3:

	- Split out the devicetree binding in its own patch

Regards,
Steffen

Steffen Trumtrar (3):
  Documentation: dt: add Altera L3 NIC bindings
  ARM: socfpga: Add driver for the L3 interconnect
  ARM: dts: socfpga: Add l3nic node

 .../bindings/soc/socfpga/altr,l3-nic.txt           |  15 ++
 arch/arm/boot/dts/socfpga.dtsi                     |   5 +
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/socfpga/Kconfig                        |  10 +
 drivers/soc/socfpga/Makefile                       |   1 +
 drivers/soc/socfpga/l3nic.c                        | 221 +++++++++++++++++++++
 include/soc/socfpga/gpv.h                          |  63 ++++++
 include/soc/socfpga/l3regs.h                       | 192 ++++++++++++++++++
 9 files changed, 509 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/socfpga/altr,l3-nic.txt
 create mode 100644 drivers/soc/socfpga/Kconfig
 create mode 100644 drivers/soc/socfpga/Makefile
 create mode 100644 drivers/soc/socfpga/l3nic.c
 create mode 100644 include/soc/socfpga/gpv.h
 create mode 100644 include/soc/socfpga/l3regs.h

-- 
2.1.3
