From: wangzhou.bry@gmail.com (Zhou Wang)
Date: Tue, 15 Jul 2014 18:58:23 +0800
Subject: [PATCH v1 0/3] mtd: hisilicon: add a new driver for NAND controller
 of hisilicon hip04 Soc
Message-ID: <1405421906-660-1-git-send-email-wangzhou.bry@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series patches add the support for NAND controller of hisilicon
hip04 Soc. These patches are base on branch integration-hilt-working-v3.14 
in linaro landing-team git repository[1].

The NAND controller IP was developed by hisilicon and need a new driver
to support. The driver is usable and I tested it on hisilicon hip04-d01
board.

Changes in v1:
- Remove callback functions out of struct hinfc_host, and call them directly
  in relative functions.
- Change hinfc_read and hinfc_write from macros to inline functions.
- Instead of putting pointers, embed struct nand_chip and struct mtd_info in
  struct hinfc_host directly.
- rewrite some unclear lines in device tree binding document, correct some
  code style error.

[1] ssh://git at git.linaro.org/landing-teams/working/hisilicon/kernel.git


Zhou Wang (3):
  mtd: hisilicon: add device tree node for nand controller
  mtd: hisilicon: add a new nand controller driver for hisilicon hip04 Soc
  mtd: hisilicon: add device tree binding documentation

 .../devicetree/bindings/mtd/hisi-nand.txt          |   40 +
 arch/arm/boot/dts/hip04.dtsi                       |   31 +
 drivers/mtd/nand/Kconfig                           |    5 +
 drivers/mtd/nand/Makefile                          |    1 +
 drivers/mtd/nand/hisi_nand.c                       |  836 ++++++++++++++++++++
 5 files changed, 913 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/hisi-nand.txt
 create mode 100644 drivers/mtd/nand/hisi_nand.c

-- 
1.7.9.5
