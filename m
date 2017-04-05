From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 5 Apr 2017 18:28:20 +0530
Subject: [PATCH 1/3] dt: bindings: add pmu0 regs for USB PHYs on Allwinner
 H3/V3s/A64
In-Reply-To: <20170405125053.6170-2-icenowy@aosc.io>
References: <20170405125053.6170-1-icenowy@aosc.io>
 <20170405125053.6170-2-icenowy@aosc.io>
Message-ID: <1524732c-b72f-61ce-8ae7-1d764f85c903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 05 April 2017 06:20 PM, Icenowy Zheng wrote:
> From: Icenowy Zheng <icenowy@aosc.xyz>
> 
> Allwinner H3/V3s/A64 SoCs have a special USB PHY0 that can route to two
> controllers: one is MUSB and the other is a EHCI/OHCI pair.
> 
> When it's routed to EHCI/OHCI pair, it will needs a "pmu0" regs to
> tweak, like other EHCI/OHCI pairs in Allwinner SoCs.
> 
> Add this to the binding of USB PHYs on Allwinner H3/V3s/A64.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> 
> Kishon, could you push this to 4.11?

Is this for the patch titled "phy: sun4i-usb: add support for V3s USB PHY" that
was added during the last merge window.

this patch looks simpler enough to be merged in this -rc cycle. However it
depends on Greg KH.

Thanks
Kishon

> 
>  Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
> index e42334258185..005bc22938ff 100644
> --- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
> @@ -15,6 +15,7 @@ Required properties:
>  - reg : a list of offset + length pairs
>  - reg-names :
>    * "phy_ctrl"
> +  * "pmu0" for H3, V3s and A64
>    * "pmu1"
>    * "pmu2" for sun4i, sun6i or sun7i
>  - #phy-cells : from the generic phy bindings, must be 1
> 
