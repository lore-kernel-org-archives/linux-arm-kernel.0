From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 20 Sep 2017 17:49:24 +0800
Subject: [PATCH 0/4] add support of clock driver on MediaTek MT7622
Message-ID: <cover.1505890481.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add clock driver required by each function driver on MT7622 SoC with
adding all clocks exported from every hardware subsystem such as topckgen,
apmixedsys, infracfg, pericfg , pciessys, ssusbsys, ethsys and audsys.

Chen Zhong (2):
  clk: mediatek: add the option for determining PLL source clock
  clk: mediatek: add clocks dt-bindings required header for MT7622 SoC

Sean Wang (2):
  dt-bindings: clock: mediatek: document clk bindings for MediaTek
    MT7622 SoC
  clk: mediatek: add clock support for MT7622 SoC

 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |   1 +
 .../bindings/arm/mediatek/mediatek,audsys.txt      |  22 +
 .../bindings/arm/mediatek/mediatek,ethsys.txt      |   1 +
 .../bindings/arm/mediatek/mediatek,hifsys.txt      |   1 +
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |   1 +
 .../bindings/arm/mediatek/mediatek,pciesys.txt     |  22 +
 .../bindings/arm/mediatek/mediatek,pericfg.txt     |   1 +
 .../bindings/arm/mediatek/mediatek,sgmiisys.txt    |  22 +
 .../bindings/arm/mediatek/mediatek,ssusbsys.txt    |  22 +
 .../bindings/arm/mediatek/mediatek,topckgen.txt    |   1 +
 drivers/clk/mediatek/Kconfig                       |  30 +
 drivers/clk/mediatek/Makefile                      |   4 +
 drivers/clk/mediatek/clk-mt7622-aud.c              | 195 ++++++
 drivers/clk/mediatek/clk-mt7622-eth.c              | 156 +++++
 drivers/clk/mediatek/clk-mt7622-hif.c              | 169 +++++
 drivers/clk/mediatek/clk-mt7622.c                  | 780 +++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.h                     |   1 +
 drivers/clk/mediatek/clk-pll.c                     |   5 +-
 include/dt-bindings/clock/mt7622-clk.h             | 289 ++++++++
 19 files changed, 1722 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
 create mode 100644 drivers/clk/mediatek/clk-mt7622-aud.c
 create mode 100644 drivers/clk/mediatek/clk-mt7622-eth.c
 create mode 100644 drivers/clk/mediatek/clk-mt7622-hif.c
 create mode 100644 drivers/clk/mediatek/clk-mt7622.c
 create mode 100644 include/dt-bindings/clock/mt7622-clk.h

-- 
2.7.4
