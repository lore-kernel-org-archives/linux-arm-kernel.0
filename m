From: satish.patel@ti.com (Satish Patel)
Date: Mon, 20 Jan 2014 10:03:49 +0530
Subject: [PATCH v2 0/5] Smart Card(SC) interface, TI USIM & NxP SC phy driver
Message-ID: <1390192434-19386-1-git-send-email-satish.patel@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes from v1:
* RFC(v1) comments are fixed

** removed "gpio_to_irq" as GPIO controller process  cell from DT and
give it to DT node
** comments on documentation
** few other comments on null checks are resolved

* BWT timing configuration is added to ti-usim driver

v1 cover letter link#
https://lkml.org/lkml/2014/1/6/250

Satish Patel (5):
  sc_phy:SmartCard(SC) PHY interface to SC controller
  misc: tda8026: Add NXP TDA8026 PHY driver
  char: ti-usim: Add driver for USIM module on AM43xx
  ARM: dts: AM43xx: DT entries added for ti-usim
  ARM: dts: AM43xx-epos-evm: DT entries  for ti-usim and phy

 Documentation/devicetree/bindings/misc/tda8026.txt |   19 +
 .../devicetree/bindings/ti-usim/ti-usim.txt        |   31 +
 Documentation/sc_phy.txt                           |  171 ++
 arch/arm/boot/dts/am4372.dtsi                      |   10 +
 arch/arm/boot/dts/am43x-epos-evm.dts               |   43 +
 drivers/char/Kconfig                               |    7 +
 drivers/char/Makefile                              |    1 +
 drivers/char/ti-usim-hw.h                          |  863 +++++++++
 drivers/char/ti-usim.c                             | 1859 ++++++++++++++++++++
 drivers/misc/Kconfig                               |    7 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/tda8026.c                             | 1255 +++++++++++++
 include/linux/sc_phy.h                             |  132 ++
 include/linux/ti-usim.h                            |   98 +
 14 files changed, 4497 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/tda8026.txt
 create mode 100644 Documentation/devicetree/bindings/ti-usim/ti-usim.txt
 create mode 100644 Documentation/sc_phy.txt
 create mode 100644 drivers/char/ti-usim-hw.h
 create mode 100644 drivers/char/ti-usim.c
 create mode 100644 drivers/misc/tda8026.c
 create mode 100644 include/linux/sc_phy.h
 create mode 100644 include/linux/ti-usim.h
