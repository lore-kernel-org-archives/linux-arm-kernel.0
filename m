From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 30 Dec 2015 14:27:40 +0800
Subject: [PATCH 0/5] Add clock support for Mediatek MT2701 
Message-ID: <1451456865-44139-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is based on 4.4-rc7, add clock and reset controller support
for Mediatek MT2701.

This patchset also refined makefile and Kconfig to support configurable
multiple SoC clock support.

James Liao (1):
  clk: mediatek: Refine the makefile to support multiple clock drivers

Shunli Wang (4):
  clk: mediatek: Add dt-bindings for MT2701 clocks
  clk: mediatek: Add MT2701 clock support
  reset: mediatek: mt2701 reset controller dt-binding file
  reset: mediatek: mt2701 reset driver

 drivers/clk/Kconfig                                |    1 +
 drivers/clk/mediatek/Kconfig                       |   31 +
 drivers/clk/mediatek/Makefile                      |    7 +-
 drivers/clk/mediatek/clk-gate.c                    |   56 +
 drivers/clk/mediatek/clk-gate.h                    |    2 +
 drivers/clk/mediatek/clk-mt2701.c                  | 1215 ++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                     |   25 +
 drivers/clk/mediatek/clk-mtk.h                     |   35 +-
 include/dt-bindings/clock/mt2701-clk.h             |  481 ++++++++
 .../dt-bindings/reset-controller/mt2701-resets.h   |   74 ++
 10 files changed, 1921 insertions(+), 6 deletions(-)
 create mode 100644 drivers/clk/mediatek/Kconfig
 create mode 100644 drivers/clk/mediatek/clk-mt2701.c
 create mode 100644 include/dt-bindings/clock/mt2701-clk.h
 create mode 100644 include/dt-bindings/reset-controller/mt2701-resets.h

--
1.9.1
