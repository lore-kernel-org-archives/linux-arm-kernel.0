From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 2 Aug 2017 12:46:12 +0800
Subject: [linux-sunxi] [PATCH 00/13] Allwinner H3 DE2 basical support
In-Reply-To: <20170801131304.7741-1-icenowy@aosc.io>
References: <20170801131304.7741-1-icenowy@aosc.io>
Message-ID: <CAGb2v64giQbwJK+Yp=EN0jVDN3eHA_Yf_X3gR-hfC6j_u3z9PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 1, 2017 at 9:12 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Allwinner H3 features a "Display Engine 2.0", which needs some support
> to be present in the DRM driver.
>
> This patchset is now a basical version, which dropped some features I
> used to submitted:
> - TVE support (not so high priority now)
> - Multi-pipeline support (also not so high priority now due to no TVE)

Even though you dropped some patches, this is still v3.

What has changed since v2?

>
> The last 6 patches are only used for testing this patchset, and they're
> going to be sent by Jernej Skrabec after this patchset is applied.
>
> Icenowy Zheng (9):
>   dt-bindings: update the binding for Allwinner H3 DE2 support
>   drm: sun4i: add support for H3 mixers
>   drm: sun4i: add support for H3's TCON
>   drm: sun4i: add compatible for H3 display engine
>   clk: sunxi-ng: allow CLK_DE to set CLK_PLL_DE for H3
>   clk: sunxi-ng: export CLK_PLL_DE for H3
>   ARM: sun8i: h3: add display engine pipeline barebone
>   [NOT FOR REVIEW NOW] ARM: sun8i: h3: enable DesignWare HDMI controller
>   [NOT FOR REVIEW NOW] ARM: sun8i: h3: enable HDMI output on Orange Pi
>     PC
>
> Jernej Skrabec (4):
>   [NOT FOR REVIEW NOW] drm: bridge: Enable polling hpd event in dw_hdmi
>   [NOT FOR REVIEW NOW] drm: bridge: Add a pre_init function for the
>     dw_hdmi driver
>   [NOT FOR REVIEW NOW] clk: sunxi: Add CLK_SET_RATE_PARENT flag for H3
>     HDMI clock

This one looks trivial enough that I can pick it up regardless of the tag.

ChenYu

>   [NOT FOR REVIEW NOW] drm: sun4i: Add a glue for the DesignWare HDMI
>     controller in H3
>
>  .../bindings/display/sunxi/sun4i-drm.txt           |  25 +-
>  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |  16 +
>  arch/arm/boot/dts/sun8i-h3.dtsi                    | 205 +++++++++
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |   4 +-
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.h                |   3 +-
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |   9 +-
>  drivers/gpu/drm/sun4i/Kconfig                      |   9 +
>  drivers/gpu/drm/sun4i/Makefile                     |   1 +
>  drivers/gpu/drm/sun4i/sun4i_drv.c                  |   2 +
>  drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  43 +-
>  drivers/gpu/drm/sun4i/sun4i_tcon.h                 |   1 +
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              | 462 +++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun8i_mixer.c                |  18 +
>  include/drm/bridge/dw_hdmi.h                       |   2 +
>  include/dt-bindings/clock/sun8i-h3-ccu.h           |   2 +
>  15 files changed, 781 insertions(+), 21 deletions(-)
>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
>
> --
> 2.13.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
