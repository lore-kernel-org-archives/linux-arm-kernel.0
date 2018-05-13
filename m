From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 13 May 2018 21:49:19 +0200
Subject: [PATCH RESEND net-next v2 1/8] dt-bindings: net: dwmac-sun8i:
 Clean up clock delay chain descriptions
In-Reply-To: <20180513191425.9801-2-wens@csie.org>
References: <20180513191425.9801-1-wens@csie.org>
 <20180513191425.9801-2-wens@csie.org>
Message-ID: <20180513194919.GE12738@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 03:14:18AM +0800, Chen-Yu Tsai wrote:
> The clock delay chains found in the glue layer for dwmac-sun8i are only
> used with RGMII PHYs. They are not intended for non-RGMII PHYs, such as
> MII external PHYs or the internal PHY. Also, a recent SoC has a smaller
> range of possible values for the delay chain.
> 
> This patch reformats the delay chain section of the device tree binding
> to make it clear that the delay chains only apply to RGMII PHYs, and
> make it easier to add the R40-specific bits later.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
> index 3d6d5fa0c4d5..e04ce75e24a3 100644
> --- a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
> +++ b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
> @@ -28,10 +28,13 @@ Required properties:
>    - allwinner,sun8i-a83t-system-controller
>  
>  Optional properties:
> -- allwinner,tx-delay-ps: TX clock delay chain value in ps. Range value is 0-700. Default is 0)
> -- allwinner,rx-delay-ps: RX clock delay chain value in ps. Range value is 0-3100. Default is 0)
> -Both delay properties need to be a multiple of 100. They control the delay for
> -external PHY.
> +- allwinner,tx-delay-ps: TX clock delay chain value in ps.
> +			 Range is 0-700. Default is 0.
> +- allwinner,rx-delay-ps: RX clock delay chain value in ps.
> +			 Range is 0-3100. Default is 0.
> +Both delay properties need to be a multiple of 100. They control the
> +clock delay for external RGMII PHY. They do not apply to the internal
> +PHY or external non-RGMII PHYs.

Hi Chen-Yu

Are these delays the MAC applies? Not the PHY. It would be good to
make it clear here these are MAC imposed delays.

     Andrew
