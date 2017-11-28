From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 28 Nov 2017 18:38:26 +0100
Subject: [PATCH] net: stmmac: dwmac-sun8i: fix allwinner,leds-active-low
 handling
In-Reply-To: <20171128164822.29218-1-clabbe.montjoie@gmail.com>
References: <20171128164822.29218-1-clabbe.montjoie@gmail.com>
Message-ID: <20171128173826.GE14512@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 05:48:22PM +0100, Corentin Labbe wrote:
> The driver expect "allwinner,leds-active-low" to be in PHY node, but
> the binding doc expect it to be in MAC node.
> 
> Since all board DT use it also in MAC node, the driver need to search
> allwinner,leds-active-low in MAC node.

Hi Corentin

I'm having trouble working out how this worked before. This is code
you moved around, when adding external/internal MDIOs. But the very
first version of this driver code used priv->plat->phy_node. Did that
somehow point to the MAC node when the internal PHY is used? Or has it
been broken all the time?

	Andrew
