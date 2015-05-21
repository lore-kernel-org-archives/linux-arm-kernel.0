From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 21 May 2015 15:12:51 +0800
Subject: [PATCH 0/5] Add Mediatek MT8173 subsystem clocks support
Message-ID: <1432192376-6712-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains subsystem clocks support for Mediatek MT8173.
It also contains some bug fixes before adds new clocks support.

James Liao (4):
  clk: mediatek: Fix apmixedsys clock registration
  dt-bindings: ARM: Mediatek: Document devicetree bindings for clock
    controllers
  clk: mediatek: Add subsystem clocks of MT8173
  clk: mediatek: Add USB clock support in MT8173 APMIXEDSYS

Sascha Hauer (1):
  clk: mediatek: mt8173: Fix enabling of critical clocks

 .../bindings/arm/mediatek/mediatek,imgsys.txt      |  22 +
 .../bindings/arm/mediatek/mediatek,mmsys.txt       |  22 +
 .../bindings/arm/mediatek/mediatek,vdecsys.txt     |  22 +
 .../bindings/arm/mediatek/mediatek,vencltsys.txt   |  22 +
 .../bindings/arm/mediatek/mediatek,vencsys.txt     |  22 +
 drivers/clk/mediatek/clk-mt8135.c                  |   2 +-
 drivers/clk/mediatek/clk-mt8173.c                  | 454 ++++++++++++++++++++-
 drivers/clk/mediatek/clk-pll.c                     |   7 +-
 include/dt-bindings/clock/mt8173-clk.h             |  94 ++++-
 9 files changed, 652 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vencltsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt

--
1.8.1.1.dirty
