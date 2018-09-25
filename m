From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 25 Sep 2018 17:20:20 +0800
Subject: [PATCH v4 5/6] ARM: dts: imx7d: Add turnoff reset
In-Reply-To: <c305d4da96ead7d570bf755fde9f0e0cc68f88e0.1534264292.git.leonard.crestez@nxp.com>
References: <cover.1534264292.git.leonard.crestez@nxp.com>
 <c305d4da96ead7d570bf755fde9f0e0cc68f88e0.1534264292.git.leonard.crestez@nxp.com>
Message-ID: <20180925092018.GA21282@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2018 at 07:50:19PM +0300, Leonard Crestez wrote:
> This is required for the imx pci driver to send the PME_Turn_Off TLP.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>

> ---
>  arch/arm/boot/dts/imx7d.dtsi | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> index 7234e8330a57..efbdeaaa8dcd 100644
> --- a/arch/arm/boot/dts/imx7d.dtsi
> +++ b/arch/arm/boot/dts/imx7d.dtsi
> @@ -144,12 +144,13 @@
>  					 <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
>  
>  		fsl,max-link-speed = <2>;
>  		power-domains = <&pgc_pcie_phy>;
>  		resets = <&src IMX7_RESET_PCIEPHY>,
> -			 <&src IMX7_RESET_PCIE_CTRL_APPS_EN>;
> -		reset-names = "pciephy", "apps";
> +			 <&src IMX7_RESET_PCIE_CTRL_APPS_EN>,
> +			 <&src IMX7_RESET_PCIE_CTRL_APPS_TURNOFF>;
> +		reset-names = "pciephy", "apps", "turnoff";
>  		status = "disabled";
>  	};
>  };
>  
>  &ca_funnel_ports {
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
