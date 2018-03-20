From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Tue, 20 Mar 2018 14:07:48 +0800
Subject: [PATCH v2 0/5] update Mediatek MT2712 clock and scpsys support
In-Reply-To: <20180312070342.4335-1-weiyi.lu@mediatek.com>
References: <20180312070342.4335-1-weiyi.lu@mediatek.com>
Message-ID: <1521526068.13313.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-03-12 at 15:03 +0800, Weiyi Lu wrote:
> This series is based on v4.16-rc1 and composed of scpsys control (PATCH 1-2) and clock control (PATCH 3-5).
> Basically, all changes are for the ECO design change of MT2712.
> 
> changes since v1:
> - Avoid renumbering clocks. Append new clocks at the bottom of each own subsystem.
> 
Hi Matthias & Stephen,

Sorry to bother. Just saw patch 1/2 are already pushed to v4.16-next-soc
and patch 3/5 are applied onto clk-next. What about the patch 4(arm64:
dts: add clock device nodes of MT2712). Does there any problem remain or
it cause some problems? Many thanks.
> Weiyi Lu (5):
>   dt-bindings: soc: update MT2712 power dt-bindings
>   soc: mediatek: update power domain data of MT2712
>   dt-bindings: clock: add clocks for MT2712
>   arm64: dts: add clock device nodes of MT2712
>   clk: mediatek: update clock driver of MT2712
> 
>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 28 +++++++++++++
>  drivers/clk/mediatek/clk-mt2712.c         | 69 ++++++++++++++++++++++++-------
>  drivers/soc/mediatek/mtk-scpsys.c         | 42 ++++++++++++++++++-
>  include/dt-bindings/clock/mt2712-clk.h    | 12 +++++-
>  include/dt-bindings/power/mt2712-power.h  |  3 ++
>  5 files changed, 136 insertions(+), 18 deletions(-)
> 
