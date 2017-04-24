From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 25 Apr 2017 00:08:42 +0200
Subject: [PATCH 2/2] ARM: dts: Add the ethernet and ethernet PHY to the
 cygnus core DT.
In-Reply-To: <20170424215022.30382-3-eric@anholt.net>
References: <20170424215022.30382-1-eric@anholt.net>
 <20170424215022.30382-3-eric@anholt.net>
Message-ID: <20170424220842.GA26241@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +		mdio: mdio at 18002000 {
> +			compatible = "brcm,iproc-mdio";
> +			reg = <0x18002000 0x8>;
> +			#size-cells = <1>;
> +			#address-cells = <0>;
> +
> +			gphy0: eth-gphy at 0 {
> +				reg = <0>;
> +				max-speed = <1000>;
> +			};
> +
> +			gphy1: eth-gphy at 1 {
> +				reg = <1>;
> +				max-speed = <1000>;
> +			};
> +		};

Hi Eric

Do these max-speed properties do anything useful? Is the PHY capable
of > 1Gbps?

   Thanks
	Andrew
