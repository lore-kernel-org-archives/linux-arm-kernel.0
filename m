From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 16 Nov 2016 12:59:27 +0100
Subject: [PATCH v2 10/10] ARM: dts: rockchip: add rockchip RK1108
 Evaluation board
In-Reply-To: <1479125863-24646-1-git-send-email-andy.yan@rock-chips.com>
References: <1479124550-24037-1-git-send-email-andy.yan@rock-chips.com>
 <1479125863-24646-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <5287367.F6IKuQ3eke@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 14. November 2016, 20:17:43 CET schrieb Andy Yan:
> RK1108 EVB is designed by Rockchip for CVR field.
> This patch add basic support for it, which can boot with
> initramfs into shell.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> Acked-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changes in v2:
> - move the board in the rockchip.txt to the block of Rockchip boards
> 
>  Documentation/devicetree/bindings/arm/rockchip.txt |  5 +-
>  arch/arm/boot/dts/Makefile                         |  1 +
>  arch/arm/boot/dts/rk1108-evb.dts                   | 69
> ++++++++++++++++++++++ 3 files changed, 74 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/rk1108-evb.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt
> b/Documentation/devicetree/bindings/arm/rockchip.txt index 10b92b5..e658b62
> 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> @@ -1,6 +1,5 @@
>  Rockchip platforms device tree bindings
>  ---------------------------------------
> -
>  - Kylin RK3036 board:
>      Required root node properties:
>        - compatible = "rockchip,kylin-rk3036", "rockchip,rk3036";

dropped this unrelated change

> @@ -111,6 +110,10 @@ Rockchip platforms device tree bindings
>      Required root node properties:
>        - compatible = "rockchip,px5-evb", "rockchip,px5", "rockchip,rk3368";
> 
> +- Rockchip RK1108 Evaluation board
> +    Required root node properties:
> +      - compatible = "rockchip,rk1108-evb", "rockchip,rk1108";
> +
>  - Rockchip RK3368 evb:
>      Required root node properties:
>        - compatible = "rockchip,rk3368-evb-act8846", "rockchip,rk3368";

binding moved to a separate patch and applied to my dts64 to prevent conflicts 
with px5 addition.

And the actual board dts of course applied to my dts32 branch.


Thanks
Heiko
