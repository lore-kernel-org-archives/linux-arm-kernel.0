From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 10 Dec 2014 18:49:58 +0800
Subject: [PATCH 0/4] Add basic support for Mediatek MT8173 SoC
Message-ID: <1418208602-35584-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT8173 is a SoC based on 64bit ARMv8 architecture. It contains 
2 CA53 + 2 CA57 cores. MT8173 share many HW IP with MT8135 and other 
MT65xx series. This patchset was tested on MT8173 engineer sample, and 
boot to shell ok.

This series contains document bindings, device tree, defconfig, 
and one sysirq modification for MT8173.

This series is based on 3.18, and Joe's MT8135 basic support patch [1] 
and sysirq patch [2]

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/296093.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/305808.html

Eddie Huang (3):
  Document: DT: Add bindings for mediatek MT8173 Soc Platform
  arm64: dts: Add mediatek MT8173 SoC and evaluation board dts and
    Makefile
  arm64: mediatek: Add MT8173 SoC Kconfig and defconfig

Yingjoe Chen (1):
  irqchip: mediatek: Add support for mt8173

 Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
 arch/arm64/Kconfig                                 |   6 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/mt8173-evb.dts                 |  31 ++++
 arch/arm64/boot/dts/mt8173.dtsi                    | 164 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   2 +
 drivers/irqchip/irq-mtk-sysirq.c                   |  22 ++-
 7 files changed, 226 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mt8173-evb.dts
 create mode 100644 arch/arm64/boot/dts/mt8173.dtsi

-- 
1.8.1.1.dirty 
