From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 04 Jul 2017 10:35:44 +0200
Subject: [PATCH 4/6] ARM: dts: rockchip: enable eMMC for rk3229-evb
In-Reply-To: <1499155967-26090-5-git-send-email-frank.wang@rock-chips.com>
References: <1499155967-26090-1-git-send-email-frank.wang@rock-chips.com>
 <1499155967-26090-5-git-send-email-frank.wang@rock-chips.com>
Message-ID: <4792016.SK4QvSrg4n@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 4. Juli 2017, 16:12:45 CEST schrieb Frank Wang:
> This patch enables eMMC support for rk3229-evb board.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk3229-evb.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3229-evb.dts
> b/arch/arm/boot/dts/rk3229-evb.dts index b64f86c..bae0dbf 100644
> --- a/arch/arm/boot/dts/rk3229-evb.dts
> +++ b/arch/arm/boot/dts/rk3229-evb.dts
> @@ -130,6 +130,17 @@
>  	cpu-supply = <&vdd_arm>;
>  };
> 
> +&emmc {
> +	broken-cd;
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	supports-emmc;
> +	disable-wp;
> +	non-removable;

non-removable should be enough, so you shouldn't need the broken-cd above?

> +	num-slots = <1>;
> +	status = "okay";
> +};
> +
>  &gmac {
>  	assigned-clocks = <&cru SCLK_MAC_EXTCLK>, <&cru SCLK_MAC>;
>  	assigned-clock-parents = <&ext_gmac>, <&cru SCLK_MAC_EXTCLK>;
