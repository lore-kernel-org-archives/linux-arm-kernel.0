From: mars.cheng@mediatek.com (Mars Cheng)
Date: Wed, 4 Jul 2018 09:52:50 +0800
Subject: [PATCH 0/4] Add basic SoC support for mt6765
Message-ID: <1530669174-17623-1-git-send-email-mars.cheng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic SoC support for Mediatek's new 8-core SoC,
MT6765, which is mainly for smartphone application.

Changes in V3:
1. split dt-binding document patchs
2. fix mt6765.dtsi warnings with W=12
3. remove uncessary PPI affinity for timer
4. add gicc base for gic dt node

Changes in V2:
1. fix clk properties in uart dts node
2. fix typo in submit title
3. add simple-bus in mt6765.dtsi
4. use correct SPDX license format


Mars Cheng (4):
  dt-bindings: mediatek: add support for mt6765 reference board
  dt-bindings: mtk-uart: add mt6765 uart bindings
  dt-bindings: interrupt-controller: add binding for mt6765
  arm64: dts: mediatek: add mt6765 support

 Documentation/devicetree/bindings/arm/mediatek.txt |    4 +
 .../interrupt-controller/mediatek,sysirq.txt       |    1 +
 .../devicetree/bindings/serial/mtk-uart.txt        |    1 +
 arch/arm64/boot/dts/mediatek/Makefile              |    1 +
 arch/arm64/boot/dts/mediatek/mt6765-evb.dts        |   33 +++++
 arch/arm64/boot/dts/mediatek/mt6765.dtsi           |  155 ++++++++++++++++++++
 6 files changed, 195 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6765-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6765.dtsi
