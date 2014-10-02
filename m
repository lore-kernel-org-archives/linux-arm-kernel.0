From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 2 Oct 2014 15:18:14 -0400
Subject: [PATCH v1 4/4] ARM: dts: k2hk-evm: attach net, qmss and knav_dmas
 to keystone-gpc
In-Reply-To: <1412001499-19369-5-git-send-email-grygorii.strashko@ti.com>
References: <1412001499-19369-1-git-send-email-grygorii.strashko@ti.com>
 <1412001499-19369-5-git-send-email-grygorii.strashko@ti.com>
Message-ID: <542DA4F6.2020009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 September 2014 10:38 AM, Grygorii Strashko wrote:
> Attach Keystone 2s nodes for NetCP, NetCPx, QMSS, KNAV-DMA devices
> to the TI Keystone 2 Generic PM Controller.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  arch/arm/boot/dts/k2hk-evm.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/k2hk-evm.dts
> index 91371f7..c1ceaa2 100644
> --- a/arch/arm/boot/dts/k2hk-evm.dts
> +++ b/arch/arm/boot/dts/k2hk-evm.dts
> @@ -58,6 +58,7 @@
>  				clock-output-names = "refclk-ddr3b";
>  			};
>  		};
> +
Stray change ?

>  		qmss: qmss at 2a40000 {
>  			compatible = "ti,keystone-navigator-qmss";
>  			dma-coherent;
> @@ -65,6 +66,8 @@
>  			#size-cells = <1>;
>  			clocks = <&chipclk13>;
>  			ranges;
> +			power-domains = <&pm_controller>;
> +
>  			queue-range	= <0 0x4000>;
>  			linkram0	= <0x100000 0x8000>;
>  			linkram1	= <0x0 0x10000>;
> @@ -198,6 +201,8 @@
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> +			power-domains = <&pm_controller>;
> +
>  			ti,navigator-cloud-address = <0x23a80000 0x23a90000
>  						   0x23aa0000 0x23ab0000>;
>  
> @@ -229,6 +234,7 @@
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> +			power-domains = <&pm_controller>;
>  
>  			clocks = <&clkpa>, <&clkcpgmac>, <&chipclk12>;
>  			dma-coherent;
> @@ -307,6 +313,7 @@
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> +			power-domains = <&pm_controller>;
>  
>  			clocks = <&clkxge>;
>  			clock-names = "clk_xge";
> 
