From: rogershimizu@gmail.com (Roger Shimizu)
Date: Tue, 19 Jan 2016 22:49:00 +0900
Subject: [PATCH 0/2] ARM: dts: kirkwood: split lswxl and lswvl with fixes
Message-ID: <1453211342-25214-1-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support more buffalo linkstation devices in convenient way,
I split current 2 dts files into a few comoon dtsi files and device specific
dts files.

And I also fixed a few gpio/led pin, including fix for the issue mentioned
in Debian BTS #810894.

Roger Shimizu (2):
  ARM: dts: kirkwood: split lswxl into linkstation lswsxl and lswxl
  ARM: dts: kirkwood: split lswvl into linkstation lsvl and lswvl

 .../devicetree/bindings/arm/marvell,kirkwood.txt   |   6 +-
 arch/arm/boot/dts/Makefile                         |   6 +-
 arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi   | 190 +++++++++++++
 .../boot/dts/kirkwood-linkstation-duo-6281.dtsi    | 185 +++++++++++++
 arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts    |  57 ++++
 arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dts  |  57 ++++
 arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts   | 112 ++++++++
 arch/arm/boot/dts/kirkwood-linkstation-lswxl.dts   | 113 ++++++++
 arch/arm/boot/dts/kirkwood-linkstation.dtsi        | 202 ++++++++++++++
 arch/arm/boot/dts/kirkwood-lswvl.dts               | 301 ---------------------
 arch/arm/boot/dts/kirkwood-lswxl.dts               | 301 ---------------------
 11 files changed, 924 insertions(+), 606 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-linkstation-duo-6281.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-linkstation-lswxl.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-linkstation.dtsi
 delete mode 100644 arch/arm/boot/dts/kirkwood-lswvl.dts
 delete mode 100644 arch/arm/boot/dts/kirkwood-lswxl.dts

-- 
2.1.4
