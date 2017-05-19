From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 19 May 2017 18:09:19 +0200
Subject: [PATCH 0/6] Extend mvebu gpio driver to support the controllers of
 the Marvell Armada 7K/8K
Message-ID: <cover.e10718b9c0f9fdd07327ae14e213be8da5b1f7ef.1495210061.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series extends the mvebu gpio driver to support the gpio
controllers found on the Marvell Armada 7K/8K SoCs.

The gpio controllers used on the Marvell Armada 7K/8K SoCs are the
same that the ones used on the ARM32 mvebu SoCs. However, the pinctrl
node in the device tree of theses SoCs are child of a syscon. So the
driver has been converted to use the regamp in patch 2.

Then the remaining patches adds the support for the Armada 7K/8K SoCs.

All the patches can be merged through the gpio subsystem expect the
last that must be go through the mvebu subsystem.

Not that currently I didn't manage to fully test the gpio, indeed I
only have a 7040 DB board which lack of test point for this kind of
test. So any tested-by would be welcome.

Thanks,

Gregory

Gregory CLEMENT (5):
  gpio: mvebu: sort header include
  gpio: dt-bindings: Add documentation for gpio controllers on Armada 7K/8K
  gpio: mvebu: allow building driver for Armada 7K/8K
  gpio: mvebu: Add support for the Armada 7K/8K SoCs
  arm64: dts: marvell: add gpio support for Armada 7K/8K

Thomas Petazzoni (1):
  gpio: mvebu: switch to regmap for register access

 Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt  |  20 +++-
 Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt |  24 ++-
 Documentation/devicetree/bindings/gpio/gpio-mvebu.txt                      |  24 ++-
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi                               |  15 ++-
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi                               |  16 ++-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi                              |  10 +-
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi                       |  21 +++-
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi                        |  22 +++-
 drivers/gpio/Kconfig                                                       |   2 +-
 drivers/gpio/gpio-mvebu.c                                                  | 540 ++++++++++++++++++++++++++++++++++++++++++++----------------------------
 10 files changed, 477 insertions(+), 217 deletions(-)

base-commit: 9ad0dc7eff4919523e557edfb2a46c955673d25d
-- 
git-series 0.9.1
