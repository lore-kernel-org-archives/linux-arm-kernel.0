From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 5 Nov 2016 22:04:41 +0100
Subject: [PATCH RFC] ARM: dts: add support for Turris Omnia
In-Reply-To: <20161105203841.9661-1-uwe@kleine-koenig.org>
References: <20161105203841.9661-1-uwe@kleine-koenig.org>
Message-ID: <20161105210441.GB1216@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +&mdio {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mdio_pins>;
> +	status = "okay";
> +
> +	phy1: phy at 1 {
> +		status = "okay";
> +		compatible = "marvell,88E1514", "marvell,88E1510", "ethernet-phy-ieee802.3-c22";
> +		reg = <1>;
> +	};

phy.txt says:

- compatible: Compatible list, may contain
  "ethernet-phy-ieee802.3-c22" or "ethernet-phy-ieee802.3-c45" for
  PHYs that implement IEEE802.3 clause 22 or IEEE802.3 clause 45
  specifications. If neither of these are specified, the default is to
  assume clause 22.

  If the phy's identifier is known then the list may contain an entry
  of the form: "ethernet-phy-idAAAA.BBBB" where
     AAAA - The value of the 16 bit Phy Identifier 1 register as
            4 hex digits. This is the chip vendor OUI bits 3:18
     BBBB - The value of the 16 bit Phy Identifier 2 register as
            4 hex digits. This is the chip vendor OUI bits 19:24,
            followed by 10 bits of a vendor specific ID.

  The compatible list should not contain other values than those
  listed here.

Please don't list the "marvell,*" names.

       Andrew
