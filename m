From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 24 Jul 2015 11:01:58 +0800
Subject: [PATCH v4 0/7] Add Mediatek MT8173 subsystem clocks support
Message-ID: <1437706925-3222-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is based on 4.2-rc1 and [1], and contains subsystem
clocks support for Mediatek MT8173.

Previous reviews can be found in [2][3]. This patchset merge the 2
patchsets because of the dependency.

The most different from previous patchset are removing clk_null and
split usb clock support into a separated source file.

changes since v3:
- Remove clk_null dependency from root clocks.
- Use fixed-rate clocks with typical rate to replace clk_null.
- Add clk-apmixed.c to implement ref2usb_tx.
- Use clock-controller as the name of clock providers.

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
[2] https://lkml.org/lkml/2015/7/10/254
[3] https://lkml.org/lkml/2015/7/10/230

James Liao (6):
  clk: mediatek: Add fixed clocks support for Mediatek SoC.
  clk: mediatek: Fix rate and dependency of MT8173 clocks
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
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  37 +++
 drivers/clk/mediatek/Makefile                      |   2 +-
 drivers/clk/mediatek/clk-apmixed.c                 | 137 +++++++++
 drivers/clk/mediatek/clk-mt8173.c                  | 321 ++++++++++++++++++++-
 drivers/clk/mediatek/clk-mtk.c                     |  23 ++
 drivers/clk/mediatek/clk-mtk.h                     |  45 ++-
 drivers/clk/mediatek/clk-pll.c                     |   7 +-
 include/dt-bindings/clock/mt8173-clk.h             | 101 ++++++-
 13 files changed, 756 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vencltsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
 create mode 100644 drivers/clk/mediatek/clk-apmixed.c

--
1.8.1.1.dirty
