From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Nov 2017 16:47:33 +0100
Subject: [PATCH] net: stmmac: dwmac-sun8i: fix allwinner,leds-active-low
 handling
In-Reply-To: <20171129153712.GA24881@lunn.ch>
References: <20171128164822.29218-1-clabbe.montjoie@gmail.com>
 <20171128173826.GE14512@lunn.ch> <20171129090240.GA3699@Red>
 <20171129153712.GA24881@lunn.ch>
Message-ID: <20171129154733.gersgylwvgrdam26@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 04:37:12PM +0100, Andrew Lunn wrote:
> On Wed, Nov 29, 2017 at 10:02:40AM +0100, Corentin Labbe wrote:
> > On Tue, Nov 28, 2017 at 06:38:26PM +0100, Andrew Lunn wrote:
> > > On Tue, Nov 28, 2017 at 05:48:22PM +0100, Corentin Labbe wrote:
> > > > The driver expect "allwinner,leds-active-low" to be in PHY node, but
> > > > the binding doc expect it to be in MAC node.
> > > > 
> > > > Since all board DT use it also in MAC node, the driver need to search
> > > > allwinner,leds-active-low in MAC node.
> > > 
> > > Hi Corentin
> > > 
> > > I'm having trouble working out how this worked before. This is code
> > > you moved around, when adding external/internal MDIOs. But the very
> > > first version of this driver code used priv->plat->phy_node. Did that
> > > somehow point to the MAC node when the internal PHY is used? Or has it
> > > been broken all the time?
> > > 
> > 
> > Hello
> > 
> 
> > Since this feature control only when the activity LED need to blink,
> > nobody see that it was broken.
> 
> Hi Corentin
> 
> So it never worked?
> 
> If it never worked, moving the DT properties into the PHY node, where
> they belong, won't introduce a regression :-)

That's even truer since it's been queued for 4.15 which hasn't been
released yet.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171129/36604533/attachment.sig>
