From: mporter@ti.com (Matt Porter)
Date: Wed, 27 Mar 2013 09:32:42 -0400
Subject: [PATCH 5/5] ARM: dts: AM33XX: Add default pinctrl binding for
 UART0 device
In-Reply-To: <896a1261daec485db6be66630bc4019a@DFLE51.ent.ti.com>
References: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
 <896a1261daec485db6be66630bc4019a@DFLE51.ent.ti.com>
Message-ID: <20130327133242.GJ18335@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 12:59:16PM +0000, Vaibhav Hiremath wrote:
> Add pin control binding for UART0 device nodes in all
> board specific DT files.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>

Except for trivial comments below I'll add my

Acked-by: Matt Porter <mporter@ti.com>

> ---
>  arch/arm/boot/dts/am335x-bone.dts  |   10 ++++++++++
>  arch/arm/boot/dts/am335x-evm.dts   |   10 ++++++++++
>  arch/arm/boot/dts/am335x-evmsk.dts |   10 ++++++++++
>  3 files changed, 30 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index 1d623e4..3c4c66f 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -43,10 +43,20 @@
>  				0x18c 0x30	/* i2c0_scl.i2c0_scl PULLUP | INPUTENABLE | MODE0 */
>  			>;
>  		};
> +
> +		uart0_pins: pinmux_uart0_pins {
> +			pinctrl-single,pins = <
> +				0x170 0x30	/* uart0_rxd.uart0_rxd PULLUP | INPUTENABLE | MODE0 */
> +				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN | MODE0 */
> +			>;
> +		};
>  	};
>  
>  	ocp {
>  		uart1: serial at 44e09000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart0_pins>;
> +

Please change this to be uart0 so it all matches.

>  			status = "okay";
>  		};
>  
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index 79b3cc8..89e1edd 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -58,10 +58,20 @@
>  				0x15c 0x32	/* spi0_cs0.i2c1_scl PULLUP | INPUTENABLE | MODE2 */
>  			>;
>  		};
> +
> +		uart0_pins: pinmux_uart0_pins {
> +			pinctrl-single,pins = <
> +				0x170 0x30	/* uart0_rxd.uart0_rxd PULLUP | INPUTENABLE | MODE0 */
> +				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN | MODE0 */
> +			>;
> +		};
>  	};
>  
>  	ocp {
>  		uart1: serial at 44e09000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart0_pins>;
> +

Also here.

>  			status = "okay";
>  		};
>  
> diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
> index 21d5a08..0e7f1b8 100644
> --- a/arch/arm/boot/dts/am335x-evmsk.dts
> +++ b/arch/arm/boot/dts/am335x-evmsk.dts
> @@ -58,10 +58,20 @@
>  				0x18c 0x30	/* i2c0_scl.i2c0_scl PULLUP | INPUTENABLE | MODE0 */
>  			>;
>  		};
> +
> +		uart0_pins: pinmux_uart0_pins {
> +			pinctrl-single,pins = <
> +				0x170 0x30	/* uart0_rxd.uart0_rxd PULLUP | INPUTENABLE | MODE0 */
> +				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN | MODE0 */
> +			>;
> +		};
>  	};
>  
>  	ocp {
>  		uart1: serial at 44e09000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart0_pins>;
> +
>  			status = "okay";
>  		};

And here.

-Matt
