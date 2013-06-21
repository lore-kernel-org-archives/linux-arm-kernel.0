From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 21 Jun 2013 10:01:02 +0800
Subject: [PATCH 1/3] ARM: dts: imx6dl: add a new pinctrl for ecspi1
In-Reply-To: <1371708010-22710-1-git-send-email-b32955@freescale.com>
References: <1371708010-22710-1-git-send-email-b32955@freescale.com>
Message-ID: <20130621020100.GA24268@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 02:00:08PM +0800, Huang Shijie wrote:
> This new pinctrl is used in the imx6dl-sabresd board.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/boot/dts/imx6dl.dtsi |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
> index 2b3ecd6..b8f6fab 100644
> --- a/arch/arm/boot/dts/imx6dl.dtsi
> +++ b/arch/arm/boot/dts/imx6dl.dtsi
> @@ -56,6 +56,13 @@
>  							MX6DL_PAD_EIM_D16__ECSPI1_SCLK 0x100b1
>  						>;
>  					};

Please have a blank line between nodes.

> +					pinctrl_ecspi1_2: ecspi1cr-1 {

What does the "cr" in the node name mean?  Aren't we generally using
"grp" there?

Shawn

> +						fsl,pins = <
> +							MX6DL_PAD_KEY_COL1__ECSPI1_MISO 0x100b1
> +							MX6DL_PAD_KEY_ROW0__ECSPI1_MOSI 0x100b1
> +							MX6DL_PAD_KEY_COL0__ECSPI1_SCLK 0x100b1
> +						>;
> +					};
>  				};
>  
>  				enet {
> -- 
> 1.7.1
> 
> 
