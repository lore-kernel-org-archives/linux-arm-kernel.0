From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 5 Sep 2013 10:03:04 +0200
Subject: [PATCH 8/8] ARM: dts: imx6qdl: add uhs pinctrl state for usdhc3
In-Reply-To: <1378299257-2980-9-git-send-email-b29396@freescale.com>
References: <1378299257-2980-1-git-send-email-b29396@freescale.com>
 <1378299257-2980-9-git-send-email-b29396@freescale.com>
Message-ID: <20130905080303.GP30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 04, 2013 at 08:54:17PM +0800, Dong Aisheng wrote:
> This is needed for supporting ultra high speed cards like SD3.0 cards.
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---
>  arch/arm/boot/dts/imx6dl.dtsi            |   33 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6q.dtsi             |   33 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi |    4 ++-
>  3 files changed, 69 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
> index 2b3ecd6..e983b81 100644
> --- a/arch/arm/boot/dts/imx6dl.dtsi
> +++ b/arch/arm/boot/dts/imx6dl.dtsi
> @@ -203,6 +203,39 @@
>  							MX6DL_PAD_SD3_DAT3__SD3_DATA3 0x17059
>  						>;
>  					};
> +
> +                                       pinctrl_usdhc3_3: usdhc3grp-3 { /* 100Mhz */
> +                                               fsl,pins = <
> +                                                       MX6DL_PAD_SD3_CMD__SD3_CMD 0x170B9
> +                                                       MX6DL_PAD_SD3_CLK__SD3_CLK 0x100B9
> +                                                       MX6DL_PAD_SD3_DAT0__SD3_DATA0 0x170B9
> +                                                       MX6DL_PAD_SD3_DAT1__SD3_DATA1 0x170B9
> +                                                       MX6DL_PAD_SD3_DAT2__SD3_DATA2 0x170B9
> +                                                       MX6DL_PAD_SD3_DAT3__SD3_DATA3 0x170B9
> +                                                       MX6DL_PAD_SD3_DAT4__SD3_DATA4 0x170B9
> +                                                       MX6DL_PAD_SD3_DAT5__SD3_DATA5 0x170B9
> +                                                       MX6DL_PAD_SD3_DAT6__SD3_DATA6 0x170B9
> +                                                       MX6DL_PAD_SD3_DAT7__SD3_DATA7 0x170B9
> +                                                       MX6DL_PAD_GPIO_18__SD3_VSELECT 0x17059
> +                                               >;
> +                                       };

No please.

in pinctrl_usdhc3_x 'x' is the mux option. Lets do not degrade this to
an arbitrary number. We should use prefixes like '4bit', '100mhz' or
combinations thereof for further options.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
