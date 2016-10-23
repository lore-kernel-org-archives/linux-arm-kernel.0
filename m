From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 23 Oct 2016 09:38:04 +0800
Subject: [linux-sunxi] [PATCH v5 0/7] ARM: ASoC: drm: sun8i: Add DE2 HDMI
 audio and video
In-Reply-To: <cover.1477142934.git.moinejf@free.fr>
References: <cover.1477142934.git.moinejf@free.fr>
Message-ID: <CAGb2v64fgJShfyEHnjm6ryg00WhHkmnPj+FdjHcXBa6HQbyTuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 22, 2016 at 9:28 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
> This patchset series adds HDMI audio and video support to the Allwinner
> sun8i SoCs which include the display engine 2 (DE2).
>
> A first submission in January for video on the H3 could not enter into
> the mainline kernel due to the lack of license headers in Allwinner's
> sources.
>
> Recently, an announce about Tina OS for the R series
>         https://www.youtube.com/watch?v=h7KD-6HblAU
> was followed by the upload of a new linux-3.4 source tree
>         https://github.com/tinalinux/linux-3.4
> with files containing GPL headers.
>
> Well, I don't know if these sources are really from Allwinner, but
> anyway, this is the opportunity to propose a new version of my DRM
> HDMI driver.

Could you clarify about this bit? Did you just clean up Allwinner's
existing drivers? Or just use them as reference? Either way I think
this deserves some mention in all your copyright headers.

Otherwise what difference does the new release make?

Regards
ChenYu


>
> v5:
>         - add overlay plane
>         - add audio support
>         - add support for the A83T
>         - add back the HDMI driver
>         - many bug fixes
> v4:
>         - drivers/clk/sunxi/Makefile was missing (Emil Velikov)
> v3:
>         - add the hardware cursor
>         - simplify and fix the DE2 init sequences
>         - generation for all SUNXI SoCs (Andre Przywara)
> v2:
>         - remove the HDMI driver
>         - remarks from Chen-Yu Tsai and Russell King
>         - DT documentation added
>
> Jean-Francois Moine (7):
>   drm: sunxi: Add a basic DRM driver for Allwinner DE2
>   ASoC: sunxi: Add a simple HDMI CODEC
>   drm: sunxi: add DE2 HDMI support
>   ASoC: sunxi: Add sun8i I2S driver
>   ARM: dts: sun8i-h3: add HDMI audio and video nodes
>   ARM: dts: sun8i-h3: Add HDMI audio and video to the Banana Pi M2+
>   ARM: dts: sun8i-h3: Add HDMI audio and video to the Orange PI 2
>
>  .../devicetree/bindings/display/sunxi/hdmi.txt     |  52 ++
>  .../bindings/display/sunxi/sunxi-de2.txt           |  83 ++
>  .../devicetree/bindings/sound/sun4i-i2s.txt        |  38 +-
>  arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |  17 +
>  arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |  17 +
>  arch/arm/boot/dts/sun8i-h3.dtsi                    |  67 ++
>  drivers/gpu/drm/Kconfig                            |   2 +
>  drivers/gpu/drm/Makefile                           |   1 +
>  drivers/gpu/drm/sunxi/Kconfig                      |  29 +
>  drivers/gpu/drm/sunxi/Makefile                     |   9 +
>  drivers/gpu/drm/sunxi/de2_crtc.c                   | 475 +++++++++++
>  drivers/gpu/drm/sunxi/de2_crtc.h                   |  63 ++
>  drivers/gpu/drm/sunxi/de2_de.c                     | 591 +++++++++++++
>  drivers/gpu/drm/sunxi/de2_drm.h                    |  47 ++
>  drivers/gpu/drm/sunxi/de2_drv.c                    | 378 +++++++++
>  drivers/gpu/drm/sunxi/de2_hdmi.c                   | 396 +++++++++
>  drivers/gpu/drm/sunxi/de2_hdmi.h                   |  40 +
>  drivers/gpu/drm/sunxi/de2_hdmi_io.c                | 927 +++++++++++++++++++++
>  drivers/gpu/drm/sunxi/de2_hdmi_io.h                |  25 +
>  drivers/gpu/drm/sunxi/de2_plane.c                  | 119 +++
>  include/sound/sunxi_hdmi.h                         |  23 +
>  sound/soc/codecs/Kconfig                           |   9 +
>  sound/soc/codecs/Makefile                          |   2 +
>  sound/soc/codecs/sunxi-hdmi.c                      | 106 +++
>  sound/soc/sunxi/Kconfig                            |   8 +
>  sound/soc/sunxi/Makefile                           |   3 +
>  sound/soc/sunxi/sun8i-i2s.c                        | 700 ++++++++++++++++
>  27 files changed, 4222 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/sunxi/hdmi.txt
>  create mode 100644 Documentation/devicetree/bindings/display/sunxi/sunxi-de2.txt
>  create mode 100644 drivers/gpu/drm/sunxi/Kconfig
>  create mode 100644 drivers/gpu/drm/sunxi/Makefile
>  create mode 100644 drivers/gpu/drm/sunxi/de2_crtc.c
>  create mode 100644 drivers/gpu/drm/sunxi/de2_crtc.h
>  create mode 100644 drivers/gpu/drm/sunxi/de2_de.c
>  create mode 100644 drivers/gpu/drm/sunxi/de2_drm.h
>  create mode 100644 drivers/gpu/drm/sunxi/de2_drv.c
>  create mode 100644 drivers/gpu/drm/sunxi/de2_hdmi.c
>  create mode 100644 drivers/gpu/drm/sunxi/de2_hdmi.h
>  create mode 100644 drivers/gpu/drm/sunxi/de2_hdmi_io.c
>  create mode 100644 drivers/gpu/drm/sunxi/de2_hdmi_io.h
>  create mode 100644 drivers/gpu/drm/sunxi/de2_plane.c
>  create mode 100644 include/sound/sunxi_hdmi.h
>  create mode 100644 sound/soc/codecs/sunxi-hdmi.c
>  create mode 100644 sound/soc/sunxi/sun8i-i2s.c
>
> --
> 2.10.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
