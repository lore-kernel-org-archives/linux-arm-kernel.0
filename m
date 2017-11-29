From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 29 Nov 2017 17:07:32 +0100
Subject: [PATCH] ARM: dts: Add ethernet PHYs to the a bunch of Geminis
In-Reply-To: <20171129154442.16332-1-linus.walleij@linaro.org>
References: <20171129154442.16332-1-linus.walleij@linaro.org>
Message-ID: <20171129160732.GF24881@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	mdio0: ethernet-phy {
> +		compatible = "virtual,mdio-gpio";
> +		gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
> +			<&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		phy0: ethernet-phy at 0 {

Hi Linus

ethernet-phy at 1 since the reg is 1.

You seem to have them all wrong :-(

    Andrew
