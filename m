From: briannorris@chromium.org (Brian Norris)
Date: Wed, 17 Jan 2018 14:07:16 -0800
Subject: [PATCH 1/3] dt-bindings: phy: phy-rockchip-typec: add usb3 otg
 reset
In-Reply-To: <1515751704-13213-2-git-send-email-william.wu@rock-chips.com>
References: <1515751704-13213-1-git-send-email-william.wu@rock-chips.com>
 <1515751704-13213-2-git-send-email-william.wu@rock-chips.com>
Message-ID: <20180117220715.GA112833@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Enric

On Fri, Jan 12, 2018 at 06:08:22PM +0800, William Wu wrote:
> This patch adds USB3 OTG reset property for rk3399 Type-C PHY
> to hold the USB3 controller in reset state.
> 
> Signed-off-by: William Wu <william.wu@rock-chips.com>
> ---

I was going back and forth on this, since at one point this binding was
merged but had no enabled users...but now I see Heiko has queued up some
of Enric's work for 4.16, and it uses the existing binding.

So, if this reset is added, it should be optional.

Brian

>  Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> index 6ea867e..db2902e 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> @@ -13,7 +13,7 @@ Required properties:
>   - assigned-clock-rates : the phy core clk frequency, shall be: 50000000
>   - resets : a list of phandle + reset specifier pairs
>   - reset-names : string reset name, must be:
> -		 "uphy", "uphy-pipe", "uphy-tcphy"
> +		 "uphy", "uphy-pipe", "uphy-tcphy", "usb3-otg"
>   - extcon : extcon specifier for the Power Delivery
>  
>  Note, there are 2 type-c phys for RK3399, and they are almost identical, except
> @@ -56,8 +56,9 @@ Example:
>  		assigned-clock-rates = <50000000>;
>  		resets = <&cru SRST_UPHY0>,
>  			 <&cru SRST_UPHY0_PIPE_L00>,
> -			 <&cru SRST_P_UPHY0_TCPHY>;
> -		reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
> +			 <&cru SRST_P_UPHY0_TCPHY>,
> +			 <&cru SRST_A_USB3_OTG0>;
> +		reset-names = "uphy", "uphy-pipe", "uphy-tcphy", "usb3-otg";
>  		rockchip,typec-conn-dir = <0xe580 0 16>;
>  		rockchip,usb3tousb2-en = <0xe580 3 19>;
>  		rockchip,external-psm = <0xe588 14 30>;
> @@ -84,8 +85,9 @@ Example:
>  		assigned-clock-rates = <50000000>;
>  		resets = <&cru SRST_UPHY1>,
>  			 <&cru SRST_UPHY1_PIPE_L00>,
> -			 <&cru SRST_P_UPHY1_TCPHY>;
> -		reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
> +			 <&cru SRST_P_UPHY1_TCPHY>,
> +			 <&cru SRST_A_USB3_OTG1>;
> +		reset-names = "uphy", "uphy-pipe", "uphy-tcphy", "usb3-otg";
>  		rockchip,typec-conn-dir = <0xe58c 0 16>;
>  		rockchip,usb3tousb2-en = <0xe58c 3 19>;
>  		rockchip,external-psm = <0xe594 14 30>;
> -- 
> 2.0.0
> 
> 
