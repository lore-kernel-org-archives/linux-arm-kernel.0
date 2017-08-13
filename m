From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 13 Aug 2017 14:16:24 +0200
Subject: [PATCH v3 13/13] ARM: dts: rockchip: add accelerometer bma250e dt
 node for rv1108 evb
In-Reply-To: <1502423358-31375-1-git-send-email-andy.yan@rock-chips.com>
References: <1502422578-30611-1-git-send-email-andy.yan@rock-chips.com>
 <1502423358-31375-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <3261055.FbxHzKYeRb@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 11. August 2017, 11:49:18 CEST schrieb Andy Yan:
> Add dt node of bosch accelerometer bma250e on rv1108 evb.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm/boot/dts/rv1108-evb.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rv1108-evb.dts b/arch/arm/boot/dts/rv1108-evb.dts
> index a1bd95e..6690083 100644
> --- a/arch/arm/boot/dts/rv1108-evb.dts
> +++ b/arch/arm/boot/dts/rv1108-evb.dts
> @@ -110,6 +110,13 @@
>  	i2c-scl-falling-time-ns = <16>;
>  	clock-frequency = <400000>;
>  
> +	bma250: accelerometer at 19 {

please order such things by address,
foo at 19 should come after bar at 18 of course


Thanks
Heiko

> +		compatible = "bosch,bma250e";
> +		reg = <0x19>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PB3 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
>  	rk805: pmic at 18 {
>  		compatible = "rockchip,rk805";
>  		reg = <0x18>;
> 
