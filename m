From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 16 Sep 2013 16:44:15 +0800
Subject: [PATCH v2 9/9] ARM: dts: imx6qdl: add uhs pinctrl state for usdhc3
In-Reply-To: <1379070698-7344-10-git-send-email-b29396@freescale.com>
References: <1379070698-7344-1-git-send-email-b29396@freescale.com>
 <1379070698-7344-10-git-send-email-b29396@freescale.com>
Message-ID: <20130916084413.GK31147@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 07:11:38PM +0800, Dong Aisheng wrote:
> This is needed for supporting ultra high speed cards like SD3.0 cards.
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi |    5 ++++-
>  arch/arm/boot/dts/imx6qdl.dtsi           |   30 ++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> index 1cbbc51..ff6f1e8 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -54,6 +54,7 @@
>  			fsl,pins = <
>  				MX6QDL_PAD_NANDF_CS2__GPIO6_IO15 0x80000000
>  				MX6QDL_PAD_SD2_DAT2__GPIO1_IO13  0x80000000
> +				MX6QDL_PAD_GPIO_18__SD3_VSELECT 0x17059
>  			>;
>  		};
>  	};
> @@ -74,8 +75,10 @@
>  };
>  
>  &usdhc3 {
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>  	pinctrl-0 = <&pinctrl_usdhc3_1>;
> +	pinctrl-1 = <&pinctrl_usdhc3_1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc3_1_200mhz>;
>  	cd-gpios = <&gpio6 15 0>;
>  	wp-gpios = <&gpio1 13 0>;
>  	status = "okay";
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index ccd55c2..cb17574 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -1184,6 +1184,36 @@
>  						>;
>  					};
>  
> +					pinctrl_usdhc3_1_100mhz: usdhc3grp-1-100mhz { /* 100Mhz */
> +						fsl,pins = <
> +							MX6QDL_PAD_SD3_CMD__SD3_CMD 0x170B9
> +							MX6QDL_PAD_SD3_CLK__SD3_CLK 0x100B9
> +							MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x170B9
> +							MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x170B9
> +							MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x170B9
> +							MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x170B9
> +							MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x170B9
> +							MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x170B9
> +							MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x170B9
> +							MX6QDL_PAD_SD3_DAT7__SD3_DATA7 0x170B9

I commented in the previous review that we use lowercase for hex values
in device tree.  It seems that you missed the comment.  Since this patch
can be applied independently, I just fixed them up and applied it.

Shawn

> +						>;
> +					};
> +
> +					pinctrl_usdhc3_1_200mhz: usdhc3grp-1-200mhz { /* 200Mhz */
> +						fsl,pins = <
> +							MX6QDL_PAD_SD3_CMD__SD3_CMD 0x170F9
> +							MX6QDL_PAD_SD3_CLK__SD3_CLK 0x100F9
> +							MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x170F9
> +							MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x170F9
> +							MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x170F9
> +							MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x170F9
> +							MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x170F9
> +							MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x170F9
> +							MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x170F9
> +							MX6QDL_PAD_SD3_DAT7__SD3_DATA7 0x170F9
> +						>;
> +					};
> +
>  					pinctrl_usdhc3_2: usdhc3grp-2 {
>  						fsl,pins = <
>  							MX6QDL_PAD_SD3_CMD__SD3_CMD    0x17059
> -- 
> 1.7.1
> 
> 
