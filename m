From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 22 Nov 2016 16:02:41 +0100
Subject: [PATCH 2/4] arm64: dts: rockchip: Arch counter doesn't tick in
 system suspend
In-Reply-To: <1479807866-6957-2-git-send-email-daniel.lezcano@linaro.org>
References: <20161122094300.GA2017@mai>
 <1479807866-6957-1-git-send-email-daniel.lezcano@linaro.org>
 <1479807866-6957-2-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <6410694.RN5yFFi4kR@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 22. November 2016, 10:44:22 schrieb Daniel Lezcano:
> From: Brian Norris <briannorris@chromium.org>
> 
> The "arm,no-tick-in-suspend" property was introduced to note
> implementations where the system counter does not quite follow the ARM
> specification that it "must be implemented in an always-on power
> domain".
> 
> Particularly, RK3399's counter stops ticking when we switch from the
> 24MHz clock to the 32KHz clock in low-power suspend, so let's mark it as
> such.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

not sure if needed, but anyway
Acked-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi index b65c193..d85b651 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -174,6 +174,7 @@
>  			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW 0>,
>  			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW 0>,
>  			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>;
> +		arm,no-tick-in-suspend;
>  	};
> 
>  	xin24m: xin24m {
