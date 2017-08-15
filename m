From: sean.wang@mediatek.com (Sean Wang)
Date: Tue, 15 Aug 2017 15:17:45 +0800
Subject: [PATCH v1 0/9] Mediatek MT2712 clock and scpsys support
In-Reply-To: <1502779370-30150-1-git-send-email-weiyi.lu@mediatek.com>
References: <1502779370-30150-1-git-send-email-weiyi.lu@mediatek.com>
Message-ID: <1502781465.19230.35.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, Weiyi

for patch 5 to 9, you should re-base to the latest the Matthias tree
which has some changes around scpsys since Linux v4.13-rc1

	Sean


On Tue, 2017-08-15 at 14:42 +0800, weiyi.lu at mediatek.com wrote:
> This patch set is composed of clock control (PATCH 1-4) and scpsys control (PATCH 5-9)
> 
> Weiyi Lu (9):
> [PATCH v1 1/9] dt-bindings: ARM: Mediatek: Document bindings for MT2712
> [PATCH v1 2/9] clk: mediatek: Add dt-bindings for MT2712 clocks
> [PATCH v1 3/9] clk: mediatek: Add MT2712 clock support
> [PATCH v1 4/9] arm: dts: mt2712: Add clock controller device nodes
> [PATCH v1 5/9] dt-bindings: soc: add MT2712 power dt-bindings
> [PATCH v1 6/9] soc: mediatek: add bus protection extend API
> [PATCH v1 7/9] soc: mediatek: add dependent clock jpgdec/audio for
> [PATCH v1 8/9] soc: mediatek: add MT2712 scpsys support
> [PATCH v1 9/9] arm: dts: Add power controller device node of MT2712
> 
>  .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |    1 +
>  .../bindings/arm/mediatek/mediatek,bdpsys.txt      |    1 +
>  .../bindings/arm/mediatek/mediatek,imgsys.txt      |    1 +
>  .../bindings/arm/mediatek/mediatek,infracfg.txt    |    1 +
>  .../bindings/arm/mediatek/mediatek,jpgdecsys.txt   |   22 +
>  .../bindings/arm/mediatek/mediatek,mcucfg.txt      |   22 +
>  .../bindings/arm/mediatek/mediatek,mfgcfg.txt      |   22 +
>  .../bindings/arm/mediatek/mediatek,mmsys.txt       |    1 +
>  .../bindings/arm/mediatek/mediatek,pericfg.txt     |    1 +
>  .../bindings/arm/mediatek/mediatek,topckgen.txt    |    1 +
>  .../bindings/arm/mediatek/mediatek,vdecsys.txt     |    1 +
>  .../bindings/arm/mediatek/mediatek,vencsys.txt     |    1 +
>  .../devicetree/bindings/soc/mediatek/scpsys.txt    |    3 +
>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |  130 ++
>  drivers/clk/mediatek/Kconfig                       |   50 +
>  drivers/clk/mediatek/Makefile                      |    8 +
>  drivers/clk/mediatek/clk-mt2712-bdp.c              |  102 ++
>  drivers/clk/mediatek/clk-mt2712-img.c              |   80 ++
>  drivers/clk/mediatek/clk-mt2712-jpgdec.c           |   76 ++
>  drivers/clk/mediatek/clk-mt2712-mfg.c              |   75 ++
>  drivers/clk/mediatek/clk-mt2712-mm.c               |  170 +++
>  drivers/clk/mediatek/clk-mt2712-vdec.c             |   94 ++
>  drivers/clk/mediatek/clk-mt2712-venc.c             |   77 ++
>  drivers/clk/mediatek/clk-mt2712.c                  | 1400 ++++++++++++++++++++
>  drivers/clk/mediatek/clk-mtk.h                     |    2 +
>  drivers/clk/mediatek/clk-pll.c                     |   13 +-
>  drivers/soc/mediatek/mtk-infracfg.c                |   90 +-
>  drivers/soc/mediatek/mtk-scpsys.c                  |  160 ++-
>  include/dt-bindings/clock/mt2712-clk.h             |  428 ++++++
>  include/dt-bindings/power/mt2712-power.h           |   26 +
>  include/linux/soc/mediatek/infracfg.h              |   14 +-
>  31 files changed, 3057 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,jpgdecsys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mcucfg.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
>  create mode 100644 drivers/clk/mediatek/clk-mt2712-bdp.c
>  create mode 100644 drivers/clk/mediatek/clk-mt2712-img.c
>  create mode 100644 drivers/clk/mediatek/clk-mt2712-jpgdec.c
>  create mode 100644 drivers/clk/mediatek/clk-mt2712-mfg.c
>  create mode 100644 drivers/clk/mediatek/clk-mt2712-mm.c
>  create mode 100644 drivers/clk/mediatek/clk-mt2712-vdec.c
>  create mode 100644 drivers/clk/mediatek/clk-mt2712-venc.c
>  create mode 100644 drivers/clk/mediatek/clk-mt2712.c
>  create mode 100644 include/dt-bindings/clock/mt2712-clk.h
>  create mode 100644 include/dt-bindings/power/mt2712-power.h
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
