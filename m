From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 15 Jan 2015 15:12:13 +0100
Subject: [PATCH 1/3] dt-bindings: add vendor prefix and root compatible
 property for Rockchip boards
In-Reply-To: <1421289659-16627-2-git-send-email-naobsd@gmail.com>
References: <1421289659-16627-1-git-send-email-naobsd@gmail.com>
 <1421289659-16627-2-git-send-email-naobsd@gmail.com>
Message-ID: <35535970.XLZHSuqDIg@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 15. Januar 2015, 11:40:57 schrieb FUKAUMI Naoki:
> this adds vendor prefix and root compatible property for following boards
> 
> - Firefly, Firefly-RK3288 board
> - ChipSPARK, Rayeager PX2 board
> 
> PX2 SoC is fully compatible with RK3066.
> 
> Signed-off-by: FUKAUMI Naoki <naobsd@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.txt    | 8 ++++++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt
> b/Documentation/devicetree/bindings/arm/rockchip.txt index
> eaa3d1a..7cc1cecd 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> @@ -9,6 +9,14 @@ Rockchip platforms device tree bindings
>      Required root node properties:
>        - compatible = "mundoreader,bq-curie2", "rockchip,rk3066a";
> 
> +- ChipSPARK Rayeager PX2 board:
> +    Required root node properties:
> +      - compatible = "chipspark,rayeager-px2", "rockchip,rk3066a";
> +
>  - Radxa Rock board:
>      Required root node properties:
>        - compatible = "radxa,rock", "rockchip,rk3188";
> +
> +- Firefly Firefly-RK3288 board:
> +    Required root node properties:
> +      - compatible = "firefly,firefly-rk3288", "rockchip,rk3288";

you're adding two boards (beta and retail) and as they are not compatible to 
each other (see gpio differences), they should also have their own compatible 
properties, so something like:

- Firefly Firefly-RK3288 board:
    Required root node properties:
      - compatible = "firefly,firefly-rk3288", "rockchip,rk3288";
    or
      - compatible = "firefly,firefly-rk3288-beta", "rockchip,rk3288";

and this differentiation should of course also happen in the dts files themself.


Heiko
