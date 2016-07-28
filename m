From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 28 Jul 2016 15:15:46 +0200
Subject: [PATCH 18/18] ARM: mvebu: a395-gp: add support for the Armada 395
 GP Board
In-Reply-To: <1469105055-25181-20-git-send-email-jaz@semihalf.com> (Grzegorz
 Jaszczyk's message of "Thu, 21 Jul 2016 14:44:15 +0200")
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
 <1469105055-25181-20-git-send-email-jaz@semihalf.com>
Message-ID: <87h9b9kinx.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grzegorz,
 
 On jeu., juil. 21 2016, Grzegorz Jaszczyk <jaz@semihalf.com> wrote:

Change the prefix to "ARM: dts: mvebu: armada-395-gp:"

> This commit adds description for the following features for this board:
>
> - Serial port
> - PCIe interfaces
> - USB2.0
> - USB3.0
> - SDIO
> - 1024 MiB NAND-FLASH
> - SATA
> - I2C buses
>
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
[...]

As for the other board, try to add information about the connector used:

> +			serial at 12000 {
Here,

> +				status = "okay";
> +			};
> +
> +			usb at 58000 {
here
> +				status = "okay";
> +			};
> +
> +			sata at a8000 {
here
> +				status = "okay";
> +			};
> +
> +			flash at d0000 {
> +				status = "okay";
> +				pinctrl-0 = <&nand_pins>;
> +				pinctrl-names = "default";
> +				num-cs = <1>;
> +				marvell,nand-keep-config;
> +				marvell,nand-enable-arbiter;
> +				nand-on-flash-bbt;
> +				nand-ecc-strength = <4>;
> +				nand-ecc-step-size = <512>;
> +
> +				partitions {
> +					compatible = "fixed-partitions";
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +
> +					partition at 0 {
> +						label = "U-Boot";
> +						reg = <0x00000000 0x00600000>;
> +						read-only;
> +					};
> +
> +					partition at 800000 {
> +						label = "uImage";
> +						reg = <0x00600000 0x00400000>;
> +						read-only;
> +					};
> +
> +					partition at 1000000 {
> +						label = "Root";
> +						reg = <0x00a00000 0x3f600000>;
> +					};
> +				};
> +			};
> +
> +			sdhci at d8000 {
here
> +				clock-frequency = <200000000>;
> +				broken-cd;
> +				wp-inverted;
> +				bus-width = <8>;
> +				status = "okay";
> +				no-1-8-v;
> +			};
> +
> +			usb3 at f0000 {
here
> +				status = "okay";
> +			};
> +		};
> +
> +		pcie-controller {
> +			status = "okay";
> +
> +			/*
> +			 * The two PCIe units are accessible through
> +			 * mini PCIe slot on the board.
> +			 */
and here for each slot
> +			pcie at 2,0 {
> +				/* Port 1, Lane 0 */
> +				status = "okay";
> +			};
> +
> +			pcie at 4,0 {
> +				/* Port 3, Lane 0 */
> +				status = "okay";
> +			};
> +		};
> +	};
> +};

then you can add my:
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
