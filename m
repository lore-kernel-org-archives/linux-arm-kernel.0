From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:11:09 +0100
Subject: [PATCH v1 24/24] doc: zynq: Add information on zynq u-boot
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <245aa93cbcfe8106fea8107c7d362a966b3ef6ff.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagannadha Sutradharudu Teki <jagannadha.sutradharudu-teki@xilinx.com>

Information on zynq u-boot about
- mainline status
- TODO

Signed-off-by: Jagannadha Sutradharudu Teki <jaganna@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>

---

Changes in v1:
- Update to the latest status

 doc/README.zynq | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 doc/README.zynq

diff --git a/doc/README.zynq b/doc/README.zynq
new file mode 100644
index 0000000..c046df4
--- /dev/null
+++ b/doc/README.zynq
@@ -0,0 +1,76 @@
+#
+# Xilinx ZYNQ U-Boot
+#
+# (C) Copyright 2013 Xilinx, Inc.
+#
+# SPDX-License-Identifier:	GPL-2.0+
+#
+
+1. About this
+
+This document describes the information about Xilinx Zynq U-Boot -
+like supported boards, ML status and TODO list.
+
+2. Zynq boards
+
+Xilinx Zynq-7000 All Programmable SoCs enable extensive system level
+differentiation, integration, and flexibility through hardware, software,
+and I/O programmability.
+
+3. Building
+
+ # Configure for microzed board
+   $ make zynq_config
+     Configuring for zynq board...
+
+ # Building with zynq generic DTS file
+   $ make
+
+ # Building with different DTS file placed in board/xilinx/dts/
+   $ make DEVICE_TREE=zynq-XXX
+
+4. Bootmode
+
+Zynq has a facility to read the bootmode from the slcr bootmode register
+once user is setting through jumpers on the board - see page no:1546 on [5]
+
+All possible bootmode values are defined in Table 6-2:Boot_Mode MIO Pins
+on [5].
+
+board_late_init() will read the bootmode values using slcr bootmode register
+at runtime and assign the modeboot variable to specific bootmode string which
+is intern used in autoboot.
+
+SLCR bootmode register Bit[3:0] values
+#define ZYNQ_BM_NOR		0x02
+#define ZYNQ_BM_SD		0x05
+#define ZYNQ_BM_JTAG		0x0
+
+"modeboot" variable can assign any of "norboot", "sdboot" or "jtagboot"
+bootmode strings at runtime.
+
+5. Mainline status
+
+- Added basic board configurations support.
+- Added zynq u-boot bsp code - arch/arm/cpu/armv7/zynq
+- Added zynq boards names - zynq, zynq_dcc
+- Added zynq drivers:
+  serial - drivers/serial/serial_zynq.c
+  net - drivers/net/zynq_gem.c
+  mmc - drivers/mmc/zynq_sdhci.c
+  spi-  drivers/spi/zynq_spi.c
+  i2c - drivers/i2c/zynq_i2c.c
+- Done proper cleanups on board configurations
+- Added FDT support
+- d-cache support for zynq_gem.c
+
+6. TODO
+
+- Add zynq qspi controller driver
+- Add zynq nand controller driver
+
+[1] http://www.xilinx.com/products/boards-and-kits/EK-Z7-ZC702-G.htm
+[2] http://www.xilinx.com/products/boards-and-kits/EK-Z7-ZC706-G.htm
+[3] http://zedboard.org/product/zedboard
+[4] http://zedboard.org/product/microzed
+[5] http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/ca7688aa/attachment.sig>
