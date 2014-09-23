From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Sep 2014 16:33:48 +0200
Subject: [PATCH v4 3/9] Documentation: bindings: net: add the Marvell
 PXA168 Ethernet controller
In-Reply-To: <20140923140113.GC18924@kwain>
References: <1411474536-22626-1-git-send-email-antoine.tenart@free-electrons.com>
 <51745791.Wuu5QiQB2e@wuerfel> <20140923140113.GC18924@kwain>
Message-ID: <3708177.kEGF9Dk44n@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 September 2014 16:01:13 Antoine Tenart wrote:
> 
> On Tue, Sep 23, 2014 at 02:38:39PM +0200, Arnd Bergmann wrote:
> > On Tuesday 23 September 2014 14:15:30 Antoine Tenart wrote:
> > > +Optional properties:
> > > +- port-id: should be '0','1' or '2'.
> > > +- phy-addr: MDIO address of the PHY.
> > > +- local-mac-address: see ethernet.txt file in the same directory.
> > > +
> > > 
> > 
> > I believe new bindings should not use "phy-addr" properties, but
> > instead use a phy-handle property pointing to a phy device instead.
> 
> That's the MDIO address of the PHY. It's a bit difficult to use a phy
> device as the driver uses the libphy. And that would break the platform
> using it.
> 
> Or maybe you have something in mind?

I don't understand what you mean. Doesn't libphy imply using a phy_device?
What I meant was that you should be able to just call the standard
of_phy_connect() and other interfaces to deal with phylib.

	Arnd
