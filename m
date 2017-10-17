From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Oct 2017 20:16:42 +0800
Subject: [PATCH 00/23] drm/sun4i: Add A83t LVDS support
In-Reply-To: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64FoP22CZdUfyh4Rz7arrMikeaOxQCSbb9Zh3CKcaHGtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 5:06 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> Here is an attempt at supporting the LVDS output in our DRM driver. This
> has been tested on the A83T (with DE2), but since everything is basically
> in the TCON, it should also be usable on the older SoCs with minor
> modifications.
>
> This was the occasion to refactor a bunch of things. The most notable ones
> would be the documentation, and split of the UI layers in the mixer code,
> and the switch to kfifo for our endpoint parsing code in the driver that
> fixes an issue introduced by the switch to BFS.
>
> Let me know what you think,
> Maxime
>
> Maxime Ripard (23):
>   drm/sun4i: Implement endpoint parsing using kfifo
>   drm/sun4i: Realign Makefile padding and reorder it
>   drm/sun4i: tcon: Make tcon_set_mux mode argument const
>   drm/sun4i: tcon: Make tcon_get_clk_delay mode argument const
>   drm/sun4i: tcon: Don't rely on encoders to enable the TCON
>   drm/sun4i: tcon: Don't rely on encoders to set the TCON mode
>   drm/sun4i: tcon: Move out the tcon0 common setup
>   dt-bindings: panel: lvds: Document power-supply property
>   drm/panel: lvds: Add support for the power-supply property
>   clk: sunxi-ng: Add A83T display clocks
>   drm/sun4i: Rename layers to UI planes
>   drm/sun4i: sun8i: properly support UI channels
>   drm/sun4i: Reorder and document DE2 mixer registers
>   drm/sun4i: Create minimal multipliers and dividers
>   drm/sun4i: Add LVDS support
>   drm/sun4i: Add A83T support
>   arm: dts: sun8i: a83t: Add display pipeline
>   arm: dts: sun8i: a83t: Enable the PWM
>   arm: dts: sun8i: a83t: Add LVDS pins group
>   arm: dts: sun8i: a83t: Add the PWM pin group
>   arm: dts: sun8i: a711: Add regulator support
>   arm: dts: sun8i: a711: Enable USB OTG
>   arm: dts: sun8i: a711: Enable the LCD

AFAIK ARM should be uppercase for armv7, and lowercase for arm64.

ChenYu
