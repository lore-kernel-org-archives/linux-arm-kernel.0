From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 24 Jun 2017 04:29:54 +0200
Subject: [PATCH 05/11] net: stmmac: dwmac-rk: Add internal phy support
In-Reply-To: <1498193947-8011-1-git-send-email-david.wu@rock-chips.com>
References: <1498192929-7519-1-git-send-email-david.wu@rock-chips.com>
 <1498193947-8011-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <20170624022954.GD4875@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 12:59:07PM +0800, David Wu wrote:
> To make internal phy worked, need to configure the phy_clock,
> phy cru_reset and related registers.
> 
> Change-Id: I6971c0a769754b824b1b908b56080cbaf7867d13
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>  .../devicetree/bindings/net/rockchip-dwmac.txt     |  3 +
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     | 82 ++++++++++++++++++++++
>  2 files changed, 85 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.txt b/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
> index 8f42755..0514f69 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
> @@ -22,6 +22,7 @@ Required properties:
>  	   <&cru SCLK_MACREF_OUT> clock gate for RMII reference clock output
>  	   <&cru ACLK_GMAC>: AXI clock gate for GMAC
>  	   <&cru PCLK_GMAC>: APB clock gate for GMAC
> +	   <&cru MAC_PHY>: clock for internal macphy

If this is the PHY clock, should it actually be specified in the PHY
binding? Can you read the PHY ID registers with this clock off?

	 Andrew
