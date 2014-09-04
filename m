From: srv_yingjoe.chen@mediatek.com (Joe.C)
Date: Fri, 5 Sep 2014 07:50:55 +0800
Subject: arm: Add basic support for MediaTek MT8127 & MT8135 SoCs
Message-ID: <1409874660-8710-1-git-send-email-srv_yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add basic device tree support MT8127 & MT8135.
This series is based on v3.17-rc3.

We are planning to upstream drivers for MT8127 & MT8135 SoCs.
MT8135 is a tablet soc featuring 2 CA7 + 2 CA15. MT8127 is a
tablet soc with 4 CA7. They share many similar IP components
with MT65xx series.

Please note this one is not base on intpol [1] patches I sent
last month. Base on the discussion on intpol, I think it might
take some more time. I'd like to have this merge first so we
can work on other stuff simultaneously.

Joe.C

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/279052.html

Joe.C (5):
  arm: MTK: Add basic support for mt8127
  arm: mediatek: add dts for 8127 Moose board
  arm: MTK: Add basic support for mt8135
  arm: mediatek: add dts for MT8135 evaluation board.
  dt-bindings: add more chips in documentation for Mediatek SoC

 Documentation/devicetree/bindings/arm/mediatek.txt |   9 +-
 arch/arm/boot/dts/mt8127-moose.dts                 |  24 +++++
 arch/arm/boot/dts/mt8127.dtsi                      |  93 +++++++++++++++++
 arch/arm/boot/dts/mt8135-evbp1.dts                 |  24 +++++
 arch/arm/boot/dts/mt8135.dtsi                      | 115 +++++++++++++++++++++
 arch/arm/mach-mediatek/mediatek.c                  |   2 +
 6 files changed, 264 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt8127-moose.dts
 create mode 100644 arch/arm/boot/dts/mt8127.dtsi
 create mode 100644 arch/arm/boot/dts/mt8135-evbp1.dts
 create mode 100644 arch/arm/boot/dts/mt8135.dtsi
