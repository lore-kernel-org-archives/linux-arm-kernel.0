From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 20 Mar 2014 19:06:21 +0200
Subject: [PATCH 0/3] Fix NAND propeties for k2hk-evm
Message-ID: <1395335184-4745-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is intedent to fix problems founded when checked NAND flash
for k2hk-emv board rev2.0. Whithout this series we cannot use ubifs and
whole volume of present NAND memory.

Based on linux-next tag: next-20140320

Murali Karicheri (3):
  ARM: dts: k2hk-evm: set ubifs partition size for 512M NAND
  mtd: davinci-nand: add dts property for NAND_NO_SUBPAGE_WRITE option
  ARM: dts: k2hk-evm: disable subpage write for davinci nand device

 Documentation/devicetree/bindings/mtd/davinci-nand.txt | 2 ++
 arch/arm/boot/dts/k2hk-evm.dts                         | 3 ++-
 drivers/mtd/nand/davinci_nand.c                        | 3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

-- 
1.8.3.2
