From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 13 Aug 2014 10:11:59 +0100
Subject: [PATCH 0/8] mtd: nand: Support for new DT NAND driver
Message-ID: <1407921127-8590-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian, Pekon,

I believe all of your queries have either been answered or addressed
and I am hoping this will be the last submission. :)

/me crosses fingers!

Kind regards,
Lee

Lee Jones (8):
  ARM: multi-v7: Enable ST BCH NAND
  ARM: sti: Add two new clock definitions for use with ST's NAND
    controllers
  ARM: sti: Add BCH (NAND Flash) Controller support for STiH41x (Orly)
    SoCs
  ARM: sti: Enable BCH NAND for STiH416 B2020-RevE
  mtd: nand: stm_nand_bch: provide Device Tree documentation
  mtd: nand: add shared register defines for ST's NAND Controller
    drivers
  mtd: nand: stm_nand_bch: add support for ST's BCH NAND controller
  mtd: nand: stm_nand_bch: provide ST's implementation of Back Block
    Table

 Documentation/devicetree/bindings/mtd/stm-nand.txt |   74 +
 arch/arm/boot/dts/stih416-b2020e.dts               |    8 +
 arch/arm/boot/dts/stih41x-b2020.dtsi               |   38 +
 arch/arm/configs/multi_v7_defconfig                |    2 +
 drivers/mtd/nand/Kconfig                           |   15 +
 drivers/mtd/nand/Makefile                          |    2 +
 drivers/mtd/nand/stm_nand_bbt.c                    |  601 ++++++++
 drivers/mtd/nand/stm_nand_bch.c                    | 1618 ++++++++++++++++++++
 drivers/mtd/nand/stm_nand_dt.c                     |  109 ++
 drivers/mtd/nand/stm_nand_dt.h                     |   24 +
 drivers/mtd/nand/stm_nand_regs.h                   |  304 ++++
 include/dt-bindings/clock/stih416-clks.h           |    2 +
 include/linux/mtd/stm_nand.h                       |  147 ++
 include/linux/mtd/stm_nand_bbt.h                   |   17 +
 14 files changed, 2961 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/stm-nand.txt
 create mode 100644 drivers/mtd/nand/stm_nand_bbt.c
 create mode 100644 drivers/mtd/nand/stm_nand_bch.c
 create mode 100644 drivers/mtd/nand/stm_nand_dt.c
 create mode 100644 drivers/mtd/nand/stm_nand_dt.h
 create mode 100644 drivers/mtd/nand/stm_nand_regs.h
 create mode 100644 include/linux/mtd/stm_nand.h
 create mode 100644 include/linux/mtd/stm_nand_bbt.h

-- 
1.9.1
