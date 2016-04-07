From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 7 Apr 2016 10:50:42 +0800
Subject: [PATCH v2 3/3] ARM: imx6: adopt DT to new GPC binding
In-Reply-To: <1458128514-9560-3-git-send-email-l.stach@pengutronix.de>
References: <1458128514-9560-1-git-send-email-l.stach@pengutronix.de>
 <1458128514-9560-3-git-send-email-l.stach@pengutronix.de>
Message-ID: <20160407025042.GB3111@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 12:41:54PM +0100, Lucas Stach wrote:
> @@ -786,14 +787,29 @@
>  				interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>,
>  					     <0 90 IRQ_TYPE_LEVEL_HIGH>;
>  				interrupt-parent = <&intc>;
> -				pu-supply = <&reg_pu>;
> -				clocks = <&clks IMX6QDL_CLK_GPU3D_CORE>,
> -					 <&clks IMX6QDL_CLK_GPU3D_SHADER>,
> -					 <&clks IMX6QDL_CLK_GPU2D_CORE>,
> -					 <&clks IMX6QDL_CLK_GPU2D_AXI>,
> -					 <&clks IMX6QDL_CLK_OPENVG_AXI>,
> -					 <&clks IMX6QDL_CLK_VPU_AXI>;
> -				#power-domain-cells = <1>;
> +				clocks = <&clks IMX6QDL_CLK_IPG>;
> +				clock-names = "ipg";
> +
> +				pgc {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					power-domain at 0 {
> +						reg = <0>;
> +						#power-domain-cells = <0>;
> +					};

Have a new line between nodes please.

Shawn

> +					pd_pu: power-domain at 1 {
> +						reg = <1>;
> +						#power-domain-cells = <0>;
> +						domain-supply = <&reg_pu>;
> +						clocks = <&clks IMX6QDL_CLK_GPU3D_CORE>,
> +						         <&clks IMX6QDL_CLK_GPU3D_SHADER>,
> +						         <&clks IMX6QDL_CLK_GPU2D_CORE>,
> +						         <&clks IMX6QDL_CLK_GPU2D_AXI>,
> +						         <&clks IMX6QDL_CLK_OPENVG_AXI>,
> +						         <&clks IMX6QDL_CLK_VPU_AXI>;
> +					};
> +				};
>  			};
>  
>  			gpr: iomuxc-gpr at 020e0000 {
> -- 
> 2.7.0
> 
> 
