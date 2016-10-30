From: robh@kernel.org (Rob Herring)
Date: Sun, 30 Oct 2016 15:41:09 -0500
Subject: [PATCH v5 3/7] drm: sunxi: add DE2 HDMI support
In-Reply-To: <36bd5454897c8ab77749e0294e4a4ecc2450dd12.1477142934.git.moinejf@free.fr>
References: <cover.1477142934.git.moinejf@free.fr>
 <36bd5454897c8ab77749e0294e4a4ecc2450dd12.1477142934.git.moinejf@free.fr>
Message-ID: <20161030204109.pr4m5wx5umi6wl2z@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 10:08:06AM +0200, Jean-Francois Moine wrote:
> This patch adds a HDMI driver to the DE2 based Allwinner's SoCs
> as A83T and H3.
> Audio and video are supported.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  .../devicetree/bindings/display/sunxi/hdmi.txt     |  52 ++
>  drivers/gpu/drm/sunxi/Kconfig                      |   8 +
>  drivers/gpu/drm/sunxi/Makefile                     |   2 +
>  drivers/gpu/drm/sunxi/de2_hdmi.c                   | 396 +++++++++
>  drivers/gpu/drm/sunxi/de2_hdmi.h                   |  40 +
>  drivers/gpu/drm/sunxi/de2_hdmi_io.c                | 927 +++++++++++++++++++++
>  drivers/gpu/drm/sunxi/de2_hdmi_io.h                |  25 +
>  7 files changed, 1450 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sunxi/hdmi.txt
>  create mode 100644 drivers/gpu/drm/sunxi/de2_hdmi.c
>  create mode 100644 drivers/gpu/drm/sunxi/de2_hdmi.h
>  create mode 100644 drivers/gpu/drm/sunxi/de2_hdmi_io.c
>  create mode 100644 drivers/gpu/drm/sunxi/de2_hdmi_io.h
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/hdmi.txt b/Documentation/devicetree/bindings/display/sunxi/hdmi.txt
> new file mode 100644
> index 0000000..0558c07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sunxi/hdmi.txt
> @@ -0,0 +1,52 @@
> +Allwinner HDMI Transmitter
> +==========================
> +
> +The Allwinner HDMI transmitters are included in the SoCs.
> +They support audio and video.
> +
> +Required properties:
> + - #address-cells : should be <1>
> + - #size-cells : should be <0>
> + - compatible : should be
> +		"allwinner,sun8i-a83t-hdmi" or
> +		"allwinner,sun8i-h3-hdmi"
> + - clocks : phandles to the HDMI clocks as described in
> +	Documentation/devicetree/bindings/clock/clock-bindings.txt
> + - clock-names : must be
> +		"gate" : bus gate
> +		"clock" : streaming clock
> +		"ddc-clock" : DDC clock
> + - resets : One or two phandles to the HDMI resets
> + - reset-names : must be
> +		"hdmi0" and "hdmi1"
> +
> +Required nodes:
> + - port: Audio and video input port nodes with endpoint definitions
> +	as defined in Documentation/devicetree/bindings/graph.txt.

Please define which port number is audio and which is video.

Rob
