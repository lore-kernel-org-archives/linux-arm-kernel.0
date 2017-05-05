From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 5 May 2017 23:26:08 +0800
Subject: [PATCH 0/6] some fixups for Mediatek cpufreq driver
Message-ID: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Hi,

The purpose of the series is
- (patch 1 to 3) to fix up current Mediatek cpufreq driver
can't work with the latest tree since one required CPU clock muxer missing
would cause the driver getting the resource fails when driver probe gets
called.
- (patch 4) to enable cpufreq feature on MT2701/MT7623 platform.
- (patch 5 to 6) to update the binding document to reflect
latest driver logic and add more examples guiding people how to apply for
Mediatek cpufreq driver.

Sean Wang (6):
  clk: mediatek: add missing cpu mux causing Mediatek cpufreq can't work
  clk: mediatek: export cpu multiplexer clock for MT2701/MT7623 SoCs
  clk: mediatek: export cpu multiplexer clock for MT8173 SoCs
  cpufreq: mediatek: Add support of cpufreq to MT2701/MT7623 SoC
  dt-bindings: cpufreq: move Mediatek cpufreq dt-bindings document to
    proper place
  dt-bindings: cpufreq: enhance Mediatek cpufreq dt-binding document

 .../devicetree/bindings/clock/mt8173-cpu-dvfs.txt  |  83 -------
 .../bindings/cpufreq/cpufreq-mediatek.txt          | 247 +++++++++++++++++++++
 drivers/clk/mediatek/Makefile                      |   2 +-
 drivers/clk/mediatek/clk-cpumux.c                  | 120 ++++++++++
 drivers/clk/mediatek/clk-cpumux.h                  |  30 +++
 drivers/clk/mediatek/clk-mt2701.c                  |   8 +
 drivers/clk/mediatek/clk-mt8173.c                  |  23 ++
 drivers/cpufreq/Kconfig.arm                        |   4 +-
 drivers/cpufreq/mt8173-cpufreq.c                   |   2 +
 include/dt-bindings/clock/mt2701-clk.h             |   3 +-
 include/dt-bindings/clock/mt8173-clk.h             |   4 +-
 11 files changed, 438 insertions(+), 88 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
 create mode 100644 drivers/clk/mediatek/clk-cpumux.c
 create mode 100644 drivers/clk/mediatek/clk-cpumux.h

-- 
2.7.4
