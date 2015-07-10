From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 10 Jul 2015 18:00:00 +0800
Subject: [PATCH v3 0/5] Add Mediatek MT8173 subsystem clocks support
Message-ID: <1436522405-13923-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is based on 4.2-rc1 and [1], and contains subsystem
clocks support for Mediatek MT8173.

There are many different implementation suggestions [2][3] due to
each subsystem HW contains multiple functions, such as clock and
reset controllers.

In this patchset, I still put subsystem clock implementations in
drivers/clk/mediatek, no mater reset controllers may need to implement
in the same directory in the future. That's because many other vendors
also implement clock and reset controllers in drivers/clk, and it looks
like an acceptible way.

This patchset also contains device tree nodes that are needed by
subsystem clocks.

changes since v2:
- Rebase to 4.2-rc1.
- Add device tree nodes for subsystem clocks.
- Fine tune comments of patches.
- Add __init, __initconst and const to init data and functions.
- Removed unused code from init functions of subsystem clocks.

changes since v1:
- Add CA7PLL and CA15PLL as critical clocks.
- Use the same register descriptor for imgsys, vensys and vencltsys.
- Generalize apmixedsys special clocks registration.

[1] https://patchwork.kernel.org/patch/6446341/
[2] https://lkml.org/lkml/2015/5/21/96
[3] https://lkml.org/lkml/2015/6/29/590

James Liao (4):
  dt-bindings: ARM: Mediatek: Document devicetree bindings for clock
    controllers
  clk: mediatek: Add subsystem clocks of MT8173
  clk: mediatek: Add USB clock support in MT8173 APMIXEDSYS
  arm64: dts: mt8173: Add subsystem clock controller device nodes

Sascha Hauer (1):
  clk: mediatek: mt8173: Fix enabling of critical clocks

 .../bindings/arm/mediatek/mediatek,imgsys.txt      |  22 ++
 .../bindings/arm/mediatek/mediatek,mmsys.txt       |  22 ++
 .../bindings/arm/mediatek/mediatek,vdecsys.txt     |  22 ++
 .../bindings/arm/mediatek/mediatek,vencltsys.txt   |  22 ++
 .../bindings/arm/mediatek/mediatek,vencsys.txt     |  22 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  30 ++
 drivers/clk/mediatek/clk-mt8173.c                  | 432 ++++++++++++++++++++-
 drivers/clk/mediatek/clk-pll.c                     |   7 +-
 include/dt-bindings/clock/mt8173-clk.h             |  94 ++++-
 9 files changed, 659 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vencltsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt

--
1.8.1.1.dirty
