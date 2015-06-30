From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 30 Jun 2015 10:58:43 +0800
Subject: [PATCH v2 0/4] Add Mediatek MT8173 subsystem clocks support
Message-ID: <1435633127-31952-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is based on 4.1-rc1 plus [1], and contains subsystem
clocks support for Mediatek MT8173.

There are many different implementation suggestions due to each subsystem
HW contains multiple functions, such as clock and reset controllers.

In this patch, I still put subsystem clock implementations in
drivers/clk/mediatek, no mater reset controllers may need to implement
in the same directory in the future. That's because many other vendors
also implement clock and reset controllers in drivers/clk, and it looks
like an acceptible way.

changes since v1:
- Add CA7PLL and CA15PLL as critical clocks.
- Use the same register descriptor for imgsys, vensys and vencltsys.
- Generalize apmixedsys special clocks registration.

[1] https://lkml.org/lkml/2015/5/21/97

James Liao (3):
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
 drivers/clk/mediatek/clk-mt8173.c                  | 467 ++++++++++++++++++++-
 drivers/clk/mediatek/clk-pll.c                     |   7 +-
 include/dt-bindings/clock/mt8173-clk.h             |  94 ++++-
 8 files changed, 664 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vencltsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt

--
1.8.1.1.dirty
