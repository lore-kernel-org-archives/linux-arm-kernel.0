From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 10 Sep 2018 16:22:50 +0200
Subject: [PATCH 1/5] dt-bindings: sun4i-drm: drop second PLL from A64
 HDMI PHY binding
In-Reply-To: <20180907072234.48282-2-icenowy@aosc.io>
References: <20180907072234.48282-1-icenowy@aosc.io>
 <20180907072234.48282-2-icenowy@aosc.io>
Message-ID: <20180910142250.he54s4pm436qyshs@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2018 at 03:22:30PM +0800, Icenowy Zheng wrote:
> By experiments it seems that the A64 HDMI PHY is not able to use the
> second video PLL as the clock parent.
> 
> Drop pll-1 from the device tree binding of A64 HDMI PHY.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index f8773ecb7525..62034039cee1 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -114,7 +114,6 @@ Required properties:
>  
>  H3 and A64 HDMI PHY require additional clocks:
>    - pll-0: parent of phy clock
> -  - pll-1: second possible phy clock parent (A64 only)

You shouldn't need to do this. The DT is about the hardware. The fact
that we haven't figured out how to use it is quite irrelevant, and can
change in the future, unlike this binding.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180910/9366ae39/attachment.sig>
