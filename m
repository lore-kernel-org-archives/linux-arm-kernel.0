From: srv_yingjoe.chen@mediatek.com (Joe.C)
Date: Wed, 17 Sep 2014 22:24:07 +0800
Subject: [PATCH v2 0/7] arm: Add basic support for MediaTek MT8127 & MT8135
 SoCs
Message-ID: <1410963854-17154-1-git-send-email-srv_yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v2 of adding basic device tree support MT8127 & MT8135.
This series is based on Matthias' pull request for mediatek support [1]
Comparing to v1, this version changes:
 - Change timer compatible string.
 - Build dtb for mt8127 & mt8135
 - Adding earlyprintk support for mt8127 & mt8135

We are planning to upstream drivers for MT8127 & MT8135 SoCs.
MT8135 is a tablet soc featuring 2 CA7 + 2 CA15. MT8127 is a
tablet soc with 4 CA7. They share many similar IP components
with MT65xx series.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/287506.html

Joe.C (7):
  arm: MTK: Add basic support for mt8127
  arm: mediatek: add dts for 8127 Moose board
  arm: MTK: Add basic support for mt8135
  arm: mediatek: add dts for MT8135 evaluation board.
  dt-bindings: add more chips in documentation for Mediatek SoC
  arm: dts: Build dtb for mt8127 & mt8135
  arm: mediatek: Add earlyprintk support for mt8127 & mt8135

 Documentation/devicetree/bindings/arm/mediatek.txt |   9 +-
 arch/arm/Kconfig.debug                             |  20 ++++
 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/mt8127-moose.dts                 |  24 +++++
 arch/arm/boot/dts/mt8127.dtsi                      |  93 +++++++++++++++++
 arch/arm/boot/dts/mt8135-evbp1.dts                 |  24 +++++
 arch/arm/boot/dts/mt8135.dtsi                      | 115 +++++++++++++++++++++
 arch/arm/mach-mediatek/mediatek.c                  |   2 +
 8 files changed, 287 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt8127-moose.dts
 create mode 100644 arch/arm/boot/dts/mt8127.dtsi
 create mode 100644 arch/arm/boot/dts/mt8135-evbp1.dts
 create mode 100644 arch/arm/boot/dts/mt8135.dtsi

-- 
1.8.1.1.dirty
