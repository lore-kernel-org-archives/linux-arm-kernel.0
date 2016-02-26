From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 26 Feb 2016 16:18:27 +0900
Subject: [PATCH 0/9] ARM: dts: uniphier: UniPhier DT updates for Linux 4.6-rc1
 (2nd round)
Message-ID: <1456471116-8140-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Olof,

Here is a series for UniPhier DT updates.

It intentionally includes DT updates for ARM 32bit and ARM 64bit
in order to avoid conflicts and build errors.

(Some files in arch/arm64/boot/dts/socionext points to
arch/arm/boot/dts/* by symbolic links, so I needed to
change them atomically.)

Please apply the whole series to one branch.



Masahiro Yamada (9):
  arm64: dts: uniphier: rename PH1-LD10 to PH1-LD20
  ARM: dts: uniphier: factor out ranges property of support card
  ARM: dts: uniphier: rework UniPhier System Bus nodes
  ARM: dts: uniphier: add reference clock nodes
  ARM: dts: uniphier: add EEPROM node for ProXstream2 Gentil board
  ARM: dts: uniphier: enable I2C channel 2 of ProXstream2 Gentil board
  ARM: dts: uniphier: add PH1-Pro4 Ace board support
  ARM: dts: uniphier: add PH1-Pro4 Sanji board support
  ARM: dts: uniphier: add @{address} to EEPROM node

 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/uniphier-common32.dtsi           |  27 +++--
 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts         |   8 --
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi            |   4 +
 arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts        |   8 --
 arch/arm/boot/dts/uniphier-ph1-pro4-ace.dts        | 113 +++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts        |   8 --
 arch/arm/boot/dts/uniphier-ph1-pro4-sanji.dts      | 108 ++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi           |   4 +
 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi           |   4 +
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts        |   8 --
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi           |  26 +++--
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts        |   8 --
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi           |   4 +
 arch/arm/boot/dts/uniphier-proxstream2-gentil.dts  |  10 ++
 arch/arm/boot/dts/uniphier-proxstream2.dtsi        |   4 +
 arch/arm/boot/dts/uniphier-ref-daughter.dtsi       |   2 +-
 arch/arm/boot/dts/uniphier-support-card.dtsi       |   6 +-
 arch/arm64/boot/dts/socionext/Makefile             |   2 +-
 ...-ph1-ld10-ref.dts => uniphier-ph1-ld20-ref.dts} |  16 +--
 ...iphier-ph1-ld10.dtsi => uniphier-ph1-ld20.dtsi} |  25 +++--
 21 files changed, 315 insertions(+), 82 deletions(-)
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-pro4-ace.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-pro4-sanji.dts
 rename arch/arm64/boot/dts/socionext/{uniphier-ph1-ld10-ref.dts => uniphier-ph1-ld20-ref.dts} (88%)
 rename arch/arm64/boot/dts/socionext/{uniphier-ph1-ld10.dtsi => uniphier-ph1-ld20.dtsi} (94%)

-- 
1.9.1
