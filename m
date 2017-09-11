From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 11 Sep 2017 22:19:20 +0200
Subject: [PATCH v5 10/10] net: stmmac: dwmac-sun8i: Handle
 integrated/external MDIOs
In-Reply-To: <20170911190850.GA2291@Red>
References: <20170908071156.5115-1-clabbe.montjoie@gmail.com>
 <20170908071156.5115-11-clabbe.montjoie@gmail.com>
 <20170908130520.GA11248@lunn.ch> <20170908132632.GA3037@Red>
 <20170908140020.GC25219@lunn.ch> <20170908140832.GB3037@Red>
 <20170908141736.GF25219@lunn.ch> <20170908142825.GC3037@Red>
 <20170911161124.GD27599@lunn.ch> <20170911190850.GA2291@Red>
Message-ID: <20170911201920.GA5983@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Even with CLK_BUS_EPHY/RST_BUS_EPHY enabled, the MAC reset timeout.
> So no the CLK/RST are really for the PHY.

Thanks for trying that.

You said it was probably during scanning of the bus it times out. What
address is causing the timeout? 0 or 1? If the internal bus can only
have one PHY on it, maybe we need to set bus->phy_mask to 0x1?

   Andrew
