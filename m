From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 6 Jul 2012 13:51:58 +0200
Subject: [PATCH] arm: at91: Add new board
In-Reply-To: <1341385499-5781-1-git-send-email-jiri.prchal@aksignal.cz>
References: <1341385499-5781-1-git-send-email-jiri.prchal@aksignal.cz>
Message-ID: <20120706115158.GB4450@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

	please put a correct title of the commit

On 09:04 Wed 04 Jul     , Jiri Prchal wrote:
> I'd like to add support for our "CDU" board based up on Telit's module GE863 Pro3.
> It has more uarts, leds, another nand partitioning.
> 
> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> ---
>  arch/arm/boot/dts/aks-cdu.dts |  111 +++++++++++++++++++++++++++++++++++++++++
plewase update thei

arch/arm/mach-at91/Makefile.boot

Best Regards,
J.
>  1 files changed, 111 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/aks-cdu.dts
> 
> diff --git a/arch/arm/boot/dts/aks-cdu.dts b/arch/arm/boot/dts/aks-cdu.dts
> new file mode 100644
> index 0000000..05590cc
> --- /dev/null
> +++ b/arch/arm/boot/dts/aks-cdu.dts
> @@ -0,0 +1,111 @@
> +/*
> + * aks-cdu.dts - Device Tree file for AK signal CDU
> + *
> + * Copyright (C) 2012 AK signal Brno a.s.
> + *               2012 Jiri Prchal <jiri.prchal@aksignal.cz>
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +/include/ "ge863-pro3.dtsi"
> +
> +/ {
> +	chosen {
> +		bootargs = "console=ttyS0,115200 ubi.mtd=4 root=ubi0:rootfs rootfstype=ubifs";
> +	};
> +
> +	ahb {
> +		apb {
> +			usart0: serial at fffb0000 {
> +				status = "okay";
> +			};
> +
> +			usart1: serial at fffb4000 {
> +				status = "okay";
> +				linux,rs485-enabled-at-boot-time;
> +				rs485-rts-delay = <0 0>;
> +				};
> +
> +			usart2: serial at fffb8000 {
> +				status = "okay";
> +				linux,rs485-enabled-at-boot-time;
> +				rs485-rts-delay = <0 0>;
> +			};
> +
> +			usart3: serial at fffd0000 {
> +				status = "okay";
> +				linux,rs485-enabled-at-boot-time;
> +				rs485-rts-delay = <0 0>;
> +			};
> +
> +			macb0: ethernet at fffbc000 {
> +				phy-mode = "rmii";
> +				status = "okay";
> +			};
> +
> +			usb1: gadget at fffa4000 {
> +				atmel,vbus-gpio = <&pioC 15 0>;
> +				status = "okay";
> +			};
> +		};
> +
> +		usb0: ohci at 00500000 {
> +			num-ports = <2>;
> +			status = "okay";
> +		};
> +
> +		nand0: nand at 40000000 {
> +			nand-bus-width = <8>;
> +			nand-ecc-mode = "soft";
> +			nand-on-flash-bbt;
> +			status = "okay";
> +
> +			bootstrap at 0 {
> +				label = "bootstrap";
> +				reg = <0x0 0x40000>;
> +			};
> +
> +			uboot at 40000 {
> +				label = "uboot";
> +				reg = <0x40000 0x80000>;
> +			};
> +			ubootenv at c0000 {
> +				label = "ubootenv";
> +				reg = <0xc0000 0x40000>;
> +			};
> +			kernel at 100000 {
> +				label = "kernel";
> +				reg = <0x100000 0x400000>;
> +			};
> +			rootfs at 500000 {
> +				label = "rootfs";
> +				reg = <0x500000 0x7b00000>;
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		red {
> +			gpios = <&pioC 10 0>;
> +			linux,default-trigger = "none";
> +		};
> +
> +		green {
> +			gpios = <&pioA 5 1>;
> +			linux,default-trigger = "none";
> +			default-state = "on";
> +		};
> +
> +		yellow {
> +			gpios = <&pioB 20 1>;
> +			linux,default-trigger = "none";
> +		};
> +
> +		blue {
> +			gpios = <&pioB 21 1>;
> +			linux,default-trigger = "none";
> +		};
> +	};
> +};
> -- 
> 1.7.7
> 
