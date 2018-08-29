From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 29 Aug 2018 15:08:36 +0200
Subject: [PATCH 4/5] net: mvneta: enable NETIF_F_RXCSUM by default
In-Reply-To: <20180829162932.6015e89d@xhacker.debian>
References: <20180829162456.2bd69796@xhacker.debian>
 <20180829162932.6015e89d@xhacker.debian>
Message-ID: <20180829130836.GD1955@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2018 at 04:29:32PM +0800, Jisheng Zhang wrote:
> The code and HW supports NETIF_F_RXCSUM, so let's enable it by default.

Hi Jisheng

I've never studied what all these different flags mean. Does
NETIF_F_RXCSUM mean Ethernet FCS? Or does it also include IPv4, IPv6,
UDP, TCP... checksums?

I've seen network interfaces get checksum'ing wrong when used with an
Ethernet switch with DSA. The extra header DSA uses means the hardware
cannot parse the packet correctly, and so cannot find these headers.

If this is just for FCS, then it is not a problem.

   Thanks
	Andrew
