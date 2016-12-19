From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Dec 2016 15:56:06 +0100
Subject: [PATCH 2/4] net: dsa: mv88e6xxx: Don't forbid MDIO I/Os for PHY
 addr >= num_of_ports
In-Reply-To: <20161219141610.30934-3-romain.perier@free-electrons.com>
References: <20161219141610.30934-1-romain.perier@free-electrons.com>
 <20161219141610.30934-3-romain.perier@free-electrons.com>
Message-ID: <20161219145606.GD10048@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2016 at 03:16:07PM +0100, Romain Perier wrote:
> Some Marvell ethernet switches have internal ethernet transceivers with
> hardcoded phy addresses. These addresses can be grearer than the number
> of ports or its value might be different than the associated port number.
> This is for example the case for MV88E6341 that has 6 ports and internal
> Port 1 to Port4 PHYs mapped at SMI addresses from 0x11 to 0x14.
> 
> This commits fixes the issue by removing the condition in MDIO callbacks.
> 
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>

So it is not quite compatible with the 6352. Thanks Marvell :-(

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
