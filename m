From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 10 Feb 2014 11:11:42 +0800
Subject: [PATCH 1/3] ARM: dts: imx27-phytec-phycard-s-som: Sort entries
In-Reply-To: <1391525972-15810-1-git-send-email-shc_work@mail.ru>
References: <1391525972-15810-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140210031140.GC9628@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 06:59:30PM +0400, Alexander Shiyan wrote:
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied all 3, thanks.

Shawn

> ---
>  arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts | 36 ++++++++++++------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
> index e51e550..a28b6c7 100644
> --- a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
> +++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
> @@ -29,6 +29,24 @@
>  	status = "okay";
>  };
>  
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec1>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	at24 at 52 {
> +		compatible = "at,24c32";
> +		pagesize = <32>;
> +		reg = <0x52>;
> +	};
> +};
> +
>  &iomuxc {
>  	imx27-phycard-s-som {
>  		pinctrl_fec1: fec1grp {
> @@ -62,21 +80,3 @@
>  		};
>  	};
>  };
> -
> -&fec {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_fec1>;
> -	status = "okay";
> -};
> -
> -&i2c2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_i2c2>;
> -	status = "okay";
> -
> -	at24 at 52 {
> -		compatible = "at,24c32";
> -		pagesize = <32>;
> -		reg = <0x52>;
> -	};
> -};
> -- 
> 1.8.3.2
> 
