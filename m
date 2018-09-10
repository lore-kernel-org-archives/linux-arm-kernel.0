From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 10 Sep 2018 13:03:32 +0800
Subject: [linux-sunxi] [PATCH 0/5] Fix A64 HDMI PHY device tree binding
In-Reply-To: <20180907072234.48282-1-icenowy@aosc.io>
References: <20180907072234.48282-1-icenowy@aosc.io>
Message-ID: <CAGb2v65G-rVK67C2EfKB+xcKY2OP_K-eXXpyC_BtskXyANe2UA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2018 at 3:22 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> When adding support for A64 HDMI PHY in 4.19, we assumed that the two
> PLL-VIDEOs can both feed the HDMI PHY clock. However experiments show
> that the mux bit discovered in R40 blob is not applicable on A64. This
> is not discovered, as normally with a single display pipeline only
> PLL-VIDEO0 will be used.
>
> In this patchset the second PLL is dropped, and a binding specially for
> R40 HDMI PHY is added (which seems to have the mux).
>
> PATCH 1 and 2 are dropping second PLL for A64 HDMI PHY, and PATCH 3 to 5
> are adding R40 HDMI PHY binding.
>
> This patchset targets v4.19 fixes tree, because the binding is
> introduced in v4.19, and if we don't fix it there a wrong binding will
> be left in a stable version released.

Please add fixes tags.

The patches look good, though I'm not sure about patches 3 and 4 going in fixes.

ChenYu


> Icenowy Zheng (5):
>   dt-bindings: sun4i-drm: drop second PLL from A64 HDMI PHY binding
>   drm: sun4i: drop second PLL from A64 HDMI PHY
>   dt-bindings: sun4i-drm: add compatible for R40 HDMI PHY
>   drm/sun4i: add support for R40 HDMI PHY
>   ARM: sun8i: dts: drop A64 HDMI PHY fallback compatible from R40 DT
>
>  .../devicetree/bindings/display/sunxi/sun4i-drm.txt |  5 +++--
>  arch/arm/boot/dts/sun8i-r40.dtsi                    |  3 +--
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c              | 13 ++++++++++++-
>  3 files changed, 16 insertions(+), 5 deletions(-)
>
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
