From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 27 Sep 2017 16:02:10 +0200
Subject: [PATCH v6 05/11] dt-bindings: net: dwmac-sun8i: update
 documentation about integrated PHY
In-Reply-To: <20170927073414.17361-6-clabbe.montjoie@gmail.com>
References: <20170927073414.17361-1-clabbe.montjoie@gmail.com>
 <20170927073414.17361-6-clabbe.montjoie@gmail.com>
Message-ID: <20170927140210.GE13516@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Corentin

> +Required properties for the mdio-mux node:
> +  - compatible = "mdio-mux"

This is too generic. Please add a more specific compatible for this
particular mux. You can keep "mdio-mux", since that is what the MDIO
subsystem will look for.

> +Required properties of the integrated phy node:
>  - clocks: a phandle to the reference clock for the EPHY
>  - resets: a phandle to the reset control for the EPHY
> +- phy-is-integrated

So the last thing you said is that the mux is not the problem
here. Something else is locking up. Did you discover what?

I really would like phy-is-integrated to go away.

  Andrew
