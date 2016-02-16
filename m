From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 16 Feb 2016 11:15:02 +0900
Subject: [PATCH 0/9] ARM: uniphier: UniPhier updates for Linux 4.6-rc1
Message-ID: <1455588911-9827-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd and Olof,

Here is a series I want you to apply to ASOC.

I know this series includes DT updates for ARM 32bit and ARM 64bit,
but this is intentional.

Please apply the whole series to one branch.
Otherwise, it would cause a build error and big conflicts.
(some DT files are shared between arch/arm and arch/arm64,
so it is impossible to split the series into two.)



Masahiro Yamada (9):
  ARM: dts: uniphier: factor out ranges property of support card
  ARM: dts: uniphier: rework UniPhier System Bus nodes
  ARM: uniphier: add missing of_node_put()
  ARM: dts: uniphier: add reference clock nodes
  ARM: dts: uniphier: add EEPROM node for ProXstream2 Gentil board
  ARM: dts: uniphier: enable I2C channel 2 of ProXstream2 Gentil board
  ARM: dts: uniphier: add PH1-Pro4 Ace board support
  ARM: dts: uniphier: add PH1-Pro4 Sanji board support
  ARM: dts: uniphier: add @{address} to EEPROM node

 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/uniphier-common32.dtsi           |  26 +++--
 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts         |   8 --
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi            |   4 +
 arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts        |   8 --
 arch/arm/boot/dts/uniphier-ph1-pro4-ace.dts        | 113 +++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts        |   8 --
 arch/arm/boot/dts/uniphier-ph1-pro4-sanji.dts      | 108 ++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi           |   4 +
 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi           |   4 +
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts        |   8 --
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi           |  25 +++--
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts        |   8 --
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi           |   4 +
 arch/arm/boot/dts/uniphier-proxstream2-gentil.dts  |  10 ++
 arch/arm/boot/dts/uniphier-proxstream2.dtsi        |   4 +
 arch/arm/boot/dts/uniphier-ref-daughter.dtsi       |   2 +-
 arch/arm/boot/dts/uniphier-support-card.dtsi       |   5 +-
 arch/arm/mach-uniphier/platsmp.c                   |  12 +--
 .../boot/dts/socionext/uniphier-ph1-ld10-ref.dts   |   8 --
 .../boot/dts/socionext/uniphier-ph1-ld10.dtsi      |  18 ++--
 21 files changed, 309 insertions(+), 80 deletions(-)
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-pro4-ace.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-pro4-sanji.dts

-- 
1.9.1
