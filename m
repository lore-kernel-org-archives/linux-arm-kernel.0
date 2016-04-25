From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Mon, 25 Apr 2016 16:56:27 +0100
Subject: [PATCH v4 00/11] drm: Add Allwinner A10 display engine support
In-Reply-To: <1461590572-4027-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1461590572-4027-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACvgo50CDGL1jdP4kkbnNtnLGrgSa-b74RJu6NnPuq1=Q9Zsmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 25 April 2016 at 14:22, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

>  Documentation/devicetree/bindings/clock/sunxi.txt  |   2 +
>  .../bindings/display/sunxi/sun4i-drm.txt           | 258 ++++++++
>  arch/arm/boot/dts/sun5i-a13.dtsi                   |  39 +-
>  arch/arm/boot/dts/sun5i-r8-chip.dts                |  12 +
>  arch/arm/boot/dts/sun5i-r8.dtsi                    | 142 ++++-
>  drivers/clk/sunxi/Makefile                         |   1 +
>  drivers/clk/sunxi/clk-sun4i-display.c              | 261 ++++++++
>  drivers/gpu/drm/Kconfig                            |   2 +
>  drivers/gpu/drm/Makefile                           |   3 +-
>  drivers/gpu/drm/sun4i/Kconfig                      |  14 +
>  drivers/gpu/drm/sun4i/Makefile                     |  13 +
>  drivers/gpu/drm/sun4i/sun4i_backend.c              | 364 +++++++++++
>  drivers/gpu/drm/sun4i/sun4i_backend.h              | 165 +++++
>  drivers/gpu/drm/sun4i/sun4i_crtc.c                 | 120 ++++
>  drivers/gpu/drm/sun4i/sun4i_crtc.h                 |  30 +
>  drivers/gpu/drm/sun4i/sun4i_dotclock.c             | 160 +++++
>  drivers/gpu/drm/sun4i/sun4i_dotclock.h             |  21 +
>  drivers/gpu/drm/sun4i/sun4i_drv.c                  | 357 +++++++++++
>  drivers/gpu/drm/sun4i/sun4i_drv.h                  |  30 +
>  drivers/gpu/drm/sun4i/sun4i_framebuffer.c          |  54 ++
>  drivers/gpu/drm/sun4i/sun4i_framebuffer.h          |  19 +
>  drivers/gpu/drm/sun4i/sun4i_layer.c                | 161 +++++
>  drivers/gpu/drm/sun4i/sun4i_layer.h                |  30 +
>  drivers/gpu/drm/sun4i/sun4i_rgb.c                  | 250 ++++++++
>  drivers/gpu/drm/sun4i/sun4i_rgb.h                  |  18 +
>  drivers/gpu/drm/sun4i/sun4i_tcon.c                 | 561 ++++++++++++++++
>  drivers/gpu/drm/sun4i/sun4i_tcon.h                 | 186 ++++++
>  drivers/gpu/drm/sun4i/sun4i_tv.c                   | 708 +++++++++++++++++++++
>  include/drm/drm_fb_cma_helper.h                    |   2 +

Having a look at the diff stat, can we please have an entry in
MAINTAINERS for this driver ? Don't bother re-spinning the whole
series just for that and add the patch on top [for the pull request].

Thank you !

-Emil
