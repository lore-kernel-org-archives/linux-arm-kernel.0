From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Fri, 15 Dec 2017 13:50:52 +0800
Subject: [PATCH v7 0/6] Mediatek MT2712 clock and scpsys support
In-Reply-To: <1511854102-23195-2-git-send-email-weiyi.lu@mediatek.com>
References: <1511854102-23195-1-git-send-email-weiyi.lu@mediatek.com>
 <1511854102-23195-2-git-send-email-weiyi.lu@mediatek.com>
Message-ID: <1513317052.30745.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-11-28 at 15:28 +0800, Weiyi Lu wrote:

Hi Matthias,
Just gentle ping. Many thanks.

> This series is based on v4.15-rc1 and composed of
> scpsys control (PATCH 1-4) and device tree (PATCH 5-6)
> 
> changes since v6:
> - Rebase to v4.15-rc1.
> 
> changes since v5:
> - Refine bus protection with proper variable name
>   and better implementation for the if statement.
> 
> changes since v4:
> - Refine scpsys and infracfg for bus protection by passing
>   a boolean flag to determine the register update method
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
> *** BLURB HERE ***
> 
> Weiyi Lu (6):
>   dt-bindings: soc: add MT2712 power dt-bindings
>   soc: mediatek: extend bus protection API
>   soc: mediatek: add dependent clock jpgdec/audio for scpsys
>   soc: mediatek: add MT2712 scpsys support
>   arm: dts: mt2712: Add clock controller device nodes
>   arm: dts: Add power controller device node of MT2712
> 
>  .../devicetree/bindings/soc/mediatek/scpsys.txt    |   3 +
>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi          | 131 +++++++++++++++++++
>  drivers/soc/mediatek/mtk-infracfg.c                |  26 +++-
>  drivers/soc/mediatek/mtk-scpsys.c                  | 140 ++++++++++++++++++---
>  include/dt-bindings/power/mt2712-power.h           |  26 ++++
>  include/linux/soc/mediatek/infracfg.h              |   7 +-
>  6 files changed, 311 insertions(+), 22 deletions(-)
>  create mode 100644 include/dt-bindings/power/mt2712-power.h
> 
