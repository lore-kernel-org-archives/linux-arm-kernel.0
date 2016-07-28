From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 28 Jul 2016 15:01:12 +0200
Subject: [PATCH 17/18] ARM: mvebu: a390-db: add support for the Armada 390
 DB board
In-Reply-To: <1469105055-25181-19-git-send-email-jaz@semihalf.com> (Grzegorz
 Jaszczyk's message of "Thu, 21 Jul 2016 14:44:14 +0200")
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
 <1469105055-25181-19-git-send-email-jaz@semihalf.com>
Message-ID: <87lh0lkjc7.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grzegorz,
 
 On jeu., juil. 21 2016, Grzegorz Jaszczyk <jaz@semihalf.com> wrote:

Change the prefix to "ARM: dts: mvebu: armada-390-db:"

> This commit adds description for following features for this board:
>
> - Serial port
> - I2C buses
> - 16MB SPI-NOR
> - USB2.0
> - USB3.0
> - PCIe interfaces
>
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> ---
>  arch/arm/boot/dts/armada-390-db.dts | 164 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-390-db.dts
>
[...]

> +
> +			i2c at 11000 {

It would be interesting to know if there is something connected on this
bus.

> +				status = "okay";
> +				clock-frequency = <100000>;
> +			};
> +
> +			serial at 12000 {

It would be nice to indicate the name of the connector on the board.

> +				status = "okay";
> +			};
> +
> +			usb at 58000 {
Here to

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
> +				nand-ecc-strength = <8>;
> +				nand-ecc-step-size = <512>;
> +
> +				partitions {
> +					compatible = "fixed-partitions";
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +
> +					partition at 0 {
> +						label = "U-Boot";
> +						reg = <0 0x800000>;
> +					};
> +					partition at 800000 {
> +						label = "Linux";
> +						reg = <0x800000 0x800000>;
> +					};
> +					partition at 1000000 {
> +						label = "Filesystem";
> +						reg = <0x1000000 0x3f000000>;
> +					};
> +				};
> +			};
> +
> +			usb3 at f8000 {

Ditto

> +				status = "okay";
> +			};
> +		};
> +
> +		pcie-controller {
> +			status = "okay";
> +
And the same for the following PCIe ports.

> +			pcie at 1,0 {
> +				status = "okay";
> +			};
> +
> +			pcie at 2,0 {
> +				status = "okay";
> +			};
> +
> +			pcie at 3,0 {
> +				status = "okay";
> +			};
> +		};
> +	};
> +};

Then you can add my

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


> -- 
> 1.8.3.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
