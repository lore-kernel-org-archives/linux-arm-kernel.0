From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Wed,  8 Jan 2014 18:07:16 -0500
Subject: [RFC 0/5] Nand
In-Reply-To: <87siupheou.fsf@nbsps.com>
References: <87siupheou.fsf@nbsps.com>
Message-ID: <1389222441-4322-1-git-send-email-bpringlemeir@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an update of a driver originally by Shaohui Xie <b21989@freescale.com>
and then updated by Jason Jin <Jason.jin@freescale.com>.  It is used and tested
on the Vybrid Tower system (VF610-TWR).  However, the 'fsl_nfc' is present on
many Freescale SOC devices.  Such as the MPC5125 (PowerPC), MCF54418 (ColdFire)
and the Kinetis K70 (ARM Cortex-M).

The code in this patch is about 4x faster than other versions on the Internet,
at least with the Vybrid SOC and gcc-4.8.  Currently the MTD OOB test fails with
or without hardware ECC.  All of the other tests print 'success'.

The current 'device tree' bindings for the 'vf610-twr' will testing of the entire
flash device.  A command line option such as,

 mtdparts=fsl_nfc:256k(loader),8M(boot0),8M(boot1),-(root)

can be used to partion the existing NAND flash or the 'vf610-twr.dts' can be 
modified to add some similar partitions. 

cumentation/devicetree/bindings/mtd/fsl-nfc.txt |  25 ++++
 arch/arm/boot/dts/vf610-twr.dts                   |  41 +++++++
 arch/arm/boot/dts/vf610.dtsi                      |   9 ++
 arch/arm/mach-imx/Kconfig                         |   1 +
 drivers/mtd/nand/Kconfig                          |  13 +++
 drivers/mtd/nand/Makefile                         |   1 +
 drivers/mtd/nand/fsl_nfc.c                        | 790 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 880 insertions(+)
