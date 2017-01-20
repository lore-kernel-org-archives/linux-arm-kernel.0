From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 20 Jan 2017 01:06:45 +0100
Subject: [PATCH v5 1/2] net: dsa: mv88e6xxx: Don't forbid MDIO I/Os for
 PHY addr >= num_of_ports
In-Reply-To: <871svylmvb.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
References: <20170119214934.27442-1-gregory.clement@free-electrons.com>
 <20170119214934.27442-2-gregory.clement@free-electrons.com>
 <871svylmvb.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
Message-ID: <20170120000645.GA31483@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 05:13:12PM -0500, Vivien Didelot wrote:
> Hi Gregory,
> 
> Gregory CLEMENT <gregory.clement@free-electrons.com> writes:
> 
> > From: Romain Perier <romain.perier@free-electrons.com>
> >
> > Some Marvell ethernet switches have internal ethernet transceivers with
> > hardcoded phy addresses. These addresses can be greater than the number
> > of ports or its value might be different than the associated port number.
> > This is for example the case for MV88E6341 that has 6 ports and internal
> > Port 1 to Port4 PHYs mapped at SMI addresses from 0x11 to 0x14.
> 
> Isn't there an hardware table used to map the PHY addresses on such chip?

The 6390 has something like this. But if we can avoid it, lets keep it
KISS.

	Andrew
