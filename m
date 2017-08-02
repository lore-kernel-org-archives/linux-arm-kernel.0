From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Wed, 02 Aug 2017 06:53:56 +0200
Subject: [linux-sunxi] [PATCH 01/13] dt-bindings: update the binding for
 Allwinner H3 DE2 support
In-Reply-To: <20170801131304.7741-2-icenowy@aosc.io>
References: <20170801131304.7741-1-icenowy@aosc.io>
 <20170801131304.7741-2-icenowy@aosc.io>
Message-ID: <79034825.lnfmIyYlWl@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Icenowy,

Dne torek, 01. avgust 2017 ob 15:12:52 CEST je Icenowy Zheng napisal(a):
> Allwinner H3 features a "Display Engine 2.0".
> 
> Add device tree bindings for the following parts:
> - H3 TCONs
> - H3 Mixers
> - H3 Display engine
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../bindings/display/sunxi/sun4i-drm.txt           | 25
> ++++++++++++++++++---- 1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt index
> 2ee6ff0ef98e..92512953943e 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -87,18 +87,17 @@ Required properties:
>     * allwinner,sun6i-a31-tcon
>     * allwinner,sun6i-a31s-tcon
>     * allwinner,sun8i-a33-tcon
> +   * allwinner,sun8i-h3-tcon
>     * allwinner,sun8i-v3s-tcon
>   - reg: base address and size of memory-mapped region
>   - interrupts: interrupt associated to this IP
>   - clocks: phandles to the clocks feeding the TCON. Three are needed:
>     - 'ahb': the interface clocks
> -   - 'tcon-ch0': The clock driving the TCON channel 0
>   - resets: phandles to the reset controllers driving the encoder
>     - "lcd": the reset line for the TCON channel 0
> 
>   - clock-names: the clock names mentioned above
>   - reset-names: the reset names mentioned above
> - - clock-output-names: Name of the pixel clock created
> 
>  - ports: A ports node with endpoint definitions as defined in
>    Documentation/devicetree/bindings/media/video-interfaces.txt. The
> @@ -112,7 +111,23 @@ Required properties:
>    channel the endpoint is associated to. If that property is not
>    present, the endpoint number will be used as the channel number.
> 
> -On SoCs other than the A33 and V3s, there is one more clock required:
> +For the following compatibles:
> +   * allwinner,sun5i-a13-tcon
> +   * allwinner,sun6i-a31-tcon
> +   * allwinner,sun6i-a31s-tcon
> +   * allwinner,sun8i-a33-tcon
> +   * allwinner,sun8i-v3s-tcon
> +there is one more clock and one more property required:
> + - clocks:
> +   - 'tcon-ch0': The clock driving the TCON channel 0
> + - clock-output-names: Name of the pixel clock created
> +
> +For the following compatibles:
> +   * allwinner,sun5i-a13-tcon
> +   * allwinner,sun6i-a31-tcon
> +   * allwinner,sun6i-a31s-tcon
> +   * allwinner,sun8i-h3-tcon
> +there is one more clock required:
>     - 'tcon-ch1': The clock driving the TCON channel 1
> 
>  DRC
> @@ -207,6 +222,8 @@ supported.
>  Required properties:
>    - compatible: value must be one of:
>      * allwinner,sun8i-v3s-de2-mixer
> +    * allwinner,sun8i-h3-de2-mixer0
> +    * allwinner,sun8i-h3-de2-mixer1

About that, I concur with Maxime here, plane number properties would be 
better. If we don't do this now, we will never have it.

Reference:
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/512902.html

Regards,
Jernej

>    - reg: base address and size of the memory-mapped region.
>    - clocks: phandles to the clocks feeding the mixer
>      * bus: the mixer interface clock
> @@ -218,7 +235,6 @@ Required properties:
>    Documentation/devicetree/bindings/media/video-interfaces.txt. The
>    first port should be the input endpoints, the second one the output
> 
> -
>  Display Engine Pipeline
>  -----------------------
> 
> @@ -233,6 +249,7 @@ Required properties:
>      * allwinner,sun6i-a31-display-engine
>      * allwinner,sun6i-a31s-display-engine
>      * allwinner,sun8i-a33-display-engine
> +    * allwinner,sun8i-h3-display-engine
>      * allwinner,sun8i-v3s-display-engine
> 
>    - allwinner,pipelines: list of phandle to the display engine
> --
> 2.13.0
> 
> --
> You received this message because you are subscribed to the Google Groups
> "linux-sunxi" group. To unsubscribe from this group and stop receiving
> emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
