From: robh@kernel.org (Rob Herring)
Date: Sun, 30 Oct 2016 15:41:08 -0500
Subject: [PATCH v5 1/7] drm: sunxi: Add a basic DRM driver for Allwinner
 DE2
In-Reply-To: <8afc5e020c5767face34fe3a9ab300ce9e67ba00.1477142934.git.moinejf@free.fr>
References: <cover.1477142934.git.moinejf@free.fr>
 <8afc5e020c5767face34fe3a9ab300ce9e67ba00.1477142934.git.moinejf@free.fr>
Message-ID: <20161030204108.rpeipal6hkao5zjv@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 09:26:18AM +0200, Jean-Francois Moine wrote:
> Allwinner's recent SoCs, as A64, A83T and H3, contain a new display
> engine, DE2.
> This patch adds a DRM video driver for this device.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  .../bindings/display/sunxi/sunxi-de2.txt           |  83 +++
>  drivers/gpu/drm/Kconfig                            |   2 +
>  drivers/gpu/drm/Makefile                           |   1 +
>  drivers/gpu/drm/sunxi/Kconfig                      |  21 +
>  drivers/gpu/drm/sunxi/Makefile                     |   7 +
>  drivers/gpu/drm/sunxi/de2_crtc.c                   | 475 +++++++++++++++++
>  drivers/gpu/drm/sunxi/de2_crtc.h                   |  63 +++
>  drivers/gpu/drm/sunxi/de2_de.c                     | 591 +++++++++++++++++++++
>  drivers/gpu/drm/sunxi/de2_drm.h                    |  47 ++
>  drivers/gpu/drm/sunxi/de2_drv.c                    | 378 +++++++++++++
>  drivers/gpu/drm/sunxi/de2_plane.c                  | 119 +++++
>  11 files changed, 1787 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sunxi/sunxi-de2.txt
>  create mode 100644 drivers/gpu/drm/sunxi/Kconfig
>  create mode 100644 drivers/gpu/drm/sunxi/Makefile
>  create mode 100644 drivers/gpu/drm/sunxi/de2_crtc.c
>  create mode 100644 drivers/gpu/drm/sunxi/de2_crtc.h
>  create mode 100644 drivers/gpu/drm/sunxi/de2_de.c
>  create mode 100644 drivers/gpu/drm/sunxi/de2_drm.h
>  create mode 100644 drivers/gpu/drm/sunxi/de2_drv.c
>  create mode 100644 drivers/gpu/drm/sunxi/de2_plane.c
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sunxi-de2.txt b/Documentation/devicetree/bindings/display/sunxi/sunxi-de2.txt
> new file mode 100644
> index 0000000..f9cd67a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sunxi/sunxi-de2.txt

> +	hdmi: hdmi at 01ee0000 {
> +		...
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		port {
> +			type = "video";

This is proposed, but not an accepted property. Please drop.

> +			hdmi_ep: endpoint {
> +				remote-endpoint = <&lcd0_ep>;
> +			};
> +		};
> +	};
