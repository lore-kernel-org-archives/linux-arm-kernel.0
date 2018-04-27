From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 27 Apr 2018 16:14:41 +0800
Subject: [PATCH v2 0/6] add Mali-450 support to MT7623 SoC
Message-ID: <cover.1524816502.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

v2:
   changes from v1 to v2:
 	- Add Reviewed-by tag from v1 result
 	- Split out the changes for dt-bindings .h from the changes for driver
 	- Fix up the typo in g3dsys dt-bindings documentation
v1:

Hi,

The series adds a required resource setup to allow Mali-450 to work on
MT7623. This also can benefits other MediaTek SoCs having Mali-450 device.

In order to prove the setup is proper, I also have added mediatek port to
linux-lima at [1] and make a few of tests along with off-screen rendering
[2][3][4][5][6][7] through mesa-lima [8]. All work correctly.

[1] https://github.com/objelf/linux-lima/tree/mediatek-lima-4.16-rc5
[2] simple triangle: https://github.com/yuq/gfx/tree/master/gbm-surface
[3] vertex shader uniform: https://github.com/yuq/gfx/tree/master/gbm-surface-move
[4] multi varying: https://github.com/yuq/gfx/tree/master/gbm-surface-color
[5] multi draw: https://github.com/yuq/gfx/tree/master/gbm-surface-draw
[6] FBO: https://github.com/yuq/gfx/tree/master/gbm-surface-fbo
[7] kmscube: https://github.com/yuq/kmscube
[8] https://github.com/yuq/mesa-lima

Hope these patches can help people working on BPI-R2.

	Sean

Sean Wang (6):
  dt-bindings: gpu: mali-utgard: add mediatek,mt7623-mali compatible
  dt-bindings: clock: mediatek: add g3dsys bindings
  dt-bindings: clock: mediatek: add entry for Mali-450 node to refer
  dt-bindings: reset: mediatek: add entry for Mali-450 node to refer
  clk: mediatek: add g3dsys support for MT2701 and MT7623
  arm: dts: mt7623: add Mali-450 and related device nodes

 .../bindings/arm/mediatek/mediatek,g3dsys.txt      | 30 +++++++
 .../devicetree/bindings/gpu/arm,mali-utgard.txt    |  9 ++
 arch/arm/boot/dts/mt7623.dtsi                      | 70 ++++++++++++++++
 arch/arm/boot/dts/mt7623a.dtsi                     |  4 +
 drivers/clk/mediatek/Kconfig                       |  6 ++
 drivers/clk/mediatek/Makefile                      |  1 +
 drivers/clk/mediatek/clk-mt2701-g3d.c              | 95 ++++++++++++++++++++++
 include/dt-bindings/clock/mt2701-clk.h             |  4 +
 include/dt-bindings/reset/mt2701-resets.h          |  3 +
 9 files changed, 222 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,g3dsys.txt
 create mode 100644 drivers/clk/mediatek/clk-mt2701-g3d.c

-- 
2.7.4
