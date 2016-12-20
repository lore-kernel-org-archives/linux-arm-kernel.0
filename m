From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 20 Dec 2016 16:42:34 +0100
Subject: [PATCH v2 3/3] arm64: dts: marvell: Add ethernet switch
 definition for the ESPRESSObin
In-Reply-To: <20161220085138.3998-4-romain.perier@free-electrons.com>
References: <20161220085138.3998-1-romain.perier@free-electrons.com>
 <20161220085138.3998-4-romain.perier@free-electrons.com>
Message-ID: <20161220154234.GC30952@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +&mdio {
> +	switch0: switch0 at 0 {
> +		compatible = "marvell,mv88e6085";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <1>;

Ah, sorry, missed this last time. reg = <1>, that means switch0 at 1.
That is a general rule for all device tree bindings.

> +		mdio {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;

what is this reg value for?

     Andrew
