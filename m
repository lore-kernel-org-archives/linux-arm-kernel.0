From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Jul 2018 23:26:39 +0800
Subject: [PATCH 06/17] dt-bindings: display: sun4i-drm: Add R40 TV TCON
 description
In-Reply-To: <20180706175113.26698-7-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
 <20180706175113.26698-7-jernej.skrabec@siol.net>
Message-ID: <CAGb2v64AOe6p6m5=FhmDtYi5ebGHAv+3cPR9G=wZudQMohz2Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> TCON description is expanded with R40 TV TCON compatible. It is a bit
> special, because it is connected to TCON TOP instead directly to mixer
> and it needs special handling.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index 288b4cbc255e..7e2451396a28 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -147,6 +147,7 @@ Required properties:
>     * allwinner,sun8i-a33-tcon
>     * allwinner,sun8i-a83t-tcon-lcd
>     * allwinner,sun8i-a83t-tcon-tv
> +   * allwinner,sun8i-r40-tcon-tv
>     * allwinner,sun8i-v3s-tcon
>     * allwinner,sun9i-a80-tcon-lcd
>     * allwinner,sun9i-a80-tcon-tv
> @@ -181,7 +182,7 @@ For TCONs with channel 0, there is one more clock required:
>  For TCONs with channel 1, there is one more clock required:
>     - 'tcon-ch1': The clock driving the TCON channel 1
>
> -When TCON support LVDS (all TCONs except TV TCON on A83T and those found
> +When TCON support LVDS (all TCONs except TV TCONs on A83T, R40 and those found
>  in A13, H3, H5 and V3s SoCs), you need one more reset line:

I think this line is getting more convoluted as we add more exceptions.
We may want to reword it somehow.

>     - 'lvds': The reset line driving the LVDS logic
>
> --
> 2.18.0
>
