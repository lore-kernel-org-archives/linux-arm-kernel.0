From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 24 Jan 2017 21:28:47 +0100
Subject: [PATCH net-next v6 4/4] phy: marvell: Add support for the PHY
 embedded in the topaz switch
In-Reply-To: <f8526f4a5d99223fc90fe5579b4958eaa0950a3a.1485288602.git-series.gregory.clement@free-electrons.com>
References: <cover.b0e18efe751186768e720c341693117fdd4d3c16.1485288602.git-series.gregory.clement@free-electrons.com>
 <f8526f4a5d99223fc90fe5579b4958eaa0950a3a.1485288602.git-series.gregory.clement@free-electrons.com>
Message-ID: <20170124202847.GV10895@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 09:10:26PM +0100, Gregory CLEMENT wrote:
> The PHY with the ID 0x1410C00

:-(

I don't have a better reference, but
Linux/Documentation/devicetree/bindings/net/phy.txt says:

 22   If the phy's identifier is known then the list may contain an entry
 23   of the form: "ethernet-phy-idAAAA.BBBB" where
 24      AAAA - The value of the 16 bit Phy Identifier 1 register as
 25             4 hex digits. This is the chip vendor OUI bits 3:18
 26      BBBB - The value of the 16 bit Phy Identifier 2 register as
 27             4 hex digits. This is the chip vendor OUI bits 19:24,
 28             followed by 10 bits of a vendor specific ID.

So the lower 10 bits of 0x1410C00 are 0. So we know it is a Marvell
PHY from the OUI, but the vendor specific bits are all 0.

Please take a look at:

https://marc.info/?l=linux-netdev&m=148495522620757&w=1

and

https://marc.info/?l=linux-netdev&m=148495510320714&w=1

Maybe i should submit these two independently, so you can extend it
for the 88E6341 family.

    Andrew
