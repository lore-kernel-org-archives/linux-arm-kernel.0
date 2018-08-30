From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 30 Aug 2018 05:44:02 +0200
Subject: [PATCH 4/5] net: mvneta: enable NETIF_F_RXCSUM by default
In-Reply-To: <20180830112745.61502abf@xhacker.debian>
References: <20180829162456.2bd69796@xhacker.debian>
 <20180829162932.6015e89d@xhacker.debian>
 <20180829130836.GD1955@lunn.ch>
 <20180830112745.61502abf@xhacker.debian>
Message-ID: <20180830034402.GE16896@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I've seen network interfaces get checksum'ing wrong when used with an
> > Ethernet switch with DSA. The extra header DSA uses means the hardware
> > cannot parse the packet correctly, and so cannot find these headers.
> 
> The network interface is mvneta?

I've not tested mvneta yet. It could be, since it was designed to be
used with Marvell switches in things like WiFi boxes, it knows how to
find the IP header when there is a DSA tag.

> Do you mean after this patch, we would see errors as the following?
> 
> "bad rx status 0xabcdefgh (crc error)"

I've not tried it yet. That is why i'm trying to understand what
NETIF_F_RXCSUM actually means.

       Andrew
