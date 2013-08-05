From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 05 Aug 2013 15:25:21 +0200
Subject: [PATCHv1] arm: armada: Add .dts file for Netgear ReadyNAS 102
In-Reply-To: <878v1mgh4x.fsf@natisbad.org>
References: <878v1mgh4x.fsf@natisbad.org>
Message-ID: <51FFA7C1.1050103@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2013 23:16, Arnaud Ebalard wrote:
> 
> All hardware parts of the (Armada 370 based) NETGEAR ReadyNAS 102 are
> supported by mainline kernel (USB 3.0 rear ports, USB 2.0 front port,
> Gigabit controller and PHY, serial port, leds, buttons, SATA ports,
> G762 fan controller) except for:
> 
>  - the Intersil ISL12057 I2C RTC Chip,
>  - the Armada NAND controller.
> 
> Support for both of those is currently work in progress and does not
> prevent boot.

If it is not too late you can add my

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Just a nitpick:

For a better coherency in your file you could add an extra line before
each sub-node as you have done for all the other nodes:

> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
Here
> +		button at 1 {
> +			label = "Power Button";
> +			linux,code = <116>;     /* KEY_POWER */
> +			gpios = <&gpio1 30 1>;
> +		};
Here
> +		button at 2 {
> +			label = "Reset Button";
> +			linux,code = <0x198>;   /* KEY_RESTART */
> +			gpios = <&gpio0 6 1>;
> +		};
and here
> +		button at 3 {
> +			label = "Backup Button";
> +			linux,code = <133>;     /* KEY_COPY */
> +			gpios = <&gpio1 26 1>;
> +		};
> +	};
> +
> +};
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
