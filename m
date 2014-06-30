From: wangzhou.bry@gmail.com (Zhou Wang)
Date: Mon, 30 Jun 2014 16:03:26 +0800
Subject: [PATCH 0/3] mtd: hisilicon: add a new driver for NAND controller of
 hisilicon hip04 Soc
Message-ID: <1404115409-20200-1-git-send-email-wangzhou.bry@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series patches add the support for NAND controller of hisilicon
hip04 Soc. These patches are base on branch integration-hilt-working-v3.14 
in linaro landing-team git repository[1].

The NAND controller IP was developed by hisilicon and need a new driver
to support. The driver is usable and I tested it on hisilicon hip04-d01
board.

[1] ssh://git at git.linaro.org/landing-teams/working/hisilicon/kernel.git

Zhou Wang (3):
  mtd: hisilicon: add device tree node for nand controller
  mtd: hisilicon: add a new nand controller driver for hisilicon hip04
    Soc
  mtd: hisilicon: add device tree binding documentation

 .../devicetree/bindings/mtd/hisi-nand.txt          |   38 +
 arch/arm/boot/dts/hip04.dtsi                       |   31 +
 drivers/mtd/nand/Kconfig                           |    5 +
 drivers/mtd/nand/Makefile                          |    1 +
 drivers/mtd/nand/hisi_nand.c                       |  847 ++++++++++++++++++++
 5 files changed, 922 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/hisi-nand.txt
 create mode 100644 drivers/mtd/nand/hisi_nand.c

-- 
1.7.9.5
