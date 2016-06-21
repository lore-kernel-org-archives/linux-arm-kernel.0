From: robh@kernel.org (Rob Herring)
Date: Tue, 21 Jun 2016 16:58:42 -0500
Subject: [PATCH v2] net: stmmac: dwmac-rk: add rk3228-specific data
In-Reply-To: <1466512409-18855-1-git-send-email-zhengxing@rock-chips.com>
References: <1466512409-18855-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <20160621215842.GA16151@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 08:33:28PM +0800, Xing Zheng wrote:
> Add constants and callback functions for the dwmac on rk3228/rk3229 socs.
> As can be seen, the base structure is the same, only registers and the
> bits in them moved slightly.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> ---
> 
> Changes in v2:
> - the "rk322x" is not clear to SoC decription, rename it to "rk3228"
> 
>  .../devicetree/bindings/net/rockchip-dwmac.txt     |    3 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |  117 ++++++++++++++++++++
>  2 files changed, 119 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.txt b/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
> index 93eac7c..cccd945 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
> @@ -3,7 +3,8 @@ Rockchip SoC RK3288 10/100/1000 Ethernet driver(GMAC)
>  The device node has following properties.
>  
>  Required properties:
> - - compatible: Can be one of "rockchip,rk3288-gmac", "rockchip,rk3368-gmac"
> + - compatible: Can be one of "rockchip,rk3228-gmac", "rockchip,rk3288-gmac",
> +                             "rockchip,rk3368-gmac"

Not worth reposting just for this, but 1 per line is preferred.

Acked-by: Rob Herring <robh@kernel.org>

>   - reg: addresses and length of the register sets for the device.
>   - interrupts: Should contain the GMAC interrupts.
>   - interrupt-names: Should contain the interrupt names "macirq".
