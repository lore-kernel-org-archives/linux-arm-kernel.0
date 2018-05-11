From: seanpaul@chromium.org (Sean Paul)
Date: Fri, 11 May 2018 10:43:05 -0400
Subject: [PATCH v2 3/4] Documentation: bindings: add phy_config for
 Rockchip USB Type-C PHY
In-Reply-To: <1525861364-26323-3-git-send-email-hl@rock-chips.com>
References: <1525861364-26323-1-git-send-email-hl@rock-chips.com>
 <1525861364-26323-3-git-send-email-hl@rock-chips.com>
Message-ID: <20180511144305.GP33053@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 06:22:43PM +0800, Lin Huang wrote:
> If want to do training outside DP Firmware, need phy voltage swing
> and pre_emphasis value.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>

Adding Rob Herring so he has a hope of seeing this.

> ---
> Changes in v2:
> - rebase
> 
>  Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> index 960da7f..eda26dd 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> @@ -17,7 +17,9 @@ Required properties:
>  
>  Optional properties:
>   - extcon : extcon specifier for the Power Delivery
> -
> + - rockchip,phy_config : That's phy voltage swing and pre_emphasis
> +			 setting, if want to do dp training outside
> +			 dp firmware, need to add these value.

What are the units?

Sean

>  Required nodes : a sub-node is required for each port the phy provides.
>  		 The sub-node name is used to identify dp or usb3 port,
>  		 and shall be the following entries:
> -- 
> 2.7.4
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
