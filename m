From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Sep 2016 08:28:50 -0500
Subject: [PATCH v4 1/6] net: stmmac: dwmac-rk: add rk3366 & rk3399
 specific data
In-Reply-To: <1472752204-8924-2-git-send-email-wxt@rock-chips.com>
References: <1472752204-8924-1-git-send-email-wxt@rock-chips.com>
 <1472752204-8924-2-git-send-email-wxt@rock-chips.com>
Message-ID: <20160912132850.GA24241@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2016 at 01:49:59AM +0800, Caesar Wang wrote:
> From: Roger Chen <roger.chen@rock-chips.com>
> 
> Add constants and callback functions for the dwmac on rk3228/rk3229 socs.
> As can be seen, the base structure is the same, only registers and the
> bits in them moved slightly.
> 
> Signed-off-by: Roger Chen <roger.chen@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> ---
> 
> Changes in v4:
> - Fixes from the original patch on https://patchwork.kernel.org/patch/9274557/
> 
> Changes in v3: None
> Changes in v2: None
> 
>  .../devicetree/bindings/net/rockchip-dwmac.txt     |   8 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     | 226 +++++++++++++++++++++
>  2 files changed, 232 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.txt b/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
> index cccd945..95383c5 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
> @@ -3,8 +3,12 @@ Rockchip SoC RK3288 10/100/1000 Ethernet driver(GMAC)
>  The device node has following properties.
>  
>  Required properties:
> - - compatible: Can be one of "rockchip,rk3228-gmac", "rockchip,rk3288-gmac",
> -                             "rockchip,rk3368-gmac"
> + - compatible: should be "rockchip,<name>-gamc"

s/gamc/gmac/

Please send a follow-up patch to fix.

> +   "rockchip,rk3228-gmac": found on RK322x SoCs
> +   "rockchip,rk3288-gmac": found on RK3288 SoCs
> +   "rockchip,rk3366-gmac": found on RK3366 SoCs
> +   "rockchip,rk3368-gmac": found on RK3368 SoCs
> +   "rockchip,rk3399-gmac": found on RK3399 SoCs
>   - reg: addresses and length of the register sets for the device.
>   - interrupts: Should contain the GMAC interrupts.
>   - interrupt-names: Should contain the interrupt names "macirq".
