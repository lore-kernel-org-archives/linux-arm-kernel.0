From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Oct 2017 08:38:10 +0800
Subject: [PATCH v3 6/6] ARM: dts: imx53-tx53: Fix 'ethernet-phy@0' node
 with unit name and no reg property
In-Reply-To: <1508514507-30736-6-git-send-email-marco.franchi@nxp.com>
References: <1508514507-30736-1-git-send-email-marco.franchi@nxp.com>
 <1508514507-30736-6-git-send-email-marco.franchi@nxp.com>
Message-ID: <20171023003808.GC8700@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 01:48:27PM -0200, Marco Franchi wrote:
> The following build warning is seen with W=1:
> 
> Warning (unit_address_vs_reg): Node /soc/aips at 60000000/ethernet at 63fec000/ethernet-phy at 0 has a unit name, but no reg property
> 
> Fix this warning by adding reg property from such node.
> 
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

I'm not sure if you tested the change, but I'm seeing the following
warning.

Warning (reg_format): "reg" property in
/soc/aips at 60000000/ethernet at 63fec000/ethernet-phy at 0 has invalid length
(4 bytes) (#address-cells == 2, #size-cells == 1)

Shawn

> ---
> Changes since v2:
> -change message log
> -add reg property
>  arch/arm/boot/dts/imx53-tx53.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
> index 76e7186..61ecd13 100644
> --- a/arch/arm/boot/dts/imx53-tx53.dtsi
> +++ b/arch/arm/boot/dts/imx53-tx53.dtsi
> @@ -226,6 +226,7 @@
>  	status = "okay";
>  
>  	phy0: ethernet-phy at 0 {
> +		reg = <0>;
>  		interrupts-extended = <&gpio2 4 IRQ_TYPE_EDGE_FALLING>;
>  		device_type = "ethernet-phy";
>  	};
> -- 
> 2.7.4
> 
