From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Wed,  5 Jul 2017 20:53:13 +0900
Subject: [PATCH v3 0/2] add thermal nodes for UniPhier SoCs
Message-ID: <1499255595-31805-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds thermal nodes for UniPhier PXs2 and LD20 SoCs.

Changes in v2:
- add the calibration value to device tree for LD20 reference board

Changes in v1:
- separate from driver's patchset[1]
- add cooling-maps nodes on the device tree
- fix an interrupt trigger to set 'level-triggered' according to
  hardware specification
- bring up threshold temperature for LD20 according to the spec sheet
- add cpuN labels for reference in cooling-device property on PXs2 dts

[1] https://lkml.org/lkml/2017/6/28/170

Kunihiko Hayashi (2):
  ARM: dts: uniphier: add nodes of thermal monitor and thermal zone for
    PXs2
  arm64: dts: uniphier: add nodes of thermal monitor and thermal zone
    for LD20

 arch/arm/boot/dts/uniphier-pxs2.dtsi               | 43 ++++++++++++++++++++--
 .../arm64/boot/dts/socionext/uniphier-ld20-ref.dts |  4 ++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 40 ++++++++++++++++++++
 3 files changed, 83 insertions(+), 4 deletions(-)

-- 
2.7.4
