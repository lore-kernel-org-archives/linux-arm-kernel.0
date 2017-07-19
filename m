From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Jul 2017 08:23:48 +0200
Subject: [PATCH] gpu: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-24-robh@kernel.org>
References: <20170718214339.7774-24-robh@kernel.org>
Message-ID: <20170719062348.3epnl4u6vdnkx5cb@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 04:43:04PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
> Cc: Rongrong Zou <zourongrong@gmail.com>
> Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Cc: Chen Feng <puck.chen@hisilicon.com>
> Cc: CK Hu <ck.hu@mediatek.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Mark Yao <mark.yao@rock-chips.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jyri Sarha <jsarha@ti.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: dri-devel at lists.freedesktop.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-mediatek at lists.infradead.org
> Cc: linux-amlogic at lists.infradead.org
> Cc: linux-renesas-soc at vger.kernel.org
> Cc: linux-rockchip at lists.infradead.org
> ---
>  drivers/gpu/drm/armada/armada_crtc.c            |  3 +--
>  drivers/gpu/drm/armada/armada_drv.c             |  4 ++--
>  drivers/gpu/drm/drm_mipi_dsi.c                  |  6 +++---
>  drivers/gpu/drm/drm_modes.c                     |  4 ++--
>  drivers/gpu/drm/drm_of.c                        |  4 ++--
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c         |  3 +--
>  drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c |  3 +--
>  drivers/gpu/drm/mediatek/mtk_disp_color.c       |  4 ++--
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c         |  4 ++--
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c        |  4 ++--
>  drivers/gpu/drm/mediatek/mtk_dpi.c              |  6 +++---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c         |  7 +++----
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c     |  6 ++----
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c          | 16 ++++++++--------
>  drivers/gpu/drm/mediatek/mtk_dsi.c              |  4 ++--
>  drivers/gpu/drm/mediatek/mtk_hdmi.c             |  8 ++++----
>  drivers/gpu/drm/meson/meson_drv.c               |  5 ++---
>  drivers/gpu/drm/panel/panel-lvds.c              | 16 ++++++++--------
>  drivers/gpu/drm/rcar-du/rcar_du_encoder.c       |  4 ++--
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c           | 16 ++++++++--------
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c     |  4 ++--
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c     |  4 ++--
>  drivers/gpu/drm/stm/ltdc.c                      |  3 +--
>  drivers/gpu/drm/sun4i/sun4i_drv.c               |  9 ++++-----

For sun4i-drm:
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170719/025aa192/attachment.sig>
