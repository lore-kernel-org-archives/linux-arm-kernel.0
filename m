From: dawei.chien@mediatek.com (Dawei Chien)
Date: Thu, 18 Aug 2016 11:50:50 +0800
Subject: [PATCH v2 0/3] Add Mediatek thermal driver for mt2701
Message-ID: <1471492253-7185-1-git-send-email-dawei.chien@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series support for mt2701 chip to mtk_thermal.c,
and integrate both mt8173 and mt2701 on the same driver.
MT8173 has four banks and five sensors, and MT2701 has
only one bank and three sensors.

Change since V1:
1. Restore macro name with MT8173 for nvmem calibration data
since original macro name could be used for both MT2701/MT8173.

2. Add flexible array member to instead of normal array since
thermal bank has different array size between MT2701 to MT8173.

Dawei Chien (3):
  dt-bindings: thermal: Add binding document for Mediatek thermal
    controller
  thermal: Add Mediatek thermal driver for mt2701.
  arm: dts: thermal: add thermal/auxadc node.

 .../bindings/thermal/mediatek-thermal.txt          |    4 +-
 arch/arm/boot/dts/mt2701.dtsi                      |   44 ++++
 drivers/thermal/mtk_thermal.c                      |  215 ++++++++++++++------
 3 files changed, 199 insertions(+), 64 deletions(-)
