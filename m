From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 8 Oct 2018 10:31:54 +0200
Subject: [PATCH v2 01/29] dt-bindings: bus: add H6 DE3 bus binding
In-Reply-To: <20181007093905.11253-2-jernej.skrabec@siol.net>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-2-jernej.skrabec@siol.net>
Message-ID: <20181008083154.hhrelzmmpbjwu7sy@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 07, 2018 at 11:38:37AM +0200, Jernej Skrabec wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> The Allwinner H6 DE3 bus is similar to the A64 DE2 one.
> 
> Add its compatible string with the A64 string as fallback to the
> binding.
> 
> Some description of the binding is modified to make it more generic.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt b/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt
> index 87dfb33fb3be..ac1445b95f41 100644
> --- a/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt
> +++ b/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt
> @@ -1,11 +1,14 @@
> -Device tree bindings for Allwinner A64 DE2 bus
> +Device tree bindings for Allwinner DE2/3 bus
>  
>  The Allwinner A64 DE2 is on a special bus, which needs a SRAM region (SRAM C)
> -to be claimed for enabling the access.
> +to be claimed for enabling the access. The DE3 on Allwinner H6 is at the same
> +situation, and the binding also applies.
>  
>  Required properties:
>  
> - - compatible:		Should contain "allwinner,sun50i-a64-de2"
> + - compatible:		Should be one of:
> +				- "allwinner,sun50i-a64-de2"
> +				- "allwinner,sun50i-a6-de3", "allwinner,sun50i-a64-de2"

                                                    ^ that would be h6 I guess?

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181008/4a598149/attachment-0001.sig>
