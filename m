From: vivien.didelot@savoirfairelinux.com (Vivien Didelot)
Date: Thu, 19 Jan 2017 17:13:12 -0500
Subject: [PATCH v5 1/2] net: dsa: mv88e6xxx: Don't forbid MDIO I/Os for
 PHY addr >= num_of_ports
In-Reply-To: <20170119214934.27442-2-gregory.clement@free-electrons.com>
References: <20170119214934.27442-1-gregory.clement@free-electrons.com>
 <20170119214934.27442-2-gregory.clement@free-electrons.com>
Message-ID: <871svylmvb.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

Gregory CLEMENT <gregory.clement@free-electrons.com> writes:

> From: Romain Perier <romain.perier@free-electrons.com>
>
> Some Marvell ethernet switches have internal ethernet transceivers with
> hardcoded phy addresses. These addresses can be greater than the number
> of ports or its value might be different than the associated port number.
> This is for example the case for MV88E6341 that has 6 ports and internal
> Port 1 to Port4 PHYs mapped at SMI addresses from 0x11 to 0x14.

Isn't there an hardware table used to map the PHY addresses on such chip?

> This commits fixes the issue by removing the condition in MDIO callbacks.
>
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

The patch is anyway still valid:

Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Thanks,

        Vivien
