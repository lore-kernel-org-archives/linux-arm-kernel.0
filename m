From: bayi.cheng@mediatek.com (Bayi Cheng)
Date: Fri, 6 Nov 2015 23:48:06 +0800
Subject: [PATCH v6 0/3] Mediatek SPI-NOR flash driver 
Message-ID: <1446824889-16144-1-git-send-email-bayi.cheng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is based on v4.3-rc1 and l2-mtd.git [0] and erase_sector
implementation patch [1]

[0]: git://git.infradead.org/l2-mtd.git
[1]: http://lists.infradead.org/pipermail/linux-mtd/2015-October//062959.html

Change in v6:
1: delete mt8173_nor_do_rx
2: delete mt8173_nor_do_rx
3: add mt8173_nor_do_tx_rx for general usage
4: support nor flash with 6 IDs
5: delete mt8173_nor_erase_sector and use "nor->erase_opcode"
6: add mt8173_nor_set_addr to programming the address register
7: initialize the ppdata in mtk_nor_init

Change in v5:
1: add "status = "disable"" to device tree
2: add document "flash" node
3: fix some statement error in Kconfig file
4: fix alphabetical order error in makefile
5: delete the parament "mtd_info *mtd" in mt8173_nor structure
6: delete SPINOR_OP_WREN repeated calls
7: add mt8173_nor_do_tx & mt8173_nor_do_rx for them full potential
8: use a subnode to represent the flash

Change in v4:
1: delete the parament "write_enable" for mt8173_nor_write_reg
2: fix the build warning for calling mt8173_nor_write_single_byte

Change in v3:
1: use switch() to replace some if-else statement
2: use shifts to replace endianness statement
3: delete some unused macros
4: use auto-increment mechanism for single write
5: write address added to 32bytes

Change in v2:
1. Rebase to 4.3-rc1
2. propagate error code
3. delete mux clock and axi clock in dts file
4. descripts more exactly for binding file
5. change file names from mtk-nor.c to mtk_quadspi.c
6. delete some functions witch were used once time

Bayi Cheng (3):
  doc: dt: add documentation for Mediatek spi-nor controller
  mtd: mtk-nor: mtk serial flash controller driver
  arm64: dts: mt8173: Add nor flash node

 .../devicetree/bindings/mtd/mtk-quadspi.txt        |  41 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  16 +
 drivers/mtd/spi-nor/Kconfig                        |   7 +
 drivers/mtd/spi-nor/Makefile                       |   1 +
 drivers/mtd/spi-nor/mtk-quadspi.c                  | 475 +++++++++++++++++++++
 5 files changed, 540 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
 create mode 100644 drivers/mtd/spi-nor/mtk-quadspi.c

--
1.8.1.1.dirty 
