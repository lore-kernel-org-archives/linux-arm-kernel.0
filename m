From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 4 Nov 2018 15:39:35 +0800
Subject: [PATCH V1 1/4] ARM: dts: imx6sx: Add flexcan stop mode wakeup
 support
In-Reply-To: <20181023052831.2553-2-qiangqing.zhang@nxp.com>
References: <20181023052831.2553-1-qiangqing.zhang@nxp.com>
 <20181023052831.2553-2-qiangqing.zhang@nxp.com>
Message-ID: <20181104073931.GC26016@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 05:30:44AM +0000, Joakim Zhang wrote:
> From: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Add stop-mode property which is required by stop mode wakeup
> feature.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sx.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 844caa39364f..3f459d6da7fc 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -448,6 +448,7 @@
>  				clocks = <&clks IMX6SX_CLK_CAN1_IPG>,
>  					 <&clks IMX6SX_CLK_CAN1_SERIAL>;
>  				clock-names = "ipg", "per";
> +				stop-mode = <&gpr 0x10 1 0x10 17>;

Is it supported by upstream?  I cannot find this property in ether flexcan
bindings doc or kernel driver.

Shawn

>  				status = "disabled";
>  			};
>  
> @@ -458,6 +459,7 @@
>  				clocks = <&clks IMX6SX_CLK_CAN2_IPG>,
>  					 <&clks IMX6SX_CLK_CAN2_SERIAL>;
>  				clock-names = "ipg", "per";
> +				stop-mode = <&gpr 0x10 2 0x10 18>;
>  				status = "disabled";
>  			};
>  
> -- 
> 2.17.1
> 
