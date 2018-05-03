From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Thu,  3 May 2018 11:35:45 +0200
Subject: [PATCH v7 0/6] gnss: special driver for Wi2Wi w2sg0004 GPS module on
 GTA04 board
Message-ID: <cover.1525340143.git.hns@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes V7:
* propose a separate and dedicated driver because the w2sg0004 is quite special
* moved all code to drivers/gnss
* adapted to make use of the newly proposed gnss framework
* dropped support for w2sg0084(i) with WAKEUP feedback because that
  case is covered by the sirfstar driver
NOTE: must beapplied on top of GNSS framework

Changes V6: -- was not posted --
* worked in some feedbacks by Johan Hovold:
  risk of rfkill race, use gpiod, fix typos
* make consistent use of bool type
* factor out creation of user-space tty interface into a "gps-core"
  to make the chip driver code independent of such core features
  (originally suggested by Andrew F. Davis)

2017-12-01 08:49:41: Changes V5:
* clarified to keep it in drivers/misc and not create a new group drivers/gps
* fix formatting of new entry in omap3-gta04.dtsi (suggested by Tony Lindgren)
* removed MODULE_ALIAS (suggested by Andrew F. Davis)
* some more formatting, code&style fixes (suggested by Andrew F. Davis)
* apply __maybe_unused for PM (suggested by Andrew F. Davis)
* fixed copyright and author records (suggested by Andrew F. Davis)

2017-11-15 22:38:01: Changes V4:
* removed all pdata remains (suggested by Arnd Bergmann and Rob Herring)
* fixed minor issues and subject/commit messages (suggested by Rob Herring)
* added one missing Signed-off-By: (suggested by Andreas F?rber)
* added SPDX header (suggested by Rob Herring)

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

Years long history of getting this devices supported (original work by Neil Brown).

H. Nikolaus Schaller (6):
  dt-bindings: define vendor prefix for Wi2Wi, Inc.
  dt-bindings: gnss: add w2sg0004 bindings documentation
  DTS: gta04: add uart2 child node for w2sg0004 GPS receiver
  misc gnss serdev: Add w2sg0004 power control driver
  gnss: add w2sg0004 to Makefile
  gnss: add w2sg0004 to Kconfig

 .../devicetree/bindings/gnss/wi2wi,w2sg0004.txt    |  23 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   7 +
 drivers/gnss/Kconfig                               |  10 +
 drivers/gnss/Makefile                              |   3 +
 drivers/gnss/w2sg0004.c                            | 435 +++++++++++++++++++++
 6 files changed, 479 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gnss/wi2wi,w2sg0004.txt
 create mode 100644 drivers/gnss/w2sg0004.c

-- 
2.12.2
