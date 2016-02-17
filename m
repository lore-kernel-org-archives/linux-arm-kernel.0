From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 17 Feb 2016 17:14:52 +0100
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.6 (#1)
Message-ID: <877fi3s48z.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt64 for mvebu for v4.6.

This is the second part of the Armada 3700 series[1]. This part is
easier to handle as there is no dependency. As for the other one, let me
know if I should do it in a different way.

Thanks,

Gregory

[1]: https://lkml.org/lkml/2016/2/16/735

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.6-1

for you to fetch changes up to adbc3695d9e487fa07214140a46b68ac3156fb78:

  arm64: dts: add the Marvell Armada 3700 family and a development board (2016-02-17 16:09:55 +0100)

----------------------------------------------------------------
mvebu dt64 for 4.6 (part 1)

Device tree part of the Armada 3700 support:
- binding for the Armada 3700 SoCs
- device tree files for the SoCs and a board
- tidy up the Marvell related files

----------------------------------------------------------------
Gregory CLEMENT (4):
      Documentation: dt-bindings: Add a new compatible for the Armada 3700
      Documentation: dt: Tidy up the Marvell related files
      devicetree: bindings: add DT binding for the Marvell Armada 3700 SoC family
      arm64: dts: add the Marvell Armada 3700 family and a development board

 .../arm/{ => marvell}/armada-370-xp-pmsu.txt       |   0
 .../bindings/arm/{ => marvell}/armada-370-xp.txt   |   0
 .../bindings/arm/{ => marvell}/armada-375.txt      |   0
 .../bindings/arm/marvell/armada-37xx.txt           |  16 +++
 .../{ => marvell}/armada-380-mpcore-soc-ctrl.txt   |   0
 .../bindings/arm/{ => marvell}/armada-38x.txt      |   0
 .../bindings/arm/{ => marvell}/armada-39x.txt      |   0
 .../arm/{ => marvell}/armada-cpu-reset.txt         |   0
 .../arm/{ => marvell}/coherency-fabric.txt         |   0
 .../bindings/arm/{ => marvell}/kirkwood.txt        |   0
 .../bindings/arm/{ => marvell}/marvell,berlin.txt  |   0
 .../bindings/arm/{ => marvell}/marvell,dove.txt    |   0
 .../arm/{ => marvell}/marvell,kirkwood.txt         |   0
 .../arm/{ => marvell}/mvebu-cpu-config.txt         |   0
 .../arm/{ => marvell}/mvebu-system-controller.txt  |   0
 .../devicetree/bindings/ata/ahci-platform.txt      |   1 +
 arch/arm64/boot/dts/marvell/Makefile               |   4 +
 arch/arm64/boot/dts/marvell/armada-371x.dtsi       |  53 +++++++++
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |  86 ++++++++++++++
 arch/arm64/boot/dts/marvell/armada-372x.dtsi       |  63 ++++++++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       | 131 +++++++++++++++++++++
 21 files changed, 354 insertions(+)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-370-xp-pmsu.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-370-xp.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-375.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-380-mpcore-soc-ctrl.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-38x.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-39x.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-cpu-reset.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/coherency-fabric.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/kirkwood.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/marvell,berlin.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/marvell,dove.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/marvell,kirkwood.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/mvebu-cpu-config.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/mvebu-system-controller.txt (100%)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-371x.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-db.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-372x.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-37xx.dtsi
