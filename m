From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 12 Jul 2013 16:40:27 +0800
Subject: [PATCH rebased 2/2] ARM: dts: imx6qdl-sabreauto: add a DT node
 for uart3
In-Reply-To: <1373615772-30665-2-git-send-email-b32955@freescale.com>
References: <1373615772-30665-1-git-send-email-b32955@freescale.com>
 <1373615772-30665-2-git-send-email-b32955@freescale.com>
Message-ID: <20130712084025.GH25501@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 03:56:12PM +0800, Huang Shijie wrote:
> Add a DT node for uart3, in the imx6q{dl}-sabreauto boards,
> the uart3 is used by Bluetooth.
> 
> Since the uart3 has pin conflict with gpmi and weim nor, we keep it
> disabled by default.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> index 365e8ff..70a8bf1 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -67,6 +67,15 @@
>  	};
>  };
>  
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3_1>;
> +	fsl,uart-has-rtscts;

> +	dma-names = "rx", "tx";
> +	dmas = <&sdma 29 4 0>, <&sdma 30 4 0>;

These two properties should be added in imx6qdl.dtsi

Shawn

> +	status = "disabled"; /* used by the BT, pin conflict with gpmi and weim NOR */
> +};
> +
>  &uart4 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart4_1>;
> -- 
> 1.7.1
> 
> 
