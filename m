From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 9 Mar 2015 07:15:26 +0100
Subject: [PATCH v6]: clk: Add common clock support for Mediatek MT8135
 and MT8173
In-Reply-To: <1424605765-19751-1-git-send-email-s.hauer@pengutronix.de>
References: <1424605765-19751-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150309061526.GB31436@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Sun, Feb 22, 2015 at 12:49:20PM +0100, Sascha Hauer wrote:
> This patchset contains the initial common clock support for Mediatek SoCs.
> Mediatek SoC's clock architecture comprises of various PLLs, dividers, muxes
> and clock gates.

Are these patches ok now? If yes, please pull:


The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/mtk-clk-v6

for you to fetch changes up to edfdf5ab89af79d2f9a21fefdcfa5e89e8598d53:

  dt-bindings: ARM: Mediatek: Document devicetree bindings for clock/reset controllers (2015-03-09 06:41:24 +0100)

----------------------------------------------------------------
MTK clock support v6

----------------------------------------------------------------
James Liao (3):
      clk: mediatek: Add initial common clock support for Mediatek SoCs.
      clk: mediatek: Add basic clocks for Mediatek MT8135.
      clk: mediatek: Add basic clocks for Mediatek MT8173.

Sascha Hauer (2):
      clk: mediatek: Add reset controller support
      dt-bindings: ARM: Mediatek: Document devicetree bindings for clock/reset controllers

 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |  23 +
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |  30 +
 .../bindings/arm/mediatek/mediatek,pericfg.txt     |  30 +
 .../bindings/arm/mediatek/mediatek,topckgen.txt    |  23 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/mediatek/Makefile                      |   4 +
 drivers/clk/mediatek/clk-gate.c                    | 137 ++++
 drivers/clk/mediatek/clk-gate.h                    |  49 ++
 drivers/clk/mediatek/clk-mt8135.c                  | 634 ++++++++++++++++
 drivers/clk/mediatek/clk-mt8173.c                  | 820 +++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                     | 195 +++++
 drivers/clk/mediatek/clk-mtk.h                     | 174 +++++
 drivers/clk/mediatek/clk-pll.c                     | 330 +++++++++
 drivers/clk/mediatek/reset.c                       |  99 +++
 include/dt-bindings/clock/mt8135-clk.h             | 190 +++++
 include/dt-bindings/clock/mt8173-clk.h             | 231 ++++++
 .../dt-bindings/reset-controller/mt8135-resets.h   |  64 ++
 .../dt-bindings/reset-controller/mt8173-resets.h   |  63 ++
 18 files changed, 3097 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
 create mode 100644 drivers/clk/mediatek/Makefile
 create mode 100644 drivers/clk/mediatek/clk-gate.c
 create mode 100644 drivers/clk/mediatek/clk-gate.h
 create mode 100644 drivers/clk/mediatek/clk-mt8135.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173.c
 create mode 100644 drivers/clk/mediatek/clk-mtk.c
 create mode 100644 drivers/clk/mediatek/clk-mtk.h
 create mode 100644 drivers/clk/mediatek/clk-pll.c
 create mode 100644 drivers/clk/mediatek/reset.c
 create mode 100644 include/dt-bindings/clock/mt8135-clk.h
 create mode 100644 include/dt-bindings/clock/mt8173-clk.h
 create mode 100644 include/dt-bindings/reset-controller/mt8135-resets.h
 create mode 100644 include/dt-bindings/reset-controller/mt8173-resets.h
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
