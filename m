From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Thu, 23 Feb 2017 17:44:54 +0000
Subject: [PATCH 4/8] drm/sun4i: add support for sun8i DE2 mixers and
 display engines
In-Reply-To: <20170222151854.3280-5-icenowy@aosc.xyz>
References: <20170222151854.3280-1-icenowy@aosc.xyz>
 <20170222151854.3280-5-icenowy@aosc.xyz>
Message-ID: <CACvgo5117BB+o429cH=X0t3xz_5=XZ65YCEdE=ro+895a9e=RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 February 2017 at 15:18, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> Allwinner have a new "Display Engine 2.0" in there new SoCs, which comes
> in a new "Display Engine" (mixers instead of old backends and
> frontends).
>
> Add support for the mixer on Allwinner V3s SoC; it's the simplest one.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  drivers/gpu/drm/sun4i/Kconfig       |   8 +
>  drivers/gpu/drm/sun4i/Makefile      |   1 +
>  drivers/gpu/drm/sun4i/sun4i_crtc.c  |   6 +-
>  drivers/gpu/drm/sun4i/sun4i_drv.c   |  38 +++-
>  drivers/gpu/drm/sun4i/sun4i_drv.h   |   1 +
>  drivers/gpu/drm/sun4i/sun4i_layer.c |  92 ++++++--
>  drivers/gpu/drm/sun4i/sun4i_layer.h |   1 +
>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 417 ++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun8i_mixer.h | 133 ++++++++++++
>  9 files changed, 674 insertions(+), 23 deletions(-)
Silly question:

Does this series cover the same functionality/hardware as the separate
sun8i driver proposed a few months back ?
The diff stat looks quite different (~1.6k vs ~0.6k), although that
could be due to reusing the existing sun4i code.

Thanks
Emil
