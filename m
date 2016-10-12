From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 12 Oct 2016 10:39:25 +0800
Subject: [PATCH 2/2] arm64: dts: zx: Add clock controller nodes
In-Reply-To: <1476238456-20420-2-git-send-email-jun.nie@linaro.org>
References: <1476238456-20420-1-git-send-email-jun.nie@linaro.org>
 <1476238456-20420-2-git-send-email-jun.nie@linaro.org>
Message-ID: <20161012023925.GD15400@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2016 at 10:14:16AM +0800, Jun Nie wrote:
> Add clock controller nodes, including one top controller
> two low speed controllers and one audio controller.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  arch/arm64/boot/dts/zte/zx296718.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
> index 6b239a3..33e42d5 100644
> --- a/arch/arm64/boot/dts/zte/zx296718.dtsi
> +++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
> @@ -279,9 +279,33 @@
>  			dma-requests = <32>;
>  		};
>  
> +		lsp0crm: clock-controller at 01420000 {

Please drop the leading zeros from unit-address in node name.

Shawn

> +			compatible = "zte,zx296718-lsp0crm";
> +			reg = <0x01420000 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		lsp1crm: clock-controller at 01430000 {
> +			compatible = "zte,zx296718-lsp1crm";
> +			reg = <0x01430000 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		topcrm: clock-controller at 01461000 {
> +			compatible = "zte,zx296718-topcrm";
> +			reg = <0x01461000 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>  		sysctrl: sysctrl at 1463000 {
>  			compatible = "zte,zx296718-sysctrl", "syscon";
>  			reg = <0x1463000 0x1000>;
>  		};
> +
> +		audiocrm: clock-controller at 01480000 {
> +			compatible = "zte,zx296718-audiocrm";
> +			reg = <0x01480000 0x1000>;
> +			#clock-cells = <1>;
> +		};
>  	};
>  };
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
