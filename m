From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 20 Jan 2016 14:35:41 +0800
Subject: [PATCH v4 0/6] Add clock support for Mediatek MT2701
Message-ID: <1453271747-57397-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is based on 4.4-rc7, add clock and reset controller
support for Mediatek MT2701.

This patchset also refined makefile and Kconfig to support configurable
multiple SoC clock support.

There is only a minor change since v3, which is correcting the parent
of mm_mdp_bls_26m.

changes since v3:
- Change the parent of mm_mdp_bls_26m from clk26m to pwm_sel.

changes since v2:
- Fix ethsys definition.
- Replace read-modify-write with regmap_update_bits() in clock operations.
- Move mt2701-resets.h to include/dt-bindings/reset/.
- Add hifsys reset patch from John Crispin.

changes since v1:
- Document MT2701 compatible strings.

James Liao (2):
  clk: mediatek: Refine the makefile to support multiple clock drivers
  dt-bindings: ARM: Mediatek: Document bindings for MT2701

Shunli Wang (4):
  clk: mediatek: Add dt-bindings for MT2701 clocks
  clk: mediatek: Add MT2701 clock support
  reset: mediatek: Add MT2701 reset controller dt-binding file
  reset: mediatek: Add MT2701 reset driver

James Liao (2):
  clk: mediatek: Refine the makefile to support multiple clock drivers
  dt-bindings: ARM: Mediatek: Document bindings for MT2701

Shunli Wang (4):
  clk: mediatek: Add dt-bindings for MT2701 clocks
  clk: mediatek: Add MT2701 clock support
  reset: mediatek: Add MT2701 reset controller dt-binding file
  reset: mediatek: Add MT2701 reset driver

 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |    1 +
 .../bindings/arm/mediatek/mediatek,bdpsys.txt      |   22 +
 .../bindings/arm/mediatek/mediatek,ethsys.txt      |   22 +
 .../bindings/arm/mediatek/mediatek,hifsys.txt      |   22 +
 .../bindings/arm/mediatek/mediatek,imgsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |    1 +
 .../bindings/arm/mediatek/mediatek,mmsys.txt       |    1 +
 .../bindings/arm/mediatek/mediatek,pericfg.txt     |    1 +
 .../bindings/arm/mediatek/mediatek,topckgen.txt    |    1 +
 .../bindings/arm/mediatek/mediatek,vdecsys.txt     |    1 +
 drivers/clk/Kconfig                                |    1 +
 drivers/clk/mediatek/Kconfig                       |   31 +
 drivers/clk/mediatek/Makefile                      |    7 +-
 drivers/clk/mediatek/clk-gate.c                    |   52 +
 drivers/clk/mediatek/clk-gate.h                    |    2 +
 drivers/clk/mediatek/clk-mt2701.c                  | 1216 ++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                     |   25 +
 drivers/clk/mediatek/clk-mtk.h                     |   35 +-
 include/dt-bindings/clock/mt2701-clk.h             |  481 ++++++++
 include/dt-bindings/reset/mt2701-resets.h          |   83 ++
 20 files changed, 2000 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
 create mode 100644 drivers/clk/mediatek/Kconfig
 create mode 100644 drivers/clk/mediatek/clk-mt2701.c
 create mode 100644 include/dt-bindings/clock/mt2701-clk.h
 create mode 100644 include/dt-bindings/reset/mt2701-resets.h

--
1.9.1
