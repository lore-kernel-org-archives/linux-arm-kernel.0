From: b32955@freescale.com (Huang Shijie)
Date: Wed, 25 Apr 2012 11:06:21 +0800
Subject: [PATCH v2 0/3] add gpmi-nand dt support for mx6q and mx28
Message-ID: <1335323184-11233-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mx6q-arm2 and imx28evk have already support the device tree now.
So i decide to add the gpmi-nand dt support to them.

The mx23 does not support the device tree now. I will add the gpmi dt support
when it is ready.

Test this patch set on both MX6Q(arm2) and mx28(evk).

v1 --> v2
	[1] merge the gpmi/bch device node into one node.
	[2] add partitions support.
	[3] misc

Huang Shijie (3):
  mtd: gpmi: add device tree support for mx6q and mx28
  ARM: mx28: add gpmi-nand dt support
  ARM: mx6q: add gpmi-nand dt support

 .../devicetree/bindings/mtd/gpmi-nand.txt          |   34 +++++
 arch/arm/boot/dts/imx28-evk.dts                    |    4 +
 arch/arm/boot/dts/imx28.dtsi                       |   18 ++--
 arch/arm/boot/dts/imx6q-arm2.dts                   |    4 +
 arch/arm/boot/dts/imx6q.dtsi                       |   12 ++
 arch/arm/mach-imx/clock-imx6q.c                    |    5 +-
 arch/arm/mach-mxs/clock-mx28.c                     |    2 +-
 drivers/mtd/nand/Kconfig                           |    2 +-
 drivers/mtd/nand/gpmi-nand/bch-regs.h              |   42 +++++--
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c              |   18 ++--
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c             |  131 ++++++++++----------
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h             |    6 +-
 include/linux/mtd/gpmi-nand.h                      |    8 +-
 13 files changed, 185 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/gpmi-nand.txt
