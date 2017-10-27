From: icenowy@aosc.io (icenowy at aosc.io)
Date: Fri, 27 Oct 2017 12:07:51 +0800
Subject: [PATCH 0/4] Add SimpleFB support for Allwinner H3 SoC
In-Reply-To: <20170911155529.62891-1-icenowy@aosc.io>
References: <20170911155529.62891-1-icenowy@aosc.io>
Message-ID: <239eed81945193af3af465c7ef0008ca@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-09-11 23:55?Icenowy Zheng ???
> This patchset adds devicetree-side support of SimpleFB on Allwinner H3
> SoC.
> 
> The DE2 CCU is initialized and used by the SimpleFB node, in order to
> furtherly coexist with the DRM code.
> 
> The first patch adds pipelines for DE2 displays in simplefb-sunxi
> device tree binding.
> 
> The second patch adds DE2 CCU device node for H3 SoC, and the skeleton
> of the node enters the H3/H5 common DTSI; the H5 support is splited
> into the third patch, as they will enter different tree.
> 
> The fourth patch finally adds simplefb nodes, using the
> pipeline strings introduced in the first patch.
> 
> Icenowy Zheng (4):
>   dt-bindings: simplefb-sunxi: add pipelines for DE2
>   ARM: sun8i: h3/h5: add DE2 CCU device node for H3
>   arm64: allwinner: h5: add compatible string for DE2 CCU
>   ARM: sunxi: h3/h5: add simplefb nodes

Maxime,
as the U-Boot side is applied to u-boot-video, could you take a look at 
this
patchset?

Thanks!
Icenowy

> 
>  .../bindings/display/simple-framebuffer-sunxi.txt  |  4 ++
>  arch/arm/boot/dts/sun8i-h3.dtsi                    |  4 ++
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi                 | 43 
> ++++++++++++++++++++++
>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       |  4 ++
>  4 files changed, 55 insertions(+)
