From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 4 Nov 2014 15:30:47 +0800
Subject: [PATCH v5 0/8] arm: Add basic support for MediaTek MT8127 & MT8135
 SoCs
Message-ID: <1415086255-5555-1-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v5 of adding basic device tree support for MT8127 & MT8135.
This series is based on v3.18-rc1

This version fix board model name and change to use 32bits address for
mt8127/mt8135 dtsi. I also took the chance to do a minor wording change
in dt-bindings. Please note we already have some patches (uart, reset,
i2c, pinctrl, intpol) thats depends on old version, and should be changed
if this version is merged.

We are planning to upstream drivers for MT8127 & MT8135 SoCs.
MT8135 is a tablet soc featuring 2 CA7 + 2 CA15. MT8127 is a
tablet soc with 4 CA7. They share many similar IP components
with MT65xx series.

Changes in v5:
 - Using 32bits address instead of 64bits in dtsi.
 - Fix model name error
 - Adjust wording in dtbindings.

Changes in v4:
 - Include config options for different mediatek SoCs.

Changes in v3:
 - Changing earlyprintk order and dt-binding based on Matthias' suggestion.

v2:
 - Change timer compatible string.
 - Build dtb for mt8127 & mt8135
 - Adding earlyprintk support for mt8127 & mt8135

Joe.C (8):
  ARM: mediatek: Add basic support for mt8127
  ARM: mediatek: add dts for 8127 Moose board
  ARM: mediatek: Add basic support for mt8135
  ARM: mediatek: add dts for MT8135 evaluation board.
  dt-bindings: add more chips in documentation for Mediatek SoC
  ARM: dts: Build dtb for mt8127 & mt8135
  ARM: mediatek: Add earlyprintk support for mt8127 & mt8135
  ARM: mediatek: Fix description for mediatek SoCs

 Documentation/devicetree/bindings/arm/mediatek.txt |  15 ++-
 arch/arm/Kconfig.debug                             |  20 ++++
 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/mt8127-moose.dts                 |  25 +++++
 arch/arm/boot/dts/mt8127.dtsi                      |  94 +++++++++++++++++
 arch/arm/boot/dts/mt8135-evbp1.dts                 |  25 +++++
 arch/arm/boot/dts/mt8135.dtsi                      | 116 +++++++++++++++++++++
 arch/arm/mach-mediatek/Kconfig                     |   4 +-
 arch/arm/mach-mediatek/mediatek.c                  |   2 +
 9 files changed, 299 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt8127-moose.dts
 create mode 100644 arch/arm/boot/dts/mt8127.dtsi
 create mode 100644 arch/arm/boot/dts/mt8135-evbp1.dts
 create mode 100644 arch/arm/boot/dts/mt8135.dtsi
