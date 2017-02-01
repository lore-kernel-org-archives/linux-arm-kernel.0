From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 01 Feb 2017 10:43:12 +0100
Subject: [PATCH v6 4/5] ARM: dts: rockchip: add timer entries to rk3188 SoC
In-Reply-To: <1485866596-32254-5-git-send-email-al.kochet@gmail.com>
References: <1485866596-32254-1-git-send-email-al.kochet@gmail.com>
 <1485866596-32254-5-git-send-email-al.kochet@gmail.com>
Message-ID: <1522448.qizf3bPadS@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 31. Januar 2017, 15:43:15 CET schrieb Alexander Kochetkov:
> The patch add two timers to all rk3188 based boards.
> 
> The first timer is from alive subsystem and it act as a backup
> for the local timers at sleep time. It act the same as other
> SoC rockchip timers already present in kernel.
> 
> The second timer is from CPU subsystem and act as replacement
> for the arm-global-timer clocksource and sched clock. It run
> at stable frequency 24MHz.
> 
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---
>  arch/arm/boot/dts/rk3188.dtsi |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
> index 31f81b2..0dc52fe 100644
> --- a/arch/arm/boot/dts/rk3188.dtsi
> +++ b/arch/arm/boot/dts/rk3188.dtsi
> @@ -106,6 +106,22 @@
>  		};
>  	};
> 
> +	timer3: timer at 2000e000 {
> +		compatible = "rockchip,rk3188-timer", "rockchip,rk3288-timer";
> +		reg = <0x2000e000 0x20>;
> +		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru SCLK_TIMER3>, <&cru PCLK_TIMER3>;
> +		clock-names = "timer", "pclk";
> +	};
> +
> +	timer6: timer at 200380a0 {
> +		compatible = "rockchip,rk3188-timer", "rockchip,rk3288-timer";
> +		reg = <0x200380a0 0x20>;
> +		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru SCLK_TIMER6>, <&cru PCLK_TIMER0>;
> +		clock-names = "timer", "pclk";
> +	};
> +

depending on who is picking that up, they can add my
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

if needed.

I've also double checked the timer clocks - especially the pclks.
Timer3 has its own separate pclk, while all other timers are supplied by 
pclk_timer0.


Heiko
