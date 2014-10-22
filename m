From: yingjoe.chen@mediatek.com (Joe.C)
Date: Wed, 22 Oct 2014 18:29:49 +0800
Subject: [PATCH v4 0/8] arm: Add basic support for MediaTek MT8127 & MT8135
 SoCs
Message-ID: <1413973797-17619-1-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v4 of adding basic device tree support for MT8127 & MT8135.
Since the last series didn't make it into v3.18-rc1, I updated the
series and send it again. This series is based on v3.18-rc1

Besides changing patch subjects to make them look more consistence,
I include config option patch original posted with mt8135 pinctrl
support[1]. It seems more natural in this series and our works on
clk & pmic will also need it.

We are planning to upstream drivers for MT8127 & MT8135 SoCs.
MT8135 is a tablet soc featuring 2 CA7 + 2 CA15. MT8127 is a
tablet soc with 4 CA7. They share many similar IP components
with MT65xx series.

Changes in v4:
 - Include config options for different mediatek SoCs.

Changes in v3:
 - Changing earlyprintk order and dt-binding based on Matthias' suggestion.

v2:
 - Change timer compatible string.
 - Build dtb for mt8127 & mt8135
 - Adding earlyprintk support for mt8127 & mt8135

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/289285.html

Joe.C (8):
  ARM: mediatek: Add basic support for mt8127
  ARM: mediatek: add dts for 8127 Moose board
  ARM: mediatek: Add basic support for mt8135
  ARM: mediatek: add dts for MT8135 evaluation board.
  dt-bindings: add more chips in documentation for Mediatek SoC
  ARM: dts: Build dtb for mt8127 & mt8135
  ARM: mediatek: Add earlyprintk support for mt8127 & mt8135
  ARM: mediatek: Add config option for mediatek SoCs.

 Documentation/devicetree/bindings/arm/mediatek.txt |  15 ++-
 arch/arm/Kconfig.debug                             |  20 ++++
 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/mt8127-moose.dts                 |  24 +++++
 arch/arm/boot/dts/mt8127.dtsi                      |  93 +++++++++++++++++
 arch/arm/boot/dts/mt8135-evbp1.dts                 |  24 +++++
 arch/arm/boot/dts/mt8135.dtsi                      | 115 +++++++++++++++++++++
 arch/arm/mach-mediatek/Kconfig                     |  22 +++-
 arch/arm/mach-mediatek/mediatek.c                  |   2 +
 9 files changed, 312 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt8127-moose.dts
 create mode 100644 arch/arm/boot/dts/mt8127.dtsi
 create mode 100644 arch/arm/boot/dts/mt8135-evbp1.dts
 create mode 100644 arch/arm/boot/dts/mt8135.dtsi
