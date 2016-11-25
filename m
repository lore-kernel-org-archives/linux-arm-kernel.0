From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 25 Nov 2016 17:16:38 +0100
Subject: [PATCH v5 2/2] ARM: dts: add support for Turris Omnia
In-Reply-To: <20161125142658.21690-3-uwe@kleine-koenig.org> ("Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Fri, 25 Nov 2016 15:26:58
 +0100")
References: <20161125142658.21690-1-uwe@kleine-koenig.org>
 <20161125142658.21690-3-uwe@kleine-koenig.org>
Message-ID: <87lgw7ilg9.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,
 
 On ven., nov. 25 2016, Uwe Kleine-K?nig <uwe@kleine-koenig.org> wrote:

> This machine is an open hardware router by cz.nic driven by a
> Marvell Armada 385.
>
> Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>

Applied on mvebu/dt with few changes:

First I added the SoB from Thomas Hlavacek you initially planed to add
as seen on IRC.

The other change I did are mentioned inline.

Thanks,

Gregory


[...]

> +&spi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi0_pins &spi0cs0_pins>;
> +	status = "okay";
> +
> +	spi-nor at 0 {
> +		compatible = "spansion,s25fl164k", "jedec,spi-nor";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0>;
> +		spi-max-frequency = <40000000>;
> +

+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
it is mandatory since v4.4 to use this pattern for partitions.


> +		partition at 0 {
> +			reg = <0x0 0x00100000>;
> +			label = "U-Boot";
> +		};
> +
> +		partition at 1 {
                         @0x100000
We should use the reg value here ^

> +			reg = <0x00100000 0x00700000>;
> +			label = "Rescue system";
> +		};

+ };


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
