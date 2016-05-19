From: david.wu@rock-chips.com (David.Wu)
Date: Thu, 19 May 2016 16:09:13 +0800
Subject: [PATCH] arm64: dts: rockchip: add i2c nodes for rk3399
In-Reply-To: <1463429371-10950-1-git-send-email-dianders@chromium.org>
References: <1463429371-10950-1-git-send-email-dianders@chromium.org>
Message-ID: <466d93c8-e405-51d7-401d-3d7cbd8560cf@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

? 2016/5/17 4:09, Douglas Anderson ??:
> From: David Wu <david.wu@rock-chips.com>
>
> We've got 9 (count em!) i2c controllers on rk3399, some of which are in
> the PMU power domain and some of which are normal peripherals.  Add them
> all to the main rk3399 dtsi file so future patches can turn them on in
> the board dts files.
>
> Note: by default we try to set the i2c clock rate to 200 MHz so that we
> can achieve good i2c functional clock rates.  200 MHz gives us the
> ability to make very close to 100 kHz / 400 kHz / 1 MHz rates.  If
> boards want to tune clock rates further they can always override.
> Possibly boards could want to tune this if:
> - they wanted to save an infinitesimal amount of power and they knew
>   their i2c bus was slow anyway.  Since we gate the functional clock
>   when the i2c bus is not active, power savings would only be while i2c
>   transfers were happening and probably won't be very big anyway.
> - they wanted to eek out a bit more speed by carefully tuning the source
>   clock to make divisions work out perfectly, accounting for the rise /
>   fall time measured on an actual board.
>
> Note also that we still request 200 MHz for the PMU i2c busses even
> though we expect that we won't make that exactly (currently PPLL is 676
> MHz which gives us 169 MHz).

Yeah, this looks like you got all the right bits in the right places and 
didn't mess it up.
This patch is looking really good to me, thanks for doing it.

>
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> [dianders: wrote desc; put in assigned-clocks; reordered nodes]
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Note: this patch is based upon David Wu's patch series to add rk3399
> support to i2c-rk3x.c and shouldn't land until at least device tree
> bindings land.
>
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 144 +++++++++++++++++++++++++++++++
>  1 file changed, 144 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 46f325a143b0..753a91728b4c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -54,6 +54,15 @@
>  	#size-cells = <2>;
>
>  	aliases {
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +		i2c4 = &i2c4;
> +		i2c5 = &i2c5;
> +		i2c6 = &i2c6;
> +		i2c7 = &i2c7;
> +		i2c8 = &i2c8;
>  		serial0 = &uart0;
>  		serial1 = &uart1;
>  		serial2 = &uart2;
> @@ -272,6 +281,96 @@
>  		};
>  	};
>
> +	i2c1: i2c at ff110000 {
> +		compatible = "rockchip,rk3399-i2c";
> +		reg = <0x0 0xff110000 0x0 0x1000>;
> +		assigned-clocks = <&cru SCLK_I2C1>;
> +		assigned-clock-rates = <200000000>;
> +		clocks = <&cru SCLK_I2C1>, <&cru PCLK_I2C1>;
> +		clock-names = "i2c", "pclk";
> +		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&i2c1_xfer>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +
> +	i2c2: i2c at ff120000 {
> +		compatible = "rockchip,rk3399-i2c";
> +		reg = <0x0 0xff120000 0x0 0x1000>;
> +		assigned-clocks = <&cru SCLK_I2C2>;
> +		assigned-clock-rates = <200000000>;
> +		clocks = <&cru SCLK_I2C2>, <&cru PCLK_I2C2>;
> +		clock-names = "i2c", "pclk";
> +		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&i2c2_xfer>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +
> +	i2c3: i2c at ff130000 {
> +		compatible = "rockchip,rk3399-i2c";
> +		reg = <0x0 0xff130000 0x0 0x1000>;
> +		assigned-clocks = <&cru SCLK_I2C3>;
> +		assigned-clock-rates = <200000000>;
> +		clocks = <&cru SCLK_I2C3>, <&cru PCLK_I2C3>;
> +		clock-names = "i2c", "pclk";
> +		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&i2c3_xfer>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +
> +	i2c5: i2c at ff140000 {
> +		compatible = "rockchip,rk3399-i2c";
> +		reg = <0x0 0xff140000 0x0 0x1000>;
> +		assigned-clocks = <&cru SCLK_I2C5>;
> +		assigned-clock-rates = <200000000>;
> +		clocks = <&cru SCLK_I2C5>, <&cru PCLK_I2C5>;
> +		clock-names = "i2c", "pclk";
> +		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&i2c5_xfer>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +
> +	i2c6: i2c at ff150000 {
> +		compatible = "rockchip,rk3399-i2c";
> +		reg = <0x0 0xff150000 0x0 0x1000>;
> +		assigned-clocks = <&cru SCLK_I2C6>;
> +		assigned-clock-rates = <200000000>;
> +		clocks = <&cru SCLK_I2C6>, <&cru PCLK_I2C6>;
> +		clock-names = "i2c", "pclk";
> +		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&i2c6_xfer>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +
> +	i2c7: i2c at ff160000 {
> +		compatible = "rockchip,rk3399-i2c";
> +		reg = <0x0 0xff160000 0x0 0x1000>;
> +		assigned-clocks = <&cru SCLK_I2C7>;
> +		assigned-clock-rates = <200000000>;
> +		clocks = <&cru SCLK_I2C7>, <&cru PCLK_I2C7>;
> +		clock-names = "i2c", "pclk";
> +		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&i2c7_xfer>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +
>  	uart0: serial at ff180000 {
>  		compatible = "rockchip,rk3399-uart", "snps,dw-apb-uart";
>  		reg = <0x0 0xff180000 0x0 0x100>;
> @@ -420,6 +519,51 @@
>  		status = "disabled";
>  	};
>
> +	i2c0: i2c at ff3c0000 {
> +		compatible = "rockchip,rk3399-i2c";
> +		reg = <0x0 0xff3c0000 0x0 0x1000>;
> +		assigned-clocks = <&pmucru SCLK_I2C0_PMU>;
> +		assigned-clock-rates = <200000000>;
> +		clocks = <&pmucru SCLK_I2C0_PMU>, <&pmucru PCLK_I2C0_PMU>;
> +		clock-names = "i2c", "pclk";
> +		interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&i2c0_xfer>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +
> +	i2c4: i2c at ff3d0000 {
> +		compatible = "rockchip,rk3399-i2c";
> +		reg = <0x0 0xff3d0000 0x0 0x1000>;
> +		assigned-clocks = <&pmucru SCLK_I2C4_PMU>;
> +		assigned-clock-rates = <200000000>;
> +		clocks = <&pmucru SCLK_I2C4_PMU>, <&pmucru PCLK_I2C4_PMU>;
> +		clock-names = "i2c", "pclk";
> +		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&i2c4_xfer>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +
> +	i2c8: i2c at ff3e0000 {
> +		compatible = "rockchip,rk3399-i2c";
> +		reg = <0x0 0xff3e0000 0x0 0x1000>;
> +		assigned-clocks = <&pmucru SCLK_I2C8_PMU>;
> +		assigned-clock-rates = <200000000>;
> +		clocks = <&pmucru SCLK_I2C8_PMU>, <&pmucru PCLK_I2C8_PMU>;
> +		clock-names = "i2c", "pclk";
> +		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&i2c8_xfer>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +
>  	pwm0: pwm at ff420000 {
>  		compatible = "rockchip,rk3399-pwm", "rockchip,rk3288-pwm";
>  		reg = <0x0 0xff420000 0x0 0x10>;
>
