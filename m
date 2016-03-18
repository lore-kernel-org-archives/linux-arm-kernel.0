From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 18 Mar 2016 22:34:07 +0100
Subject: [PATCH] ARM: dts: rockchip: Add mdio node to ethernet node
In-Reply-To: <1458300056-6174-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1458300056-6174-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <56EC744F.90308@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 18.03.2016 um 12:20 schrieb Tomeu Vizoso:
> So the dwmac device manages to probe again.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Fixes: 88f8b1bb41c6 ("stmmac: Fix 'eth0: No PHY found' regression")
> ---
>  arch/arm/boot/dts/rk3288-rock2-som.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-rock2-som.dtsi b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
> index 1ece66f3e162..4ba7ddecb478 100644
> --- a/arch/arm/boot/dts/rk3288-rock2-som.dtsi
> +++ b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
> @@ -101,6 +101,14 @@
>  	snps,reset-delays-us = <0 10000 30000>;
>  	rx_delay = <0x10>;
>  	tx_delay = <0x30>;
> +	mdio0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +		ethphy1: ethernet-phy at 1 {
> +			reg = <1>;
> +		};
> +	};

This is a) ugly for lack of white lines in between, b) unnecessary since
this is being fixed in the stmmac driver where it will benefit more than
just this one SoM.

Regards,
Andreas

>  };
>  
>  &i2c0 {

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
