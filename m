From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Sep 2016 23:13:33 +0200
Subject: [PATCH 6/8 v2] arm: orion5x: Add DT-based support for Netgear
 WNR854T
In-Reply-To: <20160912170625.GA7420@rob-hp-laptop>
References: <1472203264-21089-7-git-send-email-jm@lentin.co.uk>
 <1473109646-23366-1-git-send-email-jm@lentin.co.uk>
 <20160912170625.GA7420@rob-hp-laptop>
Message-ID: <2920481.EgEQnLmOkM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 12, 2016 12:06:25 PM CEST Rob Herring wrote:
> On Mon, Sep 05, 2016 at 10:07:26PM +0100, Jamie Lentin wrote:
> > This is a router based on the mv88f5181 chipset.
> > 
> > http://www.netgear.com/support/product/WNR854T.aspx
> > http://wiki.openwrt.org/toh/netgear/wnr854t
> > 
> > Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> > ---
> > This removes the contentious vendor partitioning scheme and goes back
> > to the original partitioning scheme used in non-DT ports to this board.
> > Using the same partitioning scheme should mean less surprises for
> > someone trying to upgrade their router.
> > 
> > The non-DT PCI setup is still here, as there are other orion5x DT boards
> > doing very similar things, and can all be converted at the same time.
> 
> If we keep accepting this duplicated, legacy PCI setup, who is going to 
> be motivated to clean things up. But it's ultimately up to Arnd and 
> Olof.
> 

I mentioned before that I'm feeling a bit uneasy about this too.

Maybe we can instead leave out the PCI support from the new
file for now and not delete the legacy board file?

	Arnd
