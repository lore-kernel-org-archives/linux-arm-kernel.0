From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Wed, 15 Nov 2017 22:37:52 +0100
Subject: [PATCH v4 0/5] misc serdev: new serdev based driver for Wi2Wi
 w2sg00x4 GPS module
Message-ID: <cover.1510781875.git.hns@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes V4:
* removed all pdata remains
* added one missing Signes-off-By

2017-11-15 16:19:17: Changes V3:
* worked in suggestions by kbuild test robot
* added misc+serdev to the subject

2017-11-12 22:00:02: Changes V2:
* reduced to submit only w2sg00x4 GPS driver code
* add DT node for GTA04 device to make use of the driver
* split into base code and a debugging Kconfig option (brings device into false power state after boot)
* worked in comments by kbuild robot and Rob Herring

2017-05-21 12:44:07: RFC V1
* RFC concerning new serdev based drivers for Wi2Wi w2sg00x4 GPS module and w2cbw003 bluetooth

H. Nikolaus Schaller (5):
  dt-bindings: vendor prefix for Wi2Wi, Inc.
  dt-bindings: gps: add w2sg00x4 bindings documentation (GPS module with
    UART))
  misc serdev: Add w2sg0004 (gps receiver) power control driver
  DTS: gta04: add serdev node for w2sg00x4
  misc serdev: w2sg0004: add debugging code and Kconfig

 .../devicetree/bindings/gps/wi2wi,w2sg0004.txt     |  24 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   6 +
 drivers/misc/Kconfig                               |  18 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/w2sg0004.c                            | 582 +++++++++++++++++++++
 6 files changed, 632 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gps/wi2wi,w2sg0004.txt
 create mode 100644 drivers/misc/w2sg0004.c

-- 
2.12.2
