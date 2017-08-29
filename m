From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 29 Aug 2017 16:06:25 +0200
Subject: [PATCH v4 4/5] net: stmmac: dwmac-sun8i: choose internal PHY via
 phy-is-integrated
In-Reply-To: <20170829083432.GA28818@Red>
References: <20170826073311.25612-1-clabbe.montjoie@gmail.com>
 <20170826073311.25612-5-clabbe.montjoie@gmail.com>
 <20170826212051.GA10418@lunn.ch> <20170829083432.GA28818@Red>
Message-ID: <20170829140625.GA8235@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Do you agree that another mdio_mux_init() must be written ? (taking
> a of_node (in our case: mdio-mux) instead of a device)

Yes, you are correct, it is using dev->of_node. So you need to
refactor the code a little, to allow an of_node to be passed.

	 Andrew
