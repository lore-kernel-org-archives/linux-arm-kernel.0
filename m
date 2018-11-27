From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 27 Nov 2018 01:28:59 +0100
Subject: [PATCH v2 4/4] ARM: dts: rockchip: Add internal timer support for
 rv1108
In-Reply-To: <20181126173506.24068-4-otavio@ossystems.com.br>
References: <20181126173506.24068-1-otavio@ossystems.com.br>
 <20181126173506.24068-4-otavio@ossystems.com.br>
Message-ID: <2433008.lBIgasatsU@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 26. November 2018, 18:35:06 CET schrieb Otavio Salvador:
> Add support for the internal timer peripheral on RV1108.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> ---

looks good, but due to the newly added compatible
I'll let this sit a bit longer to give Rob a chance to add a
Review-tag or so.


Heiko


> 
> Changes in v2:
> - add binding to doc
> - fixup commit log
> 
>  .../devicetree/bindings/timer/rockchip,rk-timer.txt       | 1 +
>  arch/arm/boot/dts/rv1108.dtsi                             | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
> index 16a5f4577a61..d65fdce7c7f0 100644
> --- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
> @@ -2,6 +2,7 @@ Rockchip rk timer
>  
>  Required properties:
>  - compatible: should be:
> +  "rockchip,rv1108-timer", "rockchip,rk3288-timer": for Rockchip RV1108
>    "rockchip,rk3036-timer", "rockchip,rk3288-timer": for Rockchip RK3036
>    "rockchip,rk3066-timer", "rockchip,rk3288-timer": for Rockchip RK3066
>    "rockchip,rk3188-timer", "rockchip,rk3288-timer": for Rockchip RK3188
> diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
> index 23ac4b10d690..9683f3b00d9d 100644
> --- a/arch/arm/boot/dts/rv1108.dtsi
> +++ b/arch/arm/boot/dts/rv1108.dtsi
> @@ -293,6 +293,14 @@
>  		};
>  	};
>  
> +	timer: timer at 10350000 {
> +		compatible = "rockchip,rv1108-timer", "rockchip,rk3288-timer";
> +		reg = <0x10350000 0x20>;
> +		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&xin24m>, <&cru PCLK_TIMER>;
> +		clock-names = "timer", "pclk";
> +	};
> +
>  	watchdog: wdt at 10360000 {
>  		compatible = "snps,dw-wdt";
>  		reg = <0x10360000 0x100>;
> 
