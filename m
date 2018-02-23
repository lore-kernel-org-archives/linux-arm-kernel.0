From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 23 Feb 2018 08:20:22 +0100
Subject: [PATCH] ARM: dts: imx6: Pass memory unit-adress
In-Reply-To: <1519319795-18161-1-git-send-email-festevam@gmail.com>
References: <1519319795-18161-1-git-send-email-festevam@gmail.com>
Message-ID: <20180223082022.17d7b8a2@karo-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 22 Feb 2018 14:16:35 -0300 Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Pass the memory unit-adress to fix the following build warnings with W=1:
> 
> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
> 
> There are cases where dts passes an empty memory node, which will be filled
> by the bootloader. Passing the memory base address still allows the 
> bootloader to fill the memory size.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts   | 4 ++--
>  arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts     | 4 ++--
>  arch/arm/boot/dts/imx6dl-ts4900.dts            | 4 ++--
>  arch/arm/boot/dts/imx6dl-ts7970.dts            | 4 ++--
>  arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts      | 4 ++--
>  arch/arm/boot/dts/imx6q-h100.dts               | 4 ++--
>  arch/arm/boot/dts/imx6q-novena.dts             | 4 ++--
>  arch/arm/boot/dts/imx6q-ts4900.dts             | 4 ++--
>  arch/arm/boot/dts/imx6q-ts7970.dts             | 4 ++--
>  arch/arm/boot/dts/imx6q-zii-rdu2.dts           | 4 ++--
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi          | 4 ++--
>  arch/arm/boot/dts/imx6qdl-cubox-i.dtsi         | 4 ++--
>  arch/arm/boot/dts/imx6qdl-hummingboard.dtsi    | 4 ++--
>  arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi   | 4 ++--
>  arch/arm/boot/dts/imx6qdl-tx6.dtsi             | 4 ++--
>  arch/arm/boot/dts/imx6qp-zii-rdu2.dts          | 4 ++--
>  arch/arm/boot/dts/imx6ul-tx6ul.dtsi            | 4 ++--
>  arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi | 2 +-
>  arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi    | 2 +-
>  19 files changed, 36 insertions(+), 36 deletions(-)
> 
[...]
> diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
> index 6abb66c..f015e2d 100644
> --- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
> @@ -61,8 +61,8 @@
>  		sdhc1 = &usdhc2;
>  	};
>  
> -	memory {
> -		reg = <0 0>; /* will be filled by U-Boot */
> +	memory at 10000000 {
> +		reg = <0x10000000 0>; /* will be filled by U-Boot */
>  	};
>  
>  	clocks {
[...]
> diff --git a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
> index 65111f98..f678d18 100644
> --- a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
> @@ -70,8 +70,8 @@
>  		stdout-path = &uart1;
>  	};
>  
> -	memory {
> -		reg = <0 0>; /* will be filled by U-Boot */
> +	memory at 80000000 {
> +		reg = <0x80000000 0>; /* will be filled by U-Boot */
>  	};
>  
>  	clocks {
>
For those two:
Acked-By: Lothar Wa?mann <LW@KARO-electronics.de>


Lothar Wa?mann
