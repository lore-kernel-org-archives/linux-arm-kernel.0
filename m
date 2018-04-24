From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Apr 2018 06:48:54 +0100
Subject: [v2 00/10] arm/arm64: mediatek: Fix mmsys device probing
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
Message-ID: <20180424054854.bpd6h3imazhqnuy3@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Apr 2018, matthias.bgg at kernel.org wrote:

> From: Matthias Brugger <mbrugger@suse.com>
> 
> Changes since v1:
> - add binding documentation
> - ddp: use regmap_update_bits
> - ddp: ignore EPROBE_DEFER on clock probing
> - mfd: delete mmsys_private
> - add Reviewed-by and Acked-by tags

I'm confused by the double submission.

Please can you send it again completely detached from the first and
the second submissions please?

> ---
> 
> MMSYS in Mediatek SoCs has some registers to control clock gates (which is 
> used in the clk driver) and some registers to set the routing and enable
> the differnet blocks of the display subsystem.
> 
> Up to now both drivers, clock and drm are probed with the same device tree
> compatible. But only the first driver get probed, which in effect breaks
> graphics on mt8173 and mt2701.
> 
> This patch set introduces a new mfd device, which binds against the mmsys
> compatible and takes care of probing the needed devices. It was tested on the
> bananapi-r2 and the Acer R13 Chromebook.
> 
> 
> Matthias Brugger (10):
>   dt-bindings: mediatek: mmsys: Add support for mfd
>   drm/mediatek: Use regmap for register access
>   mfd: mtk-mmsys: Add mmsys driver
>   drm/mediatek: mt2701: switch to mfd probing.
>   clk: mediatek: mt2701-mm: switch to mfd device
>   mfd: mtk-mmsys: Add mt8173 nodes
>   drm/mediatek: Add mfd support for mt8173
>   clk: mediatek: mt8173-mm: switch to mfd device
>   drm: mediatek: Omit warning on probe defers
>   MAINTAINERS: update Mediatek Soc entry
> 
>  .../bindings/arm/mediatek/mediatek,mmsys.txt       |  2 -
>  .../bindings/display/mediatek/mediatek,disp.txt    |  2 +-
>  .../devicetree/bindings/mfd/mediatek,mmsys.txt     | 27 +++++++
>  MAINTAINERS                                        |  2 +
>  drivers/clk/mediatek/clk-mt2701-mm.c               | 10 +--
>  drivers/clk/mediatek/clk-mt8173.c                  | 17 +++-
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  4 +-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 41 ++++------
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.h             |  4 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c             | 33 ++++----
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h             |  2 +-
>  drivers/mfd/Kconfig                                |  9 +++
>  drivers/mfd/Makefile                               |  2 +
>  drivers/mfd/mtk-mmsys.c                            | 93 ++++++++++++++++++++++
>  14 files changed, 189 insertions(+), 59 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
>  create mode 100644 drivers/mfd/mtk-mmsys.c
> 

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
