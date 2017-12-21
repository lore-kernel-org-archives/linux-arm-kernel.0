From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 21 Dec 2017 12:32:54 +0100
Subject: [PATCH net-next v7 1/2] dt-bindings: net: add DT bindings for
 Socionext UniPhier AVE
In-Reply-To: <1513854776-4149-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1513854776-4149-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1513854776-4149-2-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <20171221113254.GB9930@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +Optional properties:
> + - resets: A phandle to the reset control for the MAC
> + - local-mac-address: See ethernet.txt in the same directory.
> +
> +Required subnode:
> + - mdio: Device tree subnode with the following required properties:
> +
> +Example:

It sounds like there should be some properties before the Example.

   Andrew

> +
> +	ether: ethernet at 65000000 {
> +		compatible = "socionext,uniphier-ld20-ave4";
> +		reg = <0x65000000 0x8500>;
> +		interrupts = <0 66 4>;
> +		phy-mode = "rgmii";
> +		phy-handle = <&ethphy>;
> +		clocks = <&sys_clk 6>;
> +		resets = <&sys_rst 6>;
> +		local-mac-address = [00 00 00 00 00 00];

Typically you would put a blank line here, before the mdio node.

> +		mdio {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			ethphy: ethphy at 1 {
> +				reg = <1>;
> +			};
> +		};
> +	};

  Andrew
