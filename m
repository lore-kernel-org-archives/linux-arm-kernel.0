From: robh@kernel.org (Rob Herring)
Date: Fri, 18 May 2018 11:41:05 -0500
Subject: [PATCH v5 2/4] Documentation: bindings: add phy_config for
 Rockchip USB Type-C PHY
In-Reply-To: <1526548680-2552-2-git-send-email-hl@rock-chips.com>
References: <1526548680-2552-1-git-send-email-hl@rock-chips.com>
 <1526548680-2552-2-git-send-email-hl@rock-chips.com>
Message-ID: <20180518164105.GA14201@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 05:17:58PM +0800, Lin Huang wrote:
> If want to do training outside DP Firmware, need phy voltage swing
> and pre_emphasis value.

"dt-bindings: phy: ..." for the subject please.

> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v2:
> - None 
> Changes in v3:
> - modify property description and add this property to Example
> Change in v4:
> - None
> Change in v5:
> - None
> 
>  .../devicetree/bindings/phy/phy-rockchip-typec.txt | 29 +++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> index 960da7f..af298f2 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> @@ -17,7 +17,8 @@ Required properties:
>  
>  Optional properties:
>   - extcon : extcon specifier for the Power Delivery
> -
> + - rockchip,phy_config : A list of voltage swing(mv) and pre-emphasis
> +			(dB) pairs.

rockchip,phy-config

>  Required nodes : a sub-node is required for each port the phy provides.
>  		 The sub-node name is used to identify dp or usb3 port,
>  		 and shall be the following entries:
> @@ -50,6 +51,19 @@ Example:
>  			 <&cru SRST_P_UPHY0_TCPHY>;
>  		reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
>  
> +		rockchip,phy_config =<0x2a 0x00

space                                 ^

And format with inner <> ("< <0 1> <0 2> ... >") to show the pairs.

> +			0x1f 0x15
> +			0x14 0x22
> +			0x02 0x2b
> +			0x21 0x00
> +			0x12 0x15
> +			0x02 0x22
> +			0 0
> +			0x15 0x00
> +			0x00 0x15
> +			0 0
> +			0 0>;

Since you have <0 0> multiple times, I presume the index is significant 
and the length is fixed. Please define the index meaning and length 
above.

> +
>  		tcphy0_dp: dp-port {
>  			#phy-cells = <0>;
>  		};
> @@ -74,6 +88,19 @@ Example:
>  			 <&cru SRST_P_UPHY1_TCPHY>;
>  		reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
>  
> +		rockchip,phy_config =<0x2a 0x00
> +			0x1f 0x15
> +			0x14 0x22
> +			0x02 0x2b
> +			0x21 0x00
> +			0x12 0x15
> +			0x02 0x22
> +			0 0
> +			0x15 0x00
> +			0x00 0x15
> +			0 0
> +			0 0>;
> +
>  		tcphy1_dp: dp-port {
>  			#phy-cells = <0>;
>  		};
> -- 
> 2.7.4
> 
