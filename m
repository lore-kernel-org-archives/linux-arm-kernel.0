From: djkurtz@chromium.org (Daniel Kurtz)
Date: Tue, 4 Aug 2015 21:46:12 +0800
Subject: [PATCH v6 0/9] Fixes and new clocks support for Mediatek MT8173
In-Reply-To: <1438676218-11310-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1438676218-11310-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <CAGS+omDce5HMT6irZfNA-DpC3xNq1vbJ6jxM_6KT-jYgE5JU0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 4, 2015 at 4:16 PM, James Liao <jamesjj.liao@mediatek.com> wrote:
> This patchset is based on 4.2-rc2 and [1], and contains minor fixes and
> subsystem clocks support for Mediatek MT8173.
>
> The previous reviews can be found in [2]. The most different from previous
> patchset is rebasing to 4.2-rc2.

For the whole series:

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>


>
> changes since v5:
> - Rebase to 4.2-rc2.
> - Patch "Fix enabling of critical clocks" had been included in 4.2-rc2,
>   so it need not be included in this patchset.
>
> changes since v4:
> - Add a separated patch to remove unused dpi_ck.
> - Add separated patches to fix clk/mediatek in release 4.2-rc1.
> - Add __init* for initialization data and functions.
> - Rename dummy_clk with oscillator in DT.
> - Remove mtk_clk_register_apmixed_ex(), call mtk_clk_register_ref2usb_tx()
>   directly to register USB clock.
>
> changes since v3:
> - Remove clk_null dependency from root clocks.
> - Use fixed-rate clocks with typical rate to replace clk_null.
> - Separate ref2usb_tx implementation to clk-apmixed.c
> - Use clock-controller as the name of clock providers.
>
> changes since v2:
> - Rebase to 4.2-rc1.
> - Add device tree nodes for subsystem clocks.
> - Fine tune comments of patches.
> - Add __init, __initconst and const to init data and functions.
> - Removed unused code from init functions of subsystem clocks.
>
> changes since v1:
> - Add CA7PLL and CA15PLL as critical clocks.
> - Use the same register descriptor for imgsys, vensys and vencltsys.
> - Generalize apmixedsys special clocks registration.
>
> [1] https://patchwork.kernel.org/patch/6446341/
> [2] http://lists.infradead.org/pipermail/linux-mediatek/2015-July/001800.html
>
> James Liao (9):
>   clk: mediatek: Removed unused dpi_ck clock from MT8173
>   clk: mediatek: Remove unused code from MT8173.
>   clk: mediatek: Add __initdata and __init for data and functions
>   clk: mediatek: Add fixed clocks support for Mediatek SoC.
>   clk: mediatek: Fix rate and dependency of MT8173 clocks
>   dt-bindings: ARM: Mediatek: Document devicetree bindings for clock
>     controllers
>   clk: mediatek: Add subsystem clocks of MT8173
>   clk: mediatek: Add USB clock support in MT8173 APMIXEDSYS
>   arm64: dts: mt8173: Add subsystem clock controller device nodes
>
>  .../bindings/arm/mediatek/mediatek,imgsys.txt      |  22 ++
>  .../bindings/arm/mediatek/mediatek,mmsys.txt       |  22 ++
>  .../bindings/arm/mediatek/mediatek,vdecsys.txt     |  22 ++
>  .../bindings/arm/mediatek/mediatek,vencltsys.txt   |  22 ++
>  .../bindings/arm/mediatek/mediatek,vencsys.txt     |  22 ++
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  37 +++
>  drivers/clk/mediatek/Makefile                      |   2 +-
>  drivers/clk/mediatek/clk-apmixed.c                 | 107 +++++++
>  drivers/clk/mediatek/clk-gate.c                    |   2 +-
>  drivers/clk/mediatek/clk-mt8173.c                  | 335 ++++++++++++++++++++-
>  drivers/clk/mediatek/clk-mtk.c                     |  36 ++-
>  drivers/clk/mediatek/clk-mtk.h                     |  24 +-
>  drivers/clk/mediatek/clk-pll.c                     |   7 +-
>  include/dt-bindings/clock/mt8173-clk.h             | 101 ++++++-
>  14 files changed, 728 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vencltsys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
>  create mode 100644 drivers/clk/mediatek/clk-apmixed.c
>
> --
> 1.8.1.1.dirty
>
