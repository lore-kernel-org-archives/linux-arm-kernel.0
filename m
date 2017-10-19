From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 19 Oct 2017 19:06:14 +0200
Subject: [PATCH v5 0/9] Mediatek MT2712 clock and scpsys support
In-Reply-To: <1508381330-3700-1-git-send-email-weiyi.lu@mediatek.com>
References: <1508381330-3700-1-git-send-email-weiyi.lu@mediatek.com>
Message-ID: <e67f2b01-552b-e9b3-6c38-141e3063439d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/19/2017 04:48 AM, Weiyi Lu wrote:
> This series is based on v4.14-rc1 and composed of
> clock control (PATCH 1-4) and scpsys control (PATCH 5-9)
> 
> changes since v4:
> - Refine scpsys and infracfg for bus protection by passing 
>   a boolean flag to determine the register update method.
> 
> changes since v3:
> - Rebase to v4.14-rc1.
> 
> changes since v2:
> - ensure the clocks used by clocksource driver are registered
>   before clocksource init() by using CLK_OF_DECLARE()
> - correct the frequency of clk32k/clkrtc_ext/clkrtc_int
> 
> changes since v1:
> - Rebase to v4.13-next-soc.
> - Refine scpsys and infracfg for bus protection.
> 
> Weiyi Lu (9):
>   dt-bindings: ARM: Mediatek: Document bindings for MT2712
>   clk: mediatek: Add dt-bindings for MT2712 clocks
>   clk: mediatek: Add MT2712 clock support

Stephen, Mike: are you ok with the patches 1-3 of this series?

If so, then I will take the rest through my tree.

Thanks,
Matthias

>   arm: dts: mt2712: Add clock controller device nodes
>   dt-bindings: soc: add MT2712 power dt-bindings
>   soc: mediatek: extend bus protection API
>   soc: mediatek: add dependent clock jpgdec/audio for scpsys
>   soc: mediatek: add MT2712 scpsys support
>   arm: dts: Add power controller device node of MT2712
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
>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |  131 ++
>  drivers/clk/mediatek/Kconfig                       |   50 +
>  drivers/clk/mediatek/Makefile                      |    8 +
>  drivers/clk/mediatek/clk-mt2712-bdp.c              |  102 ++
>  drivers/clk/mediatek/clk-mt2712-img.c              |   80 ++
>  drivers/clk/mediatek/clk-mt2712-jpgdec.c           |   76 ++
>  drivers/clk/mediatek/clk-mt2712-mfg.c              |   75 +
>  drivers/clk/mediatek/clk-mt2712-mm.c               |  170 +++
>  drivers/clk/mediatek/clk-mt2712-vdec.c             |   94 ++
>  drivers/clk/mediatek/clk-mt2712-venc.c             |   77 ++
>  drivers/clk/mediatek/clk-mt2712.c                  | 1435 ++++++++++++++++++++
>  drivers/clk/mediatek/clk-mtk.h                     |    2 +
>  drivers/clk/mediatek/clk-pll.c                     |   13 +-
>  drivers/soc/mediatek/mtk-infracfg.c                |   24 +-
>  drivers/soc/mediatek/mtk-scpsys.c                  |  140 +-
>  include/dt-bindings/clock/mt2712-clk.h             |  427 ++++++
>  include/dt-bindings/power/mt2712-power.h           |   26 +
>  include/linux/soc/mediatek/infracfg.h              |    7 +-
>  31 files changed, 2991 insertions(+), 24 deletions(-)
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
