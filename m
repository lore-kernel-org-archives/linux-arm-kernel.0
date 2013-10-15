From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 15 Oct 2013 13:08:15 +0200
Subject: [PATCH 4/5] ARM: rockchip: add support for rk3188 and Radxa Rock
 board
In-Reply-To: <201310151301.02290.heiko@sntech.de>
References: <201310151258.53435.heiko@sntech.de>
 <201310151301.02290.heiko@sntech.de>
Message-ID: <201310151308.15489.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 15. Oktober 2013, 13:01:02 schrieb Heiko St?bner:
> Basic devicetree files for the rk3188 SoC. Also provided is a board
> dts file for the upcoming Radxa Rock board using this SoC.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[...]

> +		pinctrl at 20008000 {
> +			compatible = "rockchip,rk3188-pinctrl";
> +			reg = <0x20008000 0xa0>,
> +			      <0x20008164 0x1a0>;
> +			reg-names = "base", "pull";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			gpio0: gpio0 at 0x2000a000 {
> +				compatible = "rockchip,rk3188-gpio-bank0";
> +				reg = <0x2000a000 0x100>,
> +				      <0x20004064 0x8>;
> +				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk_gates8 9>;
> +
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};

Forgot to add, that this of course depends on the separate change to the 
bindings of the pinctrl driver being suitable.


Heiko
