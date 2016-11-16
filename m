From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 16 Nov 2016 13:28:42 +0100
Subject: [PATCH 2/2] ARM: dts: rockchip: enable sdmmc for rk1108-evb
In-Reply-To: <1479024799-29198-2-git-send-email-jacob-chen@iotwrt.com>
References: <1479024799-29198-1-git-send-email-jacob-chen@iotwrt.com>
 <1479024799-29198-2-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <5071766.aON0S2k73p@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 13. November 2016, 16:13:19 CET schrieb Jacob Chen:
> From: Jacob Chen <jacob2.chen@rock-chips.com>
> 
> This patch add sdmmc support for rk1108-evb, now I can load the rootfs
> from sdmmc.
> 
> Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk1108-evb.dts | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk1108-evb.dts
> b/arch/arm/boot/dts/rk1108-evb.dts index 3956cff..cea26e5 100644
> --- a/arch/arm/boot/dts/rk1108-evb.dts
> +++ b/arch/arm/boot/dts/rk1108-evb.dts
> @@ -56,6 +56,18 @@
>  	};
>  };
> 
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	card-detect-delay = <200>;
> +	disable-wp;
> +	num-slots = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc_clk>, <&sdmmc_cmd>, <&sdmmc_cd>, <&sdmmc_bus4>;
> +	status = "okay";
> +};
> +
>  &uart0 {
>  	status = "okay";
>  };
> @@ -67,3 +79,12 @@
>  &uart2 {
>  	status = "okay";
>  };
> +
> +&pinctrl {
> +
> +	sdmmc {
> +		sdmmc_pwr: sdmmc-pwr {
> +			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_up_drv_4ma>;
> +		};

the above is unsued, and in general please use a fixed regulator as vmmc, as 
all other  Rockchip boards do already, so that the mmc core can handle it 
itself.


Thanks
Heiko
