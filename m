From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 5 Jan 2016 14:30:16 +0800
Subject: [PATCH v2 0/6] Add clock support for Mediatek MT2701 
Message-ID: <1451975422-31174-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is based on 4.4-rc7, add clock and reset controller support
for Mediatek MT2701.

This patchset also refined makefile and Kconfig to support configurable
multiple SoC clock support.

changes since v1:
- Document MT2701 compatible strings.

James Liao (2):
  clk: mediatek: Refine the makefile to support multiple clock drivers
  dt-bindings: ARM: Mediatek: Document bindings for MT2701

Shunli Wang (4):
  clk: mediatek: Add dt-bindings for MT2701 clocks
  clk: mediatek: Add MT2701 clock support
  reset: mediatek: mt2701 reset controller dt-binding file
  reset: mediatek: mt2701 reset driver

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
 drivers/clk/mediatek/clk-gate.c                    |   56 +
 drivers/clk/mediatek/clk-gate.h                    |    2 +
 drivers/clk/mediatek/clk-mt2701.c                  | 1214 ++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                     |   25 +
 drivers/clk/mediatek/clk-mtk.h                     |   35 +-
 include/dt-bindings/clock/mt2701-clk.h             |  481 ++++++++
 .../dt-bindings/reset-controller/mt2701-resets.h   |   74 ++
 20 files changed, 1993 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
 create mode 100644 drivers/clk/mediatek/Kconfig
 create mode 100644 drivers/clk/mediatek/clk-mt2701.c
 create mode 100644 include/dt-bindings/clock/mt2701-clk.h
 create mode 100644 include/dt-bindings/reset-controller/mt2701-resets.h

--
1.9.1
