From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Tue, 17 Dec 2013 14:59:06 +0200
Subject: [PATCH v4 0/9] Reuse davinci-nand driver for Keystone arch
Message-ID: <1387285155-19182-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains fixes and updates of Davinci nand driver in
order to reuse it for Keystone platform.

v3..v4:
- mtd: nand: davinci: fix driver registration
	dropped __init/__exit/__exit_p as module_platform_driver() is used
- mtd: nand: davinci: adjust DT properties to MTD generic
	used of_get_nand_bus_width() helper
- mtd: nand: davinci: don't request AEMIF address range
	added comment at code change

v2..v3:
- mtd: nand: davinci: don't set timings if AEMIF is used
	dropped, it would be replaced by alone patch
	ARM: davinci: aemif: get rid of davinci-nand driver dependency on aemif

v1..v2
The series is combination of two following series:
- Davinci nand driver fixes and updates:
https://lkml.org/lkml/2013/11/20/271
- Reuse davinci-nand driver for Keystone arch
https://lkml.org/lkml/2013/11/20/315

- mtd: nand: davinci: extend description of bindings
	clarified changeset description

- mtd: nand: davinci: reuse driver for Keystone arch
	removed "ti,keystone-nand" compatible from driver

Ivan Khoronzhuk (9):
  mtd: nand: davinci: fix driver registration
  mtd: nand: davinci: return ENOMEM if memory allocation is failed
  mtd: nand: davinci: check required ti,davinci-chipselect property
  mtd: nand: davinci: simplify error handling
  mtd: nand: davinci: move bindings under mtd
  mtd: nand: davinci: extend description of bindings
  mtd: nand: davinci: adjust DT properties to MTD generic
  mtd: nand: davinci: reuse driver for Keystone arch
  mtd: nand: davinci: don't request AEMIF address range

 .../devicetree/bindings/arm/davinci/nand.txt       |   46 ----------
 .../devicetree/bindings/mtd/davinci-nand.txt       |   94 ++++++++++++++++++++
 drivers/mtd/nand/Kconfig                           |    6 +-
 drivers/mtd/nand/davinci_nand.c                    |   89 +++++++++---------
 4 files changed, 146 insertions(+), 89 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/davinci/nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/davinci-nand.txt

-- 
1.7.9.5
