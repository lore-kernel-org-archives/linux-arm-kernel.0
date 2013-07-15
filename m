From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 15 Jul 2013 10:11:06 +0800
Subject: [PATCH] ARM: dts: imx6qdl/imx6sl: add the dma property for uart
In-Reply-To: <1373623329-18204-1-git-send-email-b32955@freescale.com>
References: <1373623329-18204-1-git-send-email-b32955@freescale.com>
Message-ID: <20130715021105.GD2730@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 06:02:09PM +0800, Huang Shijie wrote:
> Add the dma property for all the uart.
> 
> Note: Add the dma property does not mean we enable the dma for this
> uart.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Applied.  But I change the patch to put dma-names after dmas.

Shawn

> ---
>  arch/arm/boot/dts/imx6q-arm2.dts |    2 --
>  arch/arm/boot/dts/imx6qdl.dtsi   |   10 ++++++++++
>  arch/arm/boot/dts/imx6sl.dtsi    |   10 ++++++++++
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
> index 9b17393..edf1bd9 100644
> --- a/arch/arm/boot/dts/imx6q-arm2.dts
> +++ b/arch/arm/boot/dts/imx6q-arm2.dts
> @@ -102,8 +102,6 @@
>  	pinctrl-0 = <&pinctrl_uart2_2>;
>  	fsl,dte-mode;
>  	fsl,uart-has-rtscts;
> -	dma-names = "rx", "tx";
> -	dmas = <&sdma 27 4 0>, <&sdma 28 4 0>;
>  	status = "okay";
>  };
>  
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 72a28d6..34ffc2e 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -197,6 +197,8 @@
>  					interrupts = <0 26 0x04>;
>  					clocks = <&clks 160>, <&clks 161>;
>  					clock-names = "ipg", "per";
> +					dma-names = "rx", "tx";
> +					dmas = <&sdma 25 4 0>, <&sdma 26 4 0>;
>  					status = "disabled";
>  				};
>  
> @@ -1479,6 +1481,8 @@
>  				interrupts = <0 27 0x04>;
>  				clocks = <&clks 160>, <&clks 161>;
>  				clock-names = "ipg", "per";
> +				dma-names = "rx", "tx";
> +				dmas = <&sdma 27 4 0>, <&sdma 28 4 0>;
>  				status = "disabled";
>  			};
>  
> @@ -1488,6 +1492,8 @@
>  				interrupts = <0 28 0x04>;
>  				clocks = <&clks 160>, <&clks 161>;
>  				clock-names = "ipg", "per";
> +				dma-names = "rx", "tx";
> +				dmas = <&sdma 29 4 0>, <&sdma 30 4 0>;
>  				status = "disabled";
>  			};
>  
> @@ -1497,6 +1503,8 @@
>  				interrupts = <0 29 0x04>;
>  				clocks = <&clks 160>, <&clks 161>;
>  				clock-names = "ipg", "per";
> +				dma-names = "rx", "tx";
> +				dmas = <&sdma 31 4 0>, <&sdma 32 4 0>;
>  				status = "disabled";
>  			};
>  
> @@ -1506,6 +1514,8 @@
>  				interrupts = <0 30 0x04>;
>  				clocks = <&clks 160>, <&clks 161>;
>  				clock-names = "ipg", "per";
> +				dma-names = "rx", "tx";
> +				dmas = <&sdma 33 4 0>, <&sdma 34 4 0>;
>  				status = "disabled";
>  			};
>  		};
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 0a297af..230ee86 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -159,6 +159,8 @@
>  					clocks = <&clks IMX6SL_CLK_UART>,
>  						 <&clks IMX6SL_CLK_UART_SERIAL>;
>  					clock-names = "ipg", "per";
> +					dma-names = "rx", "tx";
> +					dmas = <&sdma 33 4 0>, <&sdma 34 4 0>;
>  					status = "disabled";
>  				};
>  
> @@ -170,6 +172,8 @@
>  					clocks = <&clks IMX6SL_CLK_UART>,
>  						 <&clks IMX6SL_CLK_UART_SERIAL>;
>  					clock-names = "ipg", "per";
> +					dma-names = "rx", "tx";
> +					dmas = <&sdma 25 4 0>, <&sdma 26 4 0>;
>  					status = "disabled";
>  				};
>  
> @@ -181,6 +185,8 @@
>  					clocks = <&clks IMX6SL_CLK_UART>,
>  						 <&clks IMX6SL_CLK_UART_SERIAL>;
>  					clock-names = "ipg", "per";
> +					dma-names = "rx", "tx";
> +					dmas = <&sdma 27 4 0>, <&sdma 28 4 0>;
>  					status = "disabled";
>  				};
>  
> @@ -219,6 +225,8 @@
>  					clocks = <&clks IMX6SL_CLK_UART>,
>  						 <&clks IMX6SL_CLK_UART_SERIAL>;
>  					clock-names = "ipg", "per";
> +					dma-names = "rx", "tx";
> +					dmas = <&sdma 29 4 0>, <&sdma 30 4 0>;
>  					status = "disabled";
>  				};
>  
> @@ -230,6 +238,8 @@
>  					clocks = <&clks IMX6SL_CLK_UART>,
>  						 <&clks IMX6SL_CLK_UART_SERIAL>;
>  					clock-names = "ipg", "per";
> +					dma-names = "rx", "tx";
> +					dmas = <&sdma 31 4 0>, <&sdma 32 4 0>;
>  					status = "disabled";
>  				};
>  			};
> -- 
> 1.7.1
> 
> 
