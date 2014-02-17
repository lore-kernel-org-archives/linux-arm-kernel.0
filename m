From: klightspeed@killerwolves.net (klightspeed at killerwolves.net)
Date: Tue, 18 Feb 2014 07:45:33 +1000
Subject: [PATCH v4 0/4] DT support for kirkwood based Synology NAS boxes
Message-ID: <1392673537-17308-1-git-send-email-klightspeed@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for around 30 kirkwood bases Synology NAS
boxes. Patch #1 generalized the qnap power off driver so that it can
also be used for Synology devices. Patch #2 and #3 document vendor
prefixes and i2c trivial devices. Patch #4 adds the synology DT files.

v2:
Typo fix in qnap-poweroff.c
Use ricoy stock ticker instead of ricoh
Describe the lego structure of the hardware

v3:
Merge synology dtsi files into a single dtsi file

v4:
Various minor fixes to synology dtsi file

Andrew Lunn (3):
  Power: Reset: Generalize qnap-poweroff to with on Synology devices.
  DT: Vendor prefixes: Add ricoh, ssi and synology
  DT: i2c: Trivial: Add sii, s35390a, fix ricoh vendor prefix

Ben Peddell (1):
  ARM: Kirkwood: Add support for many Synology NAS devices

 .../devicetree/bindings/i2c/trivial-devices.txt    |   3 +-
 .../bindings/power_supply/qnap-poweroff.txt        |   5 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   3 +
 arch/arm/boot/dts/Makefile                         |  15 +
 arch/arm/boot/dts/kirkwood-ds109.dts               |  41 +
 arch/arm/boot/dts/kirkwood-ds110jv10.dts           |  41 +
 arch/arm/boot/dts/kirkwood-ds111.dts               |  44 ++
 arch/arm/boot/dts/kirkwood-ds112.dts               |  48 ++
 arch/arm/boot/dts/kirkwood-ds209.dts               |  44 ++
 arch/arm/boot/dts/kirkwood-ds210.dts               |  46 ++
 arch/arm/boot/dts/kirkwood-ds212.dts               |  47 ++
 arch/arm/boot/dts/kirkwood-ds212j.dts              |  41 +
 arch/arm/boot/dts/kirkwood-ds409.dts               |  48 ++
 arch/arm/boot/dts/kirkwood-ds409slim.dts           |  40 +
 arch/arm/boot/dts/kirkwood-ds411.dts               |  52 ++
 arch/arm/boot/dts/kirkwood-ds411j.dts              |  48 ++
 arch/arm/boot/dts/kirkwood-ds411slim.dts           |  48 ++
 arch/arm/boot/dts/kirkwood-rs212.dts               |  48 ++
 arch/arm/boot/dts/kirkwood-rs409.dts               |  44 ++
 arch/arm/boot/dts/kirkwood-rs411.dts               |  44 ++
 arch/arm/boot/dts/kirkwood-synology.dtsi           | 871 +++++++++++++++++++++
 drivers/power/reset/qnap-poweroff.c                |  46 +-
 22 files changed, 1655 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-ds109.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds110jv10.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds111.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds112.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds209.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds210.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds212.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds212j.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds409.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds409slim.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds411.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds411j.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds411slim.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-rs212.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-rs409.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-rs411.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-synology.dtsi

-- 
1.8.3.2
