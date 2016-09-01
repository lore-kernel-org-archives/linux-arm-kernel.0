From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 01 Sep 2016 13:41:42 +0200
Subject: [PATCH v3 3/5] arm64: dts: rockchip: add the gmac power domain on
 rk3399
In-Reply-To: <1472686132-27827-4-git-send-email-wxt@rock-chips.com>
References: <1472686132-27827-1-git-send-email-wxt@rock-chips.com>
 <1472686132-27827-4-git-send-email-wxt@rock-chips.com>
Message-ID: <2409903.3qiu7FpA8p@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Donnerstag, 1. September 2016, 07:28:50 schrieb Caesar Wang:
> This patch supports the gmac pd to save power consumption.
> Even though some boards not need Ethernet support, the driver
> core can also take care of powering up the pd before probe.
> 
> Signed-off-by: Roger Chen <roger.chen@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

who is the author of this patch? Roger or you? Because we should either drop 
Roger's Signed-off or fix the authorship to list him.


Heiko

> ---
> 
> Changes in v3:
> - leave into two patches based on patchv2, and fix nits and commit, as
>   comment on https://patchwork.kernel.org/patch/9306339/
> 
> Changes in v2:
> - Fixes the order, ss Heiko commnets on
>   https://patchwork.kernel.org/patch/9305991/
> 
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi index 32aebc8..2ab233f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -611,6 +611,11 @@
>  		status = "disabled";
>  	};
> 
> +	qos_gmac: qos at ffa5c000 {
> +		compatible = "syscon";
> +		reg = <0x0 0xffa5c000 0x0 0x20>;
> +	};
> +
>  	qos_hdcp: qos at ffa90000 {
>  		compatible = "syscon";
>  		reg = <0x0 0xffa90000 0x0 0x20>;
> @@ -739,6 +744,11 @@
>  			};
> 
>  			/* These power domains are grouped by VD_LOGIC */
> +			pd_gmac at RK3399_PD_GMAC {
> +				reg = <RK3399_PD_GMAC>;
> +				clocks = <&cru ACLK_GMAC>;
> +				pm_qos = <&qos_gmac>;
> +			};
>  			pd_vio at RK3399_PD_VIO {
>  				reg = <RK3399_PD_VIO>;
>  				#address-cells = <1>;
