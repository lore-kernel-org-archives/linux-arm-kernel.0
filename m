From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 8 Sep 2017 16:03:22 +0200
Subject: [PATCH net-next 1/3] dt-bindings: net: add DT bindings for
 Socionext UniPhier AVE
In-Reply-To: <1504875731-3680-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1504875731-3680-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1504875731-3680-2-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <20170908140322.GD25219@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	eth: ethernet at 65000000 {
> +		compatible = "socionext,uniphier-ave4";
> +		reg = <0x65000000 0x8500>;
> +		interrupts = <0 66 4>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_ether_rgmii>;
> +		phy-mode = "rgmii";
> +		socionext,desc-bits = <64>;
> +		local-mac-address = [00 00 00 00 00 00];
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;

> +		ethphy: ethphy at 1 {
> +			reg = <1>;
> +		};


So you normally have an mdio node, and the phy as a children of that
node.

       mdio {
                ethphy: ethernet-phy at 6 {
                        reg = <6>;
                };
        };

	Andrew
