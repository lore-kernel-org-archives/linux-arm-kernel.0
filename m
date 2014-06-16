From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 16 Jun 2014 13:22:50 +0200
Subject: [PATCH 1/2] ARM: dts: berlin: add I2C nodes for BG2Q
In-Reply-To: <1401780790-17830-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1401780790-17830-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401780790-17830-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <539ED38A.3010205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2014 09:33 AM, Antoine T?nart wrote:
> The Marvell Berlin BG2Q has 4 TWSI compatible with the Synopsys
> DesignWare I2C driver. Add the corresponding nodes.
>
> The pin-muxing setup is also done here, since there cannot be another
> muxing setup if I2C{0,1,2,3} are enabled.
>
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>

Applied to berlin/dt.

Thanks!

> ---
>   arch/arm/boot/dts/berlin2q.dtsi | 72 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 72 insertions(+)
>
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 635a16a64cb4..0624868e36e3 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -191,6 +191,32 @@
>   				};
>   			};
>
> +			i2c0: i2c at 1400 {
> +				compatible = "snps,designware-i2c";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x1400 0x100>;
> +				interrupt-parent = <&aic>;
> +				interrupts = <4>;
> +				clocks = <&chip CLKID_CFG>;
> +				pinctrl-0 = <&twsi0_pmux>;
> +				pinctrl-names = "default";
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c at 1800 {
> +				compatible = "snps,designware-i2c";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x1800 0x100>;
> +				interrupt-parent = <&aic>;
> +				interrupts = <5>;
> +				clocks = <&chip CLKID_CFG>;
> +				pinctrl-0 = <&twsi1_pmux>;
> +				pinctrl-names = "default";
> +				status = "disabled";
> +			};
> +
>   			timer0: timer at 2c00 {
>   				compatible = "snps,dw-apb-timer";
>   				reg = <0x2c00 0x14>;
> @@ -301,6 +327,16 @@
>   			reg = <0xea0000 0x400>, <0xdd0170 0x10>;
>   			clocks = <&refclk>;
>   			clock-names = "refclk";
> +
> +			twsi0_pmux: twsi0-pmux {
> +				groups = "G6";
> +				function = "twsi0";
> +			};
> +
> +			twsi1_pmux: twsi1-pmux {
> +				groups = "G7";
> +				function = "twsi1";
> +			};
>   		};
>
>   		apb at fc0000 {
> @@ -311,6 +347,32 @@
>   			ranges = <0 0xfc0000 0x10000>;
>   			interrupt-parent = <&sic>;
>
> +			i2c2: i2c at 7000 {
> +				compatible = "snps,designware-i2c";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x7000 0x100>;
> +				interrupt-parent = <&sic>;
> +				interrupts = <6>;
> +				clocks = <&refclk>;
> +				pinctrl-0 = <&twsi2_pmux>;
> +				pinctrl-names = "default";
> +				status = "disabled";
> +			};
> +
> +			i2c3: i2c at 8000 {
> +				compatible = "snps,designware-i2c";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x8000 0x100>;
> +				interrupt-parent = <&sic>;
> +				interrupts = <7>;
> +				clocks = <&refclk>;
> +				pinctrl-0 = <&twsi3_pmux>;
> +				pinctrl-names = "default";
> +				status = "disabled";
> +			};
> +
>   			uart0: uart at 9000 {
>   				compatible = "snps,dw-apb-uart";
>   				reg = <0x9000 0x100>;
> @@ -348,6 +410,16 @@
>   					groups = "GSM14";
>   					function = "uart1";
>   				};
> +
> +				twsi2_pmux: twsi2-pmux {
> +					groups = "GSM13";
> +					function = "twsi2";
> +				};
> +
> +				twsi3_pmux: twsi3-pmux {
> +					groups = "GSM14";
> +					function = "twsi3";
> +				};
>   			};
>
>   			sic: interrupt-controller at e000 {
>
