From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 9 May 2016 14:51:17 +0800
Subject: [PATCH 0/2] mtd: atmel_nand: remove compatible "atmel,sama5d4-nfc"
Message-ID: <1462776680-5284-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is a datasheet bug, for current SoCs, the RB_EDGE3(i.e. bit 27)
of HSMC_SR register does not exist, the RB_EDGE0 (i.e. bit 24) is
the ready/busy line edge status bit. So the compatible
"atmel,sama5d4-nfc" is unneeded.


Wenyou Yang (2):
  Revert "mtd: atmel_nand: Support variable RB_EDGE interrupts"
  ARM: at91/dt: use "atmel,sama5d3-nfc" compatible for nfc

 .../devicetree/bindings/mtd/atmel-nand.txt         |  2 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |  2 +-
 drivers/mtd/nand/atmel_nand.c                      | 35 +++++-----------------
 drivers/mtd/nand/atmel_nand_nfc.h                  |  3 +-
 4 files changed, 11 insertions(+), 31 deletions(-)

-- 
2.7.4
