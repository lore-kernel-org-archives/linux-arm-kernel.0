From: robh@kernel.org (Rob Herring)
Date: Mon, 16 Apr 2018 13:47:45 -0500
Subject: [PATCH 1/5] dt-bindings: allow dwmac-sun8i to use other devices'
 exported regmap
In-Reply-To: <20180411141641.14675-2-icenowy@aosc.io>
References: <20180411141641.14675-1-icenowy@aosc.io>
 <20180411141641.14675-2-icenowy@aosc.io>
Message-ID: <20180416184745.tqxyvojtcbage4fu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2018 at 10:16:37PM +0800, Icenowy Zheng wrote:
> On some Allwinner SoCs the EMAC clock register needed by dwmac-sun8i is
> in another device's memory space. In this situation dwmac-sun8i can use
> a regmap exported by the other device with only the EMAC clock register.

If this is a clock, then why not use the clock binding?

> 
> Document this situation in the dwmac-sun8i device tree binding
> documentation.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
> index 3d6d5fa0c4d5..0c5f63a80617 100644
> --- a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
> +++ b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
> @@ -20,8 +20,9 @@ Required properties:
>  - phy-handle: See ethernet.txt
>  - #address-cells: shall be 1
>  - #size-cells: shall be 0
> -- syscon: A phandle to the syscon of the SoC with one of the following
> - compatible string:
> +- syscon: A phandle to a device which exports the EMAC clock register as a
> + regmap or to the syscon of the SoC with one of the following compatible
> + string:
>    - allwinner,sun8i-h3-system-controller
>    - allwinner,sun8i-v3s-system-controller
>    - allwinner,sun50i-a64-system-controller
> -- 
> 2.15.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
