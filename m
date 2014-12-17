From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 17 Dec 2014 22:17:29 +0800
Subject: [PATCH v2 0/4] Add basic support for Mediatek MT8173 SoC 
Message-ID: <1418825853-10934-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT8173 is a SoC based on 64bit ARMv8 architecture. It contains 2 CA53 + 2 CA57 cores. MT8173 share many HW IP with MT8135 and other MT65xx series. This patchset was tested on MT8173 engineer sample, and boot to shell ok.

This series contains document bindings, device tree, defconfig, and one sysirq modification for MT8173.

Changes in v2:

1. Modify mt8173.dtsi and mt8173-evb.dts according to Mark Rutland's comment, change cpu-maps, psci, clock, GIC properties.
2. Modify irq-mtk-sysirq.c according to Arnd Bergmann's comment to calculate irq number from reg range.

This series is based on 3.18, and Joe's MT8135 basic support patch [1] and sysirq patch [2]

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/296093.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310335.html

Eddie Huang (3):
  Document: DT: Add bindings for mediatek MT8173 Soc Platform
  arm64: dts: Add mediatek MT8173 SoC and evaluation board dts and
    Makefile
  arm64: mediatek: Add MT8173 SoC Kconfig and defconfig

Yingjoe Chen (1):
  irqchip: mtk-sysirq: Get irq number from register resource size

 Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
 arch/arm64/Kconfig                                 |   6 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/mt8173-evb.dts                 |  34 +++++
 arch/arm64/boot/dts/mt8173.dtsi                    | 152 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   2 +
 drivers/irqchip/irq-mtk-sysirq.c                   |  18 ++-
 7 files changed, 210 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mt8173-evb.dts
 create mode 100644 arch/arm64/boot/dts/mt8173.dtsi

--
1.8.1.1.dirty
