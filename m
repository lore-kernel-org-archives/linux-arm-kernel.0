From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Apr 2017 10:00:29 +0200
Subject: [PATCH v3 03/11] dt-bindings: add bindings for DE2 on V3s SoC
In-Reply-To: <20170329194613.55548-4-icenowy@aosc.io>
References: <20170329194613.55548-1-icenowy@aosc.io>
 <20170329194613.55548-4-icenowy@aosc.io>
Message-ID: <20170403080029.6goqw657ptljou3o@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 03:46:05AM +0800, Icenowy Zheng wrote:
> From: Icenowy Zheng <icenowy@aosc.xyz>
> 
> Allwinner V3s SoC have a display engine which have a different pipeline
> with older SoCs.
> 
> Add document for it (new compatibles and the new "mixer" part).
> 
> The paragraph of TCON is also refactored, for furtherly add TCONs in
> A83T/H3/A64/H5 that have only a channel 1 (used for HDMI or TV Encoder).
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Changes in v3:
> - Remove the description of having a BE directly as allwinner,pipeline.
> 
>  .../bindings/display/sunxi/sun4i-drm.txt           | 37 +++++++++++++++++++---
>  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index b82c00449468..38de5e96f359 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -31,11 +31,11 @@ Required properties:
>     * allwinner,sun6i-a31-tcon
>     * allwinner,sun6i-a31s-tcon
>     * allwinner,sun8i-a33-tcon
> +   * allwinner,sun8i-v3s-tcon
>   - reg: base address and size of memory-mapped region
>   - interrupts: interrupt associated to this IP
> - - clocks: phandles to the clocks feeding the TCON. Three are needed:
> + - clocks: phandles to the clocks feeding the TCON
>     - 'ahb': the interface clocks
> -   - 'tcon-ch0': The clock driving the TCON channel 0
>   - resets: phandles to the reset controllers driving the encoder
>     - "lcd": the reset line for the TCON channel 0
>  
> @@ -52,7 +52,12 @@ Required properties:
>    second the block connected to the TCON channel 1 (usually the TV
>    encoder)
>  
> -On SoCs other than the A33, there is one more clock required:
> +On TCONs that have a channel 0 (currently all TCONs supported), there
> +is one more clock required:
> +   - 'tcon-ch0': The clock driving the TCON channel 0
> +

Why did you change that if they all have a channel 0?

> +On TCONs that have a channel 1 (currently all TCONs except the ones in
> +A33 and V3s), there is one more clock required:
>     - 'tcon-ch1': The clock driving the TCON channel 1

And that can be added too just by saying "On SoCs other than the A33
and V3".

Looks good otherwise, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170403/90e9c978/attachment.sig>
