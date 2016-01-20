From: rogershimizu@gmail.com (Roger Shimizu)
Date: Thu, 21 Jan 2016 00:33:51 +0900
Subject: [PATCH v2 0/7] ARM: dts: kirkwood: fixes and split of linkstation dts
 for ls-wvl/vl and ls-wxl/wsxl
In-Reply-To: <1453211342-25214-1-git-send-email-rogershimizu@gmail.com>
References: <1453211342-25214-1-git-send-email-rogershimizu@gmail.com>
Message-ID: <1453304038-28345-1-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear kirkwood maintainers,

Linkstation dts for ls-wxl and ls-wvl need some fixes:
  - [patch 1/7] and [patch 2/7] are fixes for gpio pin
  - [patch 3/7] and [patch 4/7] are fixes for gpio led
Above 4 patches can be safely backported to 4.3/4.4 stable kernel.

And in order to support more buffalo linkstation devices in convenient way,
I split current 2 dts files into a few comoon dtsi files and device specific
dts files.
  - [patch 5/7] relicense dts under GPLv2/X11
  - [patch 6/7] split dts for lswxl
  - [patch 7/7] split dts for lswvl

Changes in v2:
  - separate the fix and relicense patch
  - add "linkstation:" to all led labels

Cheers.

Roger Shimizu (7):
  ARM: dts: kirkwood: gpio pin fixes for linkstation ls-wxl/wsxl
  ARM: dts: kirkwood: gpio pin fixes for linkstation ls-wvl/vl
  ARM: dts: kirkwood: gpio-leds fixes for linkstation ls-wxl/wsxl
  ARM: dts: kirkwood: gpio-leds fixes for linkstation ls-wvl/vl
  ARM: dts: kirkwood: relicense dts of ls-wvl/vl and ls-wxl/wsxl under
    GPLv2/X11
  ARM: dts: kirkwood: split lswxl dts to linkstation lswsxl and lswxl
  ARM: dts: kirkwood: split lswvl dts to linkstation lsvl and lswvl

 .../devicetree/bindings/arm/marvell,kirkwood.txt   |   6 +-
 arch/arm/boot/dts/Makefile                         |   6 +-
 arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi   | 191 +++++++++++++
 .../boot/dts/kirkwood-linkstation-duo-6281.dtsi    | 185 +++++++++++++
 arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts    |  57 ++++
 arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dts  |  57 ++++
 arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts   | 112 ++++++++
 arch/arm/boot/dts/kirkwood-linkstation-lswxl.dts   | 116 ++++++++
 arch/arm/boot/dts/kirkwood-linkstation.dtsi        | 202 ++++++++++++++
 arch/arm/boot/dts/kirkwood-lswvl.dts               | 301 ---------------------
 arch/arm/boot/dts/kirkwood-lswxl.dts               | 301 ---------------------
 11 files changed, 928 insertions(+), 606 deletions(-)
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
