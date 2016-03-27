From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 27 Mar 2016 23:24:59 +0200
Subject: [PATCH v4] ARM: dts: vf610-zii-dev: Add ZII development board.
In-Reply-To: <1459100733-21552-1-git-send-email-andrew@lunn.ch>
References: <1459100733-21552-1-git-send-email-andrew@lunn.ch>
Message-ID: <56F84FAB.6010005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2016 07:45 PM, Andrew Lunn wrote:
> From: Cory Tusar <cory.tusar@pid1solutions.com>
> 
> This commit adds support for Rev. B of a Zodiac Inflight Innovations
> development board, mainly intended for DSA and ARINC 429 development
> work.
> 
> Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Stefan Agner <stefan@agner.ch>

Hi!

just minor nit below.

[..]

> +&i2c2 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	tca9548 at 70 {

This should be pca9... , not tca9... :-)

> +		compatible = "nxp,pca9548";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x70>;
> +		reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
> +

[...]

> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart0>;
> +	status = "okay";
> +	dmas = <>;
> +	dma-names = "";

Why is this dma stuff here ?

> +};
> +

[...]

-- 
Best regards,
Marek Vasut
