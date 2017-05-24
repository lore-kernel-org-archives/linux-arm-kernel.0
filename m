From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 24 May 2017 11:07:27 +0200
Subject: [PATCH v2 2/2] ARM: dts: tx6: Remove 'enable-active-low' property
In-Reply-To: <1495553564-19112-2-git-send-email-fabio.estevam@nxp.com>
References: <1495553564-19112-1-git-send-email-fabio.estevam@nxp.com>
 <1495553564-19112-2-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20170524110727.42dbb58d@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio Estevam <fabio.estevam@nxp.com> wrote:

> Property 'enable-active-low' does not exist. Only 'enable-active-high' is
> valid, and when this property is absent the gpio regulator will act as
> active low by default.
> 
> So remove the unexisting 'enable-active-low' property. 
> 
> Currently the GPIO flag is GPIO_ACTIVE_HIGH. In order to make
> the dts description accurate, pass the GPIO_ACTIVE_LOW flag instead.
> 
> This change is safe because the gpio regulator driver does not take the
> GPIO flag polarity into account.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Changes since v1:
> - Improve commit log and explain why this change is safe (Stefan).
> 
>  arch/arm/boot/dts/imx6qdl-tx6.dtsi  | 3 +--
>  arch/arm/boot/dts/imx6ul-tx6ul.dtsi | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
> index 1691714..a146fe7 100644
> --- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
> @@ -133,8 +133,7 @@
>  		regulator-max-microvolt = <3300000>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_flexcan_xcvr>;
> -		gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
> -		enable-active-low;
> +		gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
>  	};
>  
>  	reg_lcd0_pwr: regulator-lcd0-pwr {
> diff --git a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
> index c784a0b..4ccc9e9 100644
> --- a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
> @@ -173,8 +173,7 @@
>  		regulator-max-microvolt = <3300000>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_flexcan_xcvr>;
> -		gpio = <&gpio3 5 GPIO_ACTIVE_HIGH>;
> -		enable-active-low;
> +		gpio = <&gpio3 5 GPIO_ACTIVE_LOW>;
>  	};
>  
>  	reg_lcd_pwr: regulator-lcdpwr {

Acked-by: Lothar Wa?mann <LW@KARO-electronics.de>

Thanks for the cleanup,
Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
