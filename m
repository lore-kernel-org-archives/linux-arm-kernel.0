From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 24 Feb 2014 20:31:33 +0100
Subject: [PATCHv3 4/9] ARM: at91: dt: sam9rl: Device Tree for the
 at91sam9rlek
In-Reply-To: <1393012138-17255-5-git-send-email-alexandre.belloni@free-electrons.com>
References: <1393012138-17255-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1393012138-17255-5-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140224193132.GF4436@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 21/02/2014 at 20:48:53 +0100, Alexandre Belloni wrote :
> +	ahb {
> +		apb {
> +			mmc0: mmc at fffa4000 {
> +				pinctrl-0 = <
> +					&pinctrl_board_mmc0
> +					&pinctrl_mmc0_clk
> +					&pinctrl_mmc0_slot0_cmd_dat0
> +					&pinctrl_mmc0_slot0_dat1_3>;
> +				status = "okay";
> +				slot at 0 {
> +					reg = <0>;
> +					bus-width = <4>;
> +					cd-gpios = <&pioA 15 GPIO_ACTIVE_HIGH>;
> +				};
> +			};
> +
> +			usart0: serial at fffb0000 {
> +				pinctrl-0 = <
> +					&pinctrl_usart0
> +					&pinctrl_usart0_rts
> +					&pinctrl_usart0_cts>;
> +				status = "okay";
> +			};
> +
> +			dbgu: serial at fffff200 {
> +				status = "okay";
> +			};
> +
> +			pinctrl at fffff400 {
> +				mmc0 {
> +					pinctrl_board_mmc0: mmc0-board {
> +						atmel,pins =
> +							<AT91_PIOA 15 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
> +					};
> +				};
> +			};
> +
> +			watchdog at fffffd40 {
> +				status = "okay";
> +			};
> +		};
> +

I just realised, do you want me to actually put the nand before the apb ?

> +		nand0: nand at 40000000 {
> +			nand-bus-width = <8>;
> +			nand-ecc-mode = "soft";
> +			nand-on-flash-bbt = <1>;
> +			status = "okay";
> +
> +			at91bootstrap at 0 {
> +				label = "at91bootstrap";
> +				reg = <0x0 0x40000>;
> +			};
> +
> +			bootloader at 40000 {
> +				label = "bootloader";
> +				reg = <0x40000 0x80000>;
> +			};
> +
> +			bootloaderenv at c0000 {
> +				label = "bootloader env";
> +				reg = <0xc0000 0xc0000>;
> +			};
> +
> +			dtb at 180000 {
> +				label = "device tree";
> +				reg = <0x180000 0x80000>;
> +			};
> +
> +			kernel at 200000 {
> +				label = "kernel";
> +				reg = <0x200000 0x600000>;
> +			};
> +
> +			rootfs at 800000 {
> +				label = "rootfs";
> +				reg = <0x800000 0x0f800000>;
> +			};
> +		};
> +	};
> +

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
