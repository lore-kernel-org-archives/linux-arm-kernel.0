From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 12 Jul 2013 13:28:35 +0800
Subject: [PATCH 1/2] ARM: dts: imx6q{dl}: add a new pinctrl for uart3
In-Reply-To: <1373449227-11740-1-git-send-email-b32955@freescale.com>
References: <1373449227-11740-1-git-send-email-b32955@freescale.com>
Message-ID: <20130712052833.GA25501@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 10, 2013 at 05:40:26PM +0800, Huang Shijie wrote:
> Add the a new pinctrl for uart3. In the imx6q{dl}-sabreauto boards,
> the uart3 is used for Bluetooth.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

We have some pin groups tweaking happening in DTS files.  Can you please
rebase your patches on the latest imx/dt branch?

Shawn

> ---
>  arch/arm/boot/dts/imx6dl.dtsi |   11 +++++++++++
>  arch/arm/boot/dts/imx6q.dtsi  |   11 +++++++++++
>  2 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
> index a1302ed..d818ced 100644
> --- a/arch/arm/boot/dts/imx6dl.dtsi
> +++ b/arch/arm/boot/dts/imx6dl.dtsi
> @@ -234,6 +234,17 @@
>  					};
>  				};
>  
> +				uart3 {
> +					pinctrl_uart3_1: uart3grp-1 {
> +						fsl,pins = <
> +							MX6DL_PAD_SD4_CLK__UART3_RX_DATA 0x1b0b1
> +							MX6DL_PAD_SD4_CMD__UART3_TX_DATA 0x1b0b1
> +							MX6DL_PAD_EIM_D30__UART3_CTS_B   0x1b0b1
> +							MX6DL_PAD_EIM_EB3__UART3_RTS_B   0x1b0b1
> +						>;
> +					};
> +				};
> +
>  				uart4 {
>  					pinctrl_uart4_1: uart4grp-1 {
>  						fsl,pins = <
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index e0b7bad..1984ca4 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -277,6 +277,17 @@
>  					};
>  				};
>  
> +				uart3 {
> +					pinctrl_uart3_1: uart3grp-1 {
> +						fsl,pins = <
> +							MX6Q_PAD_SD4_CLK__UART3_RX_DATA 0x1b0b1
> +							MX6Q_PAD_SD4_CMD__UART3_TX_DATA 0x1b0b1
> +							MX6Q_PAD_EIM_D30__UART3_CTS_B   0x1b0b1
> +							MX6Q_PAD_EIM_EB3__UART3_RTS_B   0x1b0b1
> +						>;
> +					};
> +				};
> +
>  				uart4 {
>  					pinctrl_uart4_1: uart4grp-1 {
>  						fsl,pins = <
> -- 
> 1.7.1
> 
> 
