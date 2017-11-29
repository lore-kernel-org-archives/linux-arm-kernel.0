From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 29 Nov 2017 16:37:12 +0100
Subject: [PATCH] net: stmmac: dwmac-sun8i: fix allwinner,leds-active-low
 handling
In-Reply-To: <20171129090240.GA3699@Red>
References: <20171128164822.29218-1-clabbe.montjoie@gmail.com>
 <20171128173826.GE14512@lunn.ch> <20171129090240.GA3699@Red>
Message-ID: <20171129153712.GA24881@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 10:02:40AM +0100, Corentin Labbe wrote:
> On Tue, Nov 28, 2017 at 06:38:26PM +0100, Andrew Lunn wrote:
> > On Tue, Nov 28, 2017 at 05:48:22PM +0100, Corentin Labbe wrote:
> > > The driver expect "allwinner,leds-active-low" to be in PHY node, but
> > > the binding doc expect it to be in MAC node.
> > > 
> > > Since all board DT use it also in MAC node, the driver need to search
> > > allwinner,leds-active-low in MAC node.
> > 
> > Hi Corentin
> > 
> > I'm having trouble working out how this worked before. This is code
> > you moved around, when adding external/internal MDIOs. But the very
> > first version of this driver code used priv->plat->phy_node. Did that
> > somehow point to the MAC node when the internal PHY is used? Or has it
> > been broken all the time?
> > 
> 
> Hello
> 

> Since this feature control only when the activity LED need to blink,
> nobody see that it was broken.

Hi Corentin

So it never worked?

If it never worked, moving the DT properties into the PHY node, where
they belong, won't introduce a regression :-)

     Andrew
