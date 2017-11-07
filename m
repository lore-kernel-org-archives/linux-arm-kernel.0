From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 7 Nov 2017 16:59:47 +0100
Subject: [PATCH] ARM: dts: add phy-reset property for rk3066a-rayeager emac
In-Reply-To: <e6f2393e-cb3b-9006-d0f5-6b30fd2a5192@mentor.com>
References: <1510022959-19440-1-git-send-email-zyw@rock-chips.com>
 <e6f2393e-cb3b-9006-d0f5-6b30fd2a5192@mentor.com>
Message-ID: <20171107155947.GC18410@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> As a side question, which is mainly addressed to Sergei and Roger,
> I don't quite understand why PHY properties were initially added to
> MAC/MDIO bus device tree nodes, in my opinion they must be moved under
> PHY device tree nodes.

If you look at the implementation, they are not actually PHY
properties. They are MDIO properties. It is the MDIO driver using them
to perform an 'MDIO bus reset'. The property names are wrong.

The device tree structure could be better. It mixes the MAC and the
MDIO properties in the same node. It would of been better to have
separate nodes. 

The MDIO core now has equivalent functionality. So yes, it would be
better to use the generic MDIO properties, not these driver
properties.

	 Andrew
