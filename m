From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Jul 2017 15:55:44 +0200
Subject: [PATCH 0/3] net-next: stmmac: support future possible different
 internal phy mode
In-Reply-To: <20170728092818.23419-1-clabbe.montjoie@gmail.com>
References: <20170728092818.23419-1-clabbe.montjoie@gmail.com>
Message-ID: <20170728135544.GD32230@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 28, 2017 at 11:28:15AM +0200, Corentin Labbe wrote:
> Hello
> 
> The current way to find if the phy is internal is to compare DT phy-mode
> and emac_variant/internal_phy.
> But it will negate a possible future SoC where an external PHY use the
> same phy mode than the internal one.
> 
> This patchs series adds a new way to find if the PHY is internal, via its
> compatible.

http://elixir.free-electrons.com/linux/latest/source/drivers/of/of_mdio.c#L144

Since you also have "ethernet-phy-ieee802.3-c22", you won't get the
warning. But still, your device tree gives the wrong idea.

I've probably asked this before: Does the internal PHY use a different
PHY ID in registers 2 and 3?

    Andrew
