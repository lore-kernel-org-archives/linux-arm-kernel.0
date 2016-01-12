From: blogic@openwrt.org (John Crispin)
Date: Tue, 12 Jan 2016 11:10:14 +0100
Subject: [PATCH v3 0/6] Add clock support for Mediatek MT2701
In-Reply-To: <1452587470-61506-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1452587470-61506-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <5694D106.2030009@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 12/01/2016 09:31, James Liao wrote:
> This patchset is based on 4.4-rc7, add clock and reset controller support
> for Mediatek MT2701.
> 
> This patchset also refined makefile and Kconfig to support configurable
> multiple SoC clock support.
> 
> changes since v2:
> - Fix ethsys definition.
> - Replace read-modify-write with regmap_update_bits() in clock operations.
> - Move mt2701-resets.h to include/dt-bindings/reset/.
> - Add hifsys reset patch from John Crispin.

thanks for folding the fixup.

i have been testing your V2 on MT7623 for several days now and updated
to V3 this morning which works just as well. feel free to add

Tested-by: John Crispin <blogic@openwrt.org>


	John


> changes since v1:
> - Document MT2701 compatible strings.
> 
> James Liao (2):
>   clk: mediatek: Refine the makefile to support multiple clock drivers
>   dt-bindings: ARM: Mediatek: Document bindings for MT2701
> 
> Shunli Wang (4):
>   clk: mediatek: Add dt-bindings for MT2701 clocks
>   clk: mediatek: Add MT2701 clock support
>   reset: mediatek: Add MT2701 reset controller dt-binding file
>   reset: mediatek: Add MT2701 reset driver
> 
>  .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |    1 +
>  .../bindings/arm/mediatek/mediatek,bdpsys.txt      |   22 +
>  .../bindings/arm/mediatek/mediatek,ethsys.txt      |   22 +
>  .../bindings/arm/mediatek/mediatek,hifsys.txt      |   22 +
>  .../bindings/arm/mediatek/mediatek,imgsys.txt      |    1 +
>  .../bindings/arm/mediatek/mediatek,infracfg.txt    |    1 +
>  .../bindings/arm/mediatek/mediatek,mmsys.txt       |    1 +
>  .../bindings/arm/mediatek/mediatek,pericfg.txt     |    1 +
>  .../bindings/arm/mediatek/mediatek,topckgen.txt    |    1 +
>  .../bindings/arm/mediatek/mediatek,vdecsys.txt     |    1 +
>  drivers/clk/Kconfig                                |    1 +
>  drivers/clk/mediatek/Kconfig                       |   31 +
>  drivers/clk/mediatek/Makefile                      |    7 +-
>  drivers/clk/mediatek/clk-gate.c                    |   52 +
>  drivers/clk/mediatek/clk-gate.h                    |    2 +
>  drivers/clk/mediatek/clk-mt2701.c                  | 1216 ++++++++++++++++++++
>  drivers/clk/mediatek/clk-mtk.c                     |   25 +
>  drivers/clk/mediatek/clk-mtk.h                     |   35 +-
>  include/dt-bindings/clock/mt2701-clk.h             |  481 ++++++++
>  include/dt-bindings/reset/mt2701-resets.h          |   83 ++
>  20 files changed, 2000 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
>  create mode 100644 drivers/clk/mediatek/Kconfig
>  create mode 100644 drivers/clk/mediatek/clk-mt2701.c
>  create mode 100644 include/dt-bindings/clock/mt2701-clk.h
>  create mode 100644 include/dt-bindings/reset/mt2701-resets.h
> 
> --
> 1.9.1
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
