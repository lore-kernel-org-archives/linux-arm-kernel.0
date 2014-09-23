From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 23 Sep 2014 16:01:13 +0200
Subject: [PATCH v4 3/9] Documentation: bindings: net: add the Marvell
 PXA168 Ethernet controller
In-Reply-To: <51745791.Wuu5QiQB2e@wuerfel>
References: <1411474536-22626-1-git-send-email-antoine.tenart@free-electrons.com>
 <1411474536-22626-4-git-send-email-antoine.tenart@free-electrons.com>
 <51745791.Wuu5QiQB2e@wuerfel>
Message-ID: <20140923140113.GC18924@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Tue, Sep 23, 2014 at 02:38:39PM +0200, Arnd Bergmann wrote:
> On Tuesday 23 September 2014 14:15:30 Antoine Tenart wrote:
> > +Optional properties:
> > +- port-id: should be '0','1' or '2'.
> > +- phy-addr: MDIO address of the PHY.
> > +- local-mac-address: see ethernet.txt file in the same directory.
> > +
> > 
> 
> I believe new bindings should not use "phy-addr" properties, but
> instead use a phy-handle property pointing to a phy device instead.

That's the MDIO address of the PHY. It's a bit difficult to use a phy
device as the driver uses the libphy. And that would break the platform
using it.

Or maybe you have something in mind?

> 
> The port-id property description could be a little more verbose.
> What do those numbers actually mean?

I'll add some description. That's the Ethernet port number. I reused a
property (port-id) already used by other drivers.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
